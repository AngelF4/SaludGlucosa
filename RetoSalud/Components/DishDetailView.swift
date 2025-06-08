//
//  DishDetailView.swift
//  RetoSalud
//
//  Created by Angel HG on 07/06/25.
//

import SwiftUI

struct DishDetailView: View {
    @State private var dish: Dish
    let viewModel: MenuViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var showingSuccessAlert = false
    
    init(dish: Dish, viewModel: MenuViewModel) {
        _dish = State(initialValue: dish)
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // Imagen del platillo
                    dishImageSection
                    
                    VStack(alignment: .leading, spacing: 16) {
                        // Información básica
                        dishInfoSection
                        
                        Divider()
                        
                        // Efectos glucémicos
                        glycemicEffectsSection
                        
                        // Botón para agregar
                        addDishButton
                        
                        Divider()
                        
                        // Ingredientes
                        ingredientsSection
                        
                        // Impacto glucémico calculado
                        calculatedImpactSection
                    }
                    .padding(.horizontal)
                }
            }
            .navigationTitle(dish.name)
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cerrar") {
                        dismiss()
                    }
                    .foregroundStyle(.pink)
                }
            }
        }
        .alert("¡Agregado!", isPresented: $showingSuccessAlert) {
            Button("OK") { }
        } message: {
            Text("El platillo ha sido agregado a tu comida actual")
        }
    }
    
    private var dishImageSection: some View {
        AsyncImage(url: URL(string: dish.imageURL ?? "default value")) { image in
            image
                .resizable()
                .scaledToFill()
        } placeholder: {
            Rectangle()
                .fill(.pink.opacity(0.1))
                .overlay {
                    Image(systemName: "photo")
                        .font(.largeTitle)
                        .foregroundStyle(.pink.opacity(0.5))
                }
        }
        .frame(height: 200)
        .cornerRadius(12)
        .padding(.horizontal)
    }
    
    private var dishInfoSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(dish.name)
                .font(.title2)
                .bold()
                .foregroundStyle(.primary)
            
            HStack {
                Label("\(dish.calories) calorías", systemImage: "flame.fill")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                Spacer()
                
                // Indicador de nivel glucémico basado en el platillo
                glycemicLevelIndicator
            }
            
            if !dish.description.isEmpty {
                Text(dish.description)
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .padding(.top, 4)
            }
        }
    }
    
    private var glycemicLevelIndicator: some View {
        HStack(spacing: 4) {
            Circle()
                .fill(getGlycemicColor())
                .frame(width: 8, height: 8)
            
            Text(getGlycemicLevelText())
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
    
    private var glycemicEffectsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Cómo afectaría al índice glucémico")
                .font(.headline)
                .foregroundStyle(.pink)
            
            ForEach(dish.glycemicEffects, id: \.self) { effect in
                HStack(alignment: .top, spacing: 8) {
                    Text("•")
                        .foregroundStyle(.pink)
                        .bold()
                    Text(effect)
                        .font(.body)
                        .foregroundStyle(.primary)
                    Spacer()
                }
            }
        }
    }
    
    private var addDishButton: some View {
        Button(action: addDishToMeal) {
            HStack {
                Image(systemName: "plus.circle.fill")
                Text("Añadir a mi comida")
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(.pink.opacity(0.2))
            .foregroundStyle(.pink)
            .cornerRadius(12)
            .font(.body.weight(.medium))
        }
    }
    
    private var ingredientsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Ingredientes")
                .font(.headline)
                .foregroundStyle(.pink)
            
            Text("Por una porción de 100g")
                .font(.caption)
                .foregroundStyle(.secondary)
            
            VStack(spacing: 8) {
                ForEach($dish.ingredients) { $ingredient in
                    IngredientRowView(ingredient: $ingredient)
                        .background(ingredient.isSelected ? .clear : .gray.opacity(0.1))
                        .cornerRadius(8)
                        .animation(.easeInOut(duration: 0.2), value: ingredient.isSelected)
                }
            }
        }
    }
    
    private var calculatedImpactSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Impacto glucémico estimado")
                .font(.headline)
                .foregroundStyle(.pink)
            
            let impact = calculateAdjustedGlycemicImpact()
            let originalImpact = getOriginalGlycemicImpact()
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Con ingredientes seleccionados:")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text("\(impact.0)-\(impact.1) mg/dl")
                        .font(.title3)
                        .bold()
                        .foregroundStyle(.pink)
                }
                
                Spacer()
                
                if impact.0 < originalImpact.0 {
                    VStack(alignment: .trailing) {
                        Text("Reducción:")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Text("-\(originalImpact.0 - impact.0) mg/dl")
                            .font(.caption)
                            .bold()
                            .foregroundStyle(.green)
                    }
                }
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(.pink.opacity(0.05))
            .cornerRadius(8)
            
            if dish.ingredients.contains(where: { !$0.isSelected }) {
                Text("💡 Al deseleccionar ingredientes reduces el impacto glucémico")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .italic()
            }
        }
    }
    
    // MARK: - Helper Methods
    
    private func addDishToMeal() {
        // Agregar el platillo principal a la comida
        viewModel.addFoodToMeal(dish.name)
        
        // Agregar ingredientes seleccionados como alimentos individuales si existen en la base de datos
        let selectedIngredients = dish.ingredients.filter(\.isSelected)
        for ingredient in selectedIngredients {
            viewModel.addFoodToMeal(ingredient.name)
        }

        showingSuccessAlert = true
        
        // Auto-cerrar después de 1.5 segundos
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            dismiss()
        }
    }
    
    private func getGlycemicColor() -> Color {
        let impact = getOriginalGlycemicImpact()
        if impact.0 <= 20 {
            return .green
        } else if impact.0 <= 40 {
            return .orange
        } else {
            return .red
        }
    }
    
    private func getGlycemicLevelText() -> String {
        let impact = getOriginalGlycemicImpact()
        if impact.0 <= 20 {
            return "Bajo"
        } else if impact.0 <= 40 {
            return "Medio"
        } else {
            return "Alto"
        }
    }
    
    private func getOriginalGlycemicImpact() -> (Int, Int) {
        // Extraer números del primer efecto glucémico
        let firstEffect = dish.glycemicEffects.first ?? "5-15 mg/dl"
        let numbers = firstEffect.components(separatedBy: CharacterSet.decimalDigits.inverted)
            .compactMap { Int($0) }
            .filter { $0 > 0 }
        
        if numbers.count >= 2 {
            return (numbers[0], numbers[1])
        } else if numbers.count == 1 {
            return (numbers[0], numbers[0] + 10)
        } else {
            return (10, 20) // Default
        }
    }
    
    private func calculateAdjustedGlycemicImpact() -> (Int, Int) {
        let originalImpact = getOriginalGlycemicImpact()
        let selectedIngredients = dish.ingredients.filter(\.isSelected)
        let totalIngredients = dish.ingredients.count
        
        if selectedIngredients.count == totalIngredients {
            return originalImpact
        }
        
        // Calcular reducción basada en ingredientes deseleccionados
        let reductionPercentage = 1.0 - (Double(selectedIngredients.count) / Double(totalIngredients))
        let reduction = Int(Double(originalImpact.0) * reductionPercentage * 0.3) // Máximo 30% de reducción
        
        let newLow = max(originalImpact.0 - reduction, 0)
        let newHigh = max(originalImpact.1 - reduction, newLow + 5)
        
        return (newLow, newHigh)
    }
}

#Preview {
    @Previewable @StateObject var viewModel = MenuViewModel()
    
    DishDetailView(
        dish: Dish(
            name: "Ensalada Verde",
            imageName: "ensalada",
            imageURL: "https://imagenes.elpais.com/resizer/v2/3KWQUZHLQFGVRIWYQGO3A5WFD4.jpg?auth=f2d14d8886b49351024920c894e7f4b9f518886e962c654538d191ee37e30bac&width=1200",
            calories: 85,
            description: "Ensalada fresca con vegetales de temporada",
            glycemicEffects: [
                "Incremento glucémico: 5-15 mg/dl",
                "Rica en fibra que ayuda a estabilizar la glucosa",
                "Ideal como primer plato"
            ],
            ingredients: [
                Ingredient(name: "Lechuga", emoji: "🥬", portion: "50g"),
                Ingredient(name: "Tomate", emoji: "🍅", portion: "30g"),
                Ingredient(name: "Aguacate", emoji: "🥑", portion: "25g")
            ]
        ),
        viewModel: viewModel
    )
}
