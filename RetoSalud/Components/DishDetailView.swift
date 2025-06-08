//
//  DishDetailView.swift
//  RetoSalud
//
//  Created by Angel HG on 07/06/25.
//

import SwiftUI

struct DishDetailView: View {
    @State private var dish: Dish

    init(dish: Dish) {
        _dish = State(initialValue: dish)
    }

    var body: some View {
        ScrollView {
            AsyncImage(url: dish.imageURL) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(12)
                    .padding()
            } placeholder: {
                Color.gray.opacity(0.3)
            }
            .frame(width: 150, height: 100)
            .clipped()
                

            VStack(alignment: .leading, spacing: 16) {
                Text(dish.name)
                    .font(.title2)
                    .bold()

                Text("\(dish.calories) calorías")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Divider()

                Text("Cómo afectaría al índice glucémico")
                    .font(.headline)

                ForEach(dish.glycemicEffects, id: \.self) { effect in
                    HStack(alignment: .top) {
                        Text("•")
                        Text(effect)
                    }
                }

                Button(action: {
                    let included = dish.ingredients.filter(\.isSelected)
                    print("Ingredientes incluidos: \(included)")
                }) {
                    Text("+ Añadir alimento")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.pink.opacity(0.2))
                        .cornerRadius(8)
                }

                Divider()

                Text("Ingredientes")
                    .font(.headline)
                Text("Por una porcion de 100g")

                ForEach($dish.ingredients) { $ingredient in
                    IngredientRowView(ingredient: $ingredient)
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    DishDetailView(dish: Dish(name: "Tacos de media noche", imageURL: URL(string: "https://cdn.pixabay.com/photo/2020/07/09/19/53/ensalada-5388581_1280.jpg")!, calories: 200, description: "Unos tacos bien ricos", glycemicEffects: ["Uno", "Dos"], ingredients: [Ingredient(name: "Zzanahoria", emoji: "🥕", portion: "150"),
                                                                                                                                                                                   Ingredient(name: "Tortilla", emoji: "🌮", portion: "200")
                                                                                                                                                                                  ]))
}
