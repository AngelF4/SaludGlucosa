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
            AsyncImage(url: dish.imageURL) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .padding()
            } placeholder: {
                Color.gray.opacity(0.3)
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
