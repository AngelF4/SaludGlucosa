//
//  classifier.swift
//  RetoSalud
//
//  Created by Alejandro on 07/06/25.
//

import Foundation
import Vision
import UIKit

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
