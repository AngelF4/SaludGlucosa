//
//  Category.swift
//  RetoSalud
//
//  Created by Angel HG on 07/06/25.
//

import Foundation

struct Category: Identifiable {
    let id = UUID()
    let name: String
    let dishes: [Dish]
}
