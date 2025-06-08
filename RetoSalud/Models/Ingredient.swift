//
//  Ingredient.swift
//  RetoSalud
//
//  Created by Angel HG on 07/06/25.
//

import Foundation

struct Ingredient: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let emoji: String
    let portion: String
    var isSelected: Bool = true
}
