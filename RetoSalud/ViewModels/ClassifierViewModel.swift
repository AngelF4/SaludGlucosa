//
//  ClassifierViewModel.swift
//  RetoSalud
//
//  Created by Alejandro on 08/06/25.
//

import SwiftUI
import Vision
import PhotosUI

@MainActor
class ClassifierViewModel: ObservableObject {
    @Published var imageDatas: [(data: Data, url: URL)] = []
    @Published var alimentos: [ImageFile] = []
    @Published var resultadoIG: Int?
    @Published var seIntentoOrdenar = false
    @Published var observacionesSinIG: [(nombre: String, confianza: Double)] = []

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

    func processImages() async {
        var temp: [ImageFile] = []
        var sinIG: [(String, Double)] = []

        for (data, url) in imageDatas {
            guard let image = UIImage(data: data),
                  let cgImage = image.cgImage else { continue }

            let request = VNClassifyImageRequest()
            let handler = VNImageRequestHandler(cgImage: cgImage)

            do {
                try handler.perform([request])
                if let results = request.results {
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
            let prioridad: [TipoAlimento: Int] = [.fibra: 0, .proteina: 1, .carbohidrato: 2]
            
            let p1 = prioridad[tipo1, default: 3]
            let p2 = prioridad[tipo2, default: 3]
            
            if p1 != p2 {
                return p1 < p2
            } else {
                return $0.ig < $1.ig // Desempate por menor índice glucémico
            }
        }
        alimentos = ordenados
        resultadoIG = ordenados.isEmpty ? nil : ordenados.map { $0.ig }.reduce(0, +) / ordenados.count
        observacionesSinIG = ordenados.isEmpty ? sinIG : []
        seIntentoOrdenar = true
    }
    
    func classifyImage(from image: UIImage, url: URL) async -> ImageFile? {
        guard let cgImage = image.cgImage else { return nil }

        let request = VNClassifyImageRequest()
        let handler = VNImageRequestHandler(cgImage: cgImage)

        do {
            try handler.perform([request])
            if let results = request.results {
                for result in results where result.confidence > 0.5 {
                    let id = result.identifier.lowercased()

                    if let traducido = traducciones[id],
                       let ig = igDictionary[traducido] {
                        return ImageFile(name: traducido.capitalized, url: url, ig: ig)
                    }
                }
            }
        } catch {
            print("Error clasificando imagen: \(error)")
        }

        return nil
    }
}
