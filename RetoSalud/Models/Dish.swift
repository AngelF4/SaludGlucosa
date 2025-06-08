//
//  Dish.swift
//  RetoSalud
//
//  Created by Angel HG on 07/06/25.
//

import Foundation

struct Dish: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
    let calories: Int
    let description: String
    let glycemicEffects: [String]
    var ingredients: [Ingredient]
}
