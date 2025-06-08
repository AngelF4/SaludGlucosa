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
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                ForEach(viewModel.categories) { category in
                    Text(category.name)
                        .font(.headline)
                        .padding(.horizontal)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(category.dishes) { dish in
                                VStack(alignment: .leading, spacing: 8) {
                                    AsyncImage(url: dish.imageURL) { phase in
                                        switch phase {
                                        case .empty:
                                            ZStack {
                                                Color.gray.opacity(0.3)
                                                ProgressView()
                                            }
                                            .frame(width: 150, height: 100)
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 200, height: 100)
                                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                        case .failure:
                                            ZStack {
                                                Color.gray.opacity(0.3)
                                                Image(systemName: "photo")
                                                    .font(.largeTitle)
                                                    .foregroundColor(.white)
                                            }
                                            .frame(width: 150, height: 100)
                                        @unknown default:
                                            EmptyView()
                                        }
                                    }
                                    Text(dish.name)
                                        .font(.headline)
                                    Text("\(dish.calories) kcal")
                                        .font(.subheadline)
                                    Text(dish.description)
                                        .font(.caption)
                                        .lineLimit(2)
                                        .frame(width: 200)
                                }
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 8).fill(Color(.systemBackground)).shadow(radius: 2))
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

// MARK: - Preview

#Preview {
    NavigationStack {
        AgregarPlatilloView()
    }
}
