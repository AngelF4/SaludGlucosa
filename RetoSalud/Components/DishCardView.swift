//
//  DishCardView.swift
//  RetoSalud
//
//  Created by Angel HG on 07/06/25.
//

import SwiftUI

struct DishCardView: View {
    let dish: Dish

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            AsyncImage(url: URL(string: dish.imageURL ?? "default valuestring: String")) { image in
                image
                    .resizable()
                    .scaledToFill() // 🔁 Se adapta al tamaño del contenedor
            } placeholder: {
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .overlay(
                        Image(systemName: "photo")
                            .font(.largeTitle)
                            .foregroundStyle(.gray)
                    )
            }
            .frame(width: 250, height: 150)
            .clipped()
            .cornerRadius(12)

            VStack(alignment: .leading, spacing: 4) {
                Text(dish.name)
                    .font(.headline)
                    .foregroundColor(.white)
                Text("\(dish.calories) calorías")
                    .font(.subheadline)
                    .foregroundColor(.white)
            }
            .padding(8)
            .background(Color.black.opacity(0.4))
            .cornerRadius(8)
            .padding(8)
        }
    }
}
