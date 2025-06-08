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
    @StateObject private var viewModel = ClassifierViewModel()
    @State private var selectedItems: [PhotosPickerItem] = []

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                PhotosPicker("Seleccionar imágenes", selection: $selectedItems, maxSelectionCount: 10, matching: .images)
                    .onChange(of: selectedItems) { newItems in
                        Task {
                            viewModel.imageDatas = []
                            viewModel.alimentos = []
                            viewModel.resultadoIG = nil
                            viewModel.seIntentoOrdenar = false

                            for item in newItems {
                                if let data = try? await item.loadTransferable(type: Data.self),
                                   let url = await viewModel.saveToTemporaryDirectory(data) {
                                    viewModel.imageDatas.append((data, url))
                                }
                            }
                        }
                    }

                Button("Procesar alimentos") {
                    Task {
                        await viewModel.processImages()
                    }
                }
                .disabled(viewModel.imageDatas.isEmpty)
                .buttonStyle(.borderedProminent)

                if !viewModel.alimentos.isEmpty {
                    List {
                        Section(header: Text("🧠 Orden nutricional sugerido (fibra → proteína → carbohidrato)")) {
                            ForEach(viewModel.alimentos) { alimento in
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

                        if let promedio = viewModel.resultadoIG {
                            Section {
                                Text("✅ IG promedio del conjunto: \(promedio)")
                                    .font(.headline)
                            }
                        }
                    }
                } else if viewModel.seIntentoOrdenar {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("❌ No se pudo ordenar. No se detectaron alimentos con índice glucémico.")
                            .foregroundColor(.red)

                        if !viewModel.observacionesSinIG.isEmpty {
                            Text("🔍 Observaciones encontradas con alta confianza:")
                                .font(.headline)
                                .padding(.top, 8)

                            ForEach(viewModel.observacionesSinIG, id: \.nombre) { obs in
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
}

#Preview {
    TestView()
}
