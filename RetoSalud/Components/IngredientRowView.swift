//
//  IngredientRowView.swift
//  RetoSalud
//
//  Created by Angel HG on 07/06/25.
//

import SwiftUI

struct IngredientRowView: View {
    @Binding var ingredient: Ingredient

    var body: some View {
        HStack {
            Button {
                ingredient.isSelected.toggle()
            } label: {
                Image(systemName: ingredient.isSelected ? "checkmark.square" : "square")
                    .font(.title3)
            }
            Text(ingredient.emoji)
                .font(.largeTitle)
            Text(ingredient.name)
            Spacer()
            Text(ingredient.portion)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    @Previewable @State var ingrediente = Ingredient(name: "Zanahoria", emoji: "🥕", portion: "100")
    IngredientRowView(ingredient: $ingrediente)
}
