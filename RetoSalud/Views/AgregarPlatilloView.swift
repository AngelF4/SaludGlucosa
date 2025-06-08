//
//  AgregarPlatilloView.swift
//  RetoSalud
//
//  Created by Angel HG on 07/06/25.
//

import SwiftUI
import PhotosUI

struct AgregarPlatilloView: View {
    @EnvironmentObject var viewModel: MenuViewModel
    @State private var showingCamera = false
    @State private var selectedItems: [PhotosPickerItem] = []
    @StateObject private var classifierViewModel = ClassifierViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // Sección de comida actual si hay alimentos seleccionados
                    if !viewModel.selectedFoods.isEmpty {
                        currentMealSection
                    }
                    
                    // Categorías de platillos
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
            }
            .navigationTitle("Agregar platillo")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    PhotosPicker(
                        selection: $selectedItems,
                        maxSelectionCount: 10,
                        matching: .images
                    ) {
                        Image(systemName: "camera.fill")
                            .foregroundStyle(.pink)
                    }
                }
            }
        }
        .onChange(of: selectedItems) { newItems in
            Task {
                classifierViewModel.imageDatas = []
                classifierViewModel.alimentos = []
                classifierViewModel.resultadoIG = nil
                classifierViewModel.seIntentoOrdenar = false

                for item in newItems {
                    if let data = try? await item.loadTransferable(type: Data.self),
                       let url = await classifierViewModel.saveToTemporaryDirectory(data) {
                        classifierViewModel.imageDatas.append((data, url))
                    }
                }

                await classifierViewModel.processImages()

                for imageFile in classifierViewModel.alimentos {
                    viewModel.addFoodToMeal(imageFile.name)
                }

                // Mostrar orden óptimo automáticamente
                viewModel.generateOptimalOrder()
            }
        }
        .sheet(item: $viewModel.selectedDish) { dish in
            DishDetailView(dish: dish, viewModel: viewModel)
        }
        .sheet(isPresented: $viewModel.showingOptimalOrder) {
            OptimalOrderView(recommendations: viewModel.eatingRecommendations)
        }
    }
    
    private var currentMealSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("🍽️ Tu comida actual")
                    .font(.headline)
                    .foregroundStyle(.pink)
                
                Spacer()
                
                Button("Limpiar") {
                    viewModel.clearMeal()
                }
                .foregroundStyle(.pink)
                .font(.caption)
            }
            .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(viewModel.selectedFoods) { food in
                        FoodChipView(food: food) {
                            viewModel.removeFoodFromMeal(food)
                        }
                    }
                }
                .padding(.horizontal)
            }
            
            HStack {
                Button("Ver orden óptimo") {
                    viewModel.generateOptimalOrder()
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(.pink.opacity(0.2))
                .foregroundStyle(.pink)
                .cornerRadius(8)
                
                Spacer()
                
                let totalImpact = viewModel.calculateTotalImpact()
                Text("Impacto: ~\(totalImpact) mg/dl")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .padding(.horizontal)
        }
        .padding(.vertical, 12)
        .background(.pink.opacity(0.05))
        .cornerRadius(12)
        .padding(.horizontal)
    }
}

struct FoodChipView: View {
    let food: FoodItem
    let onRemove: () -> Void
    
    var body: some View {
        HStack(spacing: 4) {
            Text(food.name)
                .font(.caption)
                .lineLimit(1)
            
            Button {
                onRemove()
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(levelColor(for: food.glycemicLevel))
        .cornerRadius(12)
    }
    
    private func levelColor(for level: GlycemicLevel) -> Color {
        switch level {
        case .low: return .green.opacity(0.2)
        case .medium: return .orange.opacity(0.2)
        case .high: return .red.opacity(0.2)
        }
    }
}

struct CameraPlaceholderView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Image(systemName: "camera.fill")
                    .font(.system(size: 80))
                    .foregroundStyle(.pink)
                
                Text("Cámara para análisis")
                    .font(.title2)
                    .bold()
                
                Text("Aquí se integrará Vision Framework para detectar alimentos y calcular su índice glucémico automáticamente")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal)
                
                Spacer()
            }
            .padding()
            .navigationTitle("Análisis Visual")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cerrar") {
                        dismiss()
                    }
                    .foregroundStyle(.pink)
                }
            }
        }
    }
}

struct OptimalOrderView: View {
    let recommendations: [String]
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    ForEach(Array(recommendations.enumerated()), id: \.offset) { index, recommendation in
                        if index == 0 {
                            Text(recommendation)
                                .font(.headline)
                                .foregroundStyle(.pink)
                                .padding(.horizontal)
                        } else if recommendation.contains("💡") {
                            HStack {
                                Text("💡")
                                    .font(.title2)
                                Text(recommendation.replacingOccurrences(of: "💡 ", with: ""))
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                            .background(.pink.opacity(0.1))
                            .cornerRadius(8)
                            .padding(.horizontal)
                        } else {
                            HStack(alignment: .top, spacing: 12) {
                                if recommendation.contains("⚠️") {
                                    Text("⚠️")
                                        .font(.title3)
                                } else {
                                    Text("✅")
                                        .font(.title3)
                                }
                                
                                Text(recommendation.replacingOccurrences(of: "⚠️ ", with: ""))
                                    .font(.body)
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                        
                        if index < recommendations.count - 1 && index > 0 && !recommendations[index + 1].contains("💡") {
                            Divider()
                                .padding(.horizontal)
                        }
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("Orden Óptimo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cerrar") {
                        dismiss()
                    }
                    .foregroundStyle(.pink)
                }
            }
        }
    }
}

// MARK: - Preview
#Preview {
    AgregarPlatilloView()
}
