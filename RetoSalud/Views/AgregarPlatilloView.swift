//
//  AgregarPlatilloView.swift
//  RetoSalud
//
//  Created by Angel HG on 07/06/25.
//

import SwiftUI

struct AgregarPlatilloView: View {
    @StateObject private var viewModel = MenuViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    ForEach(viewModel.categories) { category in
                        Text(category.name)
                            .font(.headline)
                            .padding(.horizontal)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(category.dishes) { dish in
                                    DishCardView(dish: dish)
                                        .onTapGesture {
                                            viewModel.selectedDish = dish
                                        }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                .navigationTitle("Agregar platillo")
            }
            .sheet(item: $viewModel.selectedDish) { dish in
                DishDetailView(dish: dish)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    AgregarPlatilloView()
}
