//
//  ImageFile.swift
//  RetoSalud
//
//  Created by Alejandro on 07/06/25.
//

import Foundation

struct ImageFile: Identifiable {
    let id = UUID()
    let name: String       // Ej. "Aguacate"
    let url: URL           // Imagen original
    let ig: Int            // Índice glucémico
}
