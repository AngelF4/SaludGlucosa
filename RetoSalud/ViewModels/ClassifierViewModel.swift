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
                        let clave = traducciones[id] ?? {
                            if let similar = buscarTraduccionSimilar(id) {
                                return traducciones[similar]
                            }
                            return nil
                        }()

                        if let traducido = clave,
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

        let _: [TipoAlimento: Int] = [.fibra: 0, .proteina: 1, .carbohidrato: 2]

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

func buscarTraduccionSimilar(_ id: String) -> String? {
    let idLower = id.lowercased()
    var mejorCoincidencia: String?
    var distanciaMinima = Int.max

    for clave in traducciones.keys {
        let distancia = levenshtein(idLower, clave)
        if distancia < distanciaMinima && distancia <= 2 { // ajusta el umbral si deseas
            distanciaMinima = distancia
            mejorCoincidencia = clave
        }
    }

    return mejorCoincidencia
}

func ordenarAlimentosPorPrioridad(_ alimentos: [FoodItem]) -> [FoodItem] {
    let prioridad: [TipoAlimento: Int] = [.fibra: 0, .proteina: 1, .carbohidrato: 2]
    
    return alimentos.sorted {
        let tipo1 = tipoAlimento[$0.name.lowercased()] ?? .carbohidrato
        let tipo2 = tipoAlimento[$1.name.lowercased()] ?? .carbohidrato

        let p1 = prioridad[tipo1, default: 3]
        let p2 = prioridad[tipo2, default: 3]

        if p1 != p2 {
            return p1 < p2
        } else {
            return $0.baseIncrease < $1.baseIncrease 
        }
    }
}

func levenshtein(_ aStr: String, _ bStr: String) -> Int {
    let a = Array(aStr)
    let b = Array(bStr)

    var dist = [[Int]](repeating: [Int](repeating: 0, count: b.count + 1), count: a.count + 1)

    for i in 0...a.count {
        dist[i][0] = i
    }
    for j in 0...b.count {
        dist[0][j] = j
    }

    for i in 1...a.count {
        for j in 1...b.count {
            if a[i - 1] == b[j - 1] {
                dist[i][j] = dist[i - 1][j - 1]
            } else {
                dist[i][j] = min(
                    dist[i - 1][j] + 1,
                    dist[i][j - 1] + 1,
                    dist[i - 1][j - 1] + 1
                )
            }
        }
    }

    return dist[a.count][b.count]
}
