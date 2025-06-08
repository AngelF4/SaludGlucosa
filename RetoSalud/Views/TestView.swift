//
//  TestView.swift
//  RetoSalud
//
//  Created by Alejandro on 07/06/25.
//

import SwiftUI
import PhotosUI
import Vision

struct TestView: View {
    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var imageDatas: [(data: Data, url: URL)] = []
    @State private var alimentos: [ImageFile] = []
    @State private var resultadoIG: Int?
    @State private var seIntentoOrdenar = false // ← Añadido
    @State private var observacionesSinIG: [(nombre: String, confianza: Double)] = []
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                PhotosPicker("Seleccionar imágenes", selection: $selectedItems, maxSelectionCount: 10, matching: .images)
                    .onChange(of: selectedItems) { newItems in
                        Task {
                            imageDatas = []
                            alimentos = []
                            resultadoIG = nil
                            seIntentoOrdenar = false
                            for item in newItems {
                                if let data = try? await item.loadTransferable(type: Data.self),
                                   let url = await saveToTemporaryDirectory(data) {
                                    imageDatas.append((data, url))
                                }
                            }
                        }
                    }

                Button("Procesar alimentos") {
                    Task {
                        await procesarImagenes()
                    }
                }
                .disabled(imageDatas.isEmpty)
                .buttonStyle(.borderedProminent)

                if !alimentos.isEmpty {
                    List {
                        Section(header: Text("🧠 Orden nutricional sugerido (fibra → proteína → carbohidrato)")) {
                            ForEach(alimentos) { alimento in
                                HStack {
                                    AsyncImage(url: alimento.url) { image in
                                        image.resizable()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .frame(width: 60, height: 60)
                                    .clipShape(.rect(cornerRadius: 6))

                                    VStack(alignment: .leading) {
                                        Text(alimento.name)
                                        Text("IG: \(alimento.ig)")
                                            .foregroundColor(.secondary)
                                    }
                                }
                            }
                        }

                        if let promedio = resultadoIG {
                            Section {
                                Text("✅ IG promedio del conjunto: \(promedio)")
                                    .font(.headline)
                            }
                        }
                    }
                } else if seIntentoOrdenar {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("❌ No se pudo ordenar. No se detectaron alimentos con índice glucémico.")
                            .foregroundColor(.red)

                        if !observacionesSinIG.isEmpty {
                            Text("🔍 Observaciones encontradas con alta confianza:")
                                .font(.headline)
                                .padding(.top, 8)

                            ForEach(observacionesSinIG, id: \.nombre) { obs in
                                Text("• \(obs.nombre): \(obs.confianza, specifier: "%.2f")")
                                    .font(.subheadline)
                            }
                        }
                    }
                    .padding()
                }
            }
            .padding()
            .navigationTitle("Índice Glucémico")
        }
    }

    func saveToTemporaryDirectory(_ data: Data) async -> URL? {
        let fileName = UUID().uuidString + ".jpg"
        let url = FileManager.default.temporaryDirectory.appendingPathComponent(fileName)
        do {
            try data.write(to: url)
            return url
        } catch {
            return nil
        }
    }

    func procesarImagenes() async {
        var temp: [ImageFile] = []
        var sinIG: [(String, Double)] = []

        for (data, url) in imageDatas {
            guard let image = UIImage(data: data),
                  let cgImage = image.cgImage else { continue }

            let request = VNClassifyImageRequest()
            let handler = VNImageRequestHandler(cgImage: cgImage)

            do {
                try handler.perform([request])
                if let results = request.results as? [VNClassificationObservation] {
                    var clasificado = false
                    for result in results where result.confidence > 0.5 {
                        let id = result.identifier.lowercased()
                        if let traducido = traducciones[id],
                           let ig = igDictionary[traducido] {
                            let file = ImageFile(name: traducido.capitalized, url: url, ig: ig)
                            temp.append(file)
                            clasificado = true
                            break
                        } else {
                            sinIG.append((id.capitalized, Double(result.confidence)))
                        }
                    }

                    // Si no se clasificó con IG, pero hubo predicciones > 0.5, las guardamos
                    if !clasificado {
                        continue
                    }
                }
            } catch {
                print("Error clasificando imagen: \(error)")
            }
        }

        let prioridad: [TipoAlimento: Int] = [.fibra: 0, .proteina: 1, .carbohidrato: 2]

        let ordenados = temp.sorted {
            let tipo1 = tipoAlimento[$0.name.lowercased()] ?? .carbohidrato
            let tipo2 = tipoAlimento[$1.name.lowercased()] ?? .carbohidrato
            return prioridad[tipo1, default: 3] < prioridad[tipo2, default: 3]
        }
        alimentos = ordenados
        resultadoIG = ordenados.isEmpty ? nil : ordenados.map { $0.ig }.reduce(0, +) / ordenados.count
        observacionesSinIG = ordenados.isEmpty ? sinIG : [] // solo mostrar si no hay resultados válidos
        seIntentoOrdenar = true
    }
}

#Preview {
    TestView()
}
