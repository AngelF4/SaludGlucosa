//
//  GlycemicAnalysisView.swift
//  RetoSalud
//
//  Created by Yahir Fuentes on 08/06/25.
//

import SwiftUI

struct GlycemicAnalysisView: View {
    let foods: [FoodItem]
    @Environment(\.dismiss) private var dismiss
    
    private var optimalOrder: [FoodItem] {
        GlycemicOrderingAlgorithm.optimalEatingOrder(foods: foods)
    }
    
    private var totalOptimalImpact: Int {
        GlycemicOrderingAlgorithm.calculateTotalGlycemicImpact(orderedFoods: optimalOrder)
    }
    
    private var totalUnorderedImpact: Int {
        foods.reduce(0) { $0 + $1.baseIncrease }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Resumen del impacto
                    impactSummarySection
                    
                    // Orden óptimo
                    optimalOrderSection
                    
                    // Comparación visual
                    comparisonSection
                    
                    // Consejos adicionales
                    tipsSection
                }
                .padding()
            }
            .navigationTitle("Análisis Glucémico")
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
    }
    
    private var impactSummarySection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("📊 Resumen del Impacto")
                .font(.title2)
                .bold()
                .foregroundStyle(.pink)
            
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Orden aleatorio")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text("\(totalUnorderedImpact) mg/dl")
                        .font(.title3)
                        .bold()
                        .foregroundStyle(.red)
                }
                
                Image(systemName: "arrow.right")
                    .foregroundStyle(.pink)
                    .font(.title2)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Orden óptimo")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text("\(totalOptimalImpact) mg/dl")
                        .font(.title3)
                        .bold()
                        .foregroundStyle(.green)
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text("Reducción")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text("-\(totalUnorderedImpact - totalOptimalImpact) mg/dl")
                        .font(.title3)
                        .bold()
                        .foregroundStyle(.green)
                }
            }
            .padding()
            .background(.pink.opacity(0.05))
            .cornerRadius(12)
        }
    }
    
    private var optimalOrderSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("🍽️ Orden Recomendado")
                .font(.title2)
                .bold()
                .foregroundStyle(.pink)
            
            Text("Sigue este orden para minimizar el impacto en tu glucosa:")
                .font(.body)
                .foregroundStyle(.secondary)
            
            ForEach(Array(optimalOrder.enumerated()), id: \.offset) { index, food in
                FoodOrderRow(food: food, position: index + 1)
            }
        }
    }
    
    private var comparisonSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("📈 Comparación Visual")
                .font(.title2)
                .bold()
                .foregroundStyle(.pink)
            
            // Gráfico de barras simple
            VStack(spacing: 8) {
                HStack {
                    Text("Orden aleatorio")
                        .font(.caption)
                        .frame(width: 100, alignment: .leading)
                    
                    Rectangle()
                        .fill(.red.opacity(0.7))
                        .frame(width: CGFloat(totalUnorderedImpact) * 2, height: 20)
                        .cornerRadius(4)
                    
                    Text("\(totalUnorderedImpact)")
                        .font(.caption)
                        .bold()
                }
                
                HStack {
                    Text("Orden óptimo")
                        .font(.caption)
                        .frame(width: 100, alignment: .leading)
                    
                    Rectangle()
                        .fill(.green.opacity(0.7))
                        .frame(width: CGFloat(totalOptimalImpact) * 2, height: 20)
                        .cornerRadius(4)
                    
                    Text("\(totalOptimalImpact)")
                        .font(.caption)
                        .bold()
                }
            }
            .padding()
            .background(.pink.opacity(0.05))
            .cornerRadius(12)
        }
    }
    
    private var tipsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("💡 Consejos Adicionales")
                .font(.title2)
                .bold()
                .foregroundStyle(.pink)
            
            VStack(alignment: .leading, spacing: 8) {
                TipRow(
                    icon: "🥗",
                    title: "Empieza con fibra",
                    description: "Los vegetales y proteínas ayudan a estabilizar la glucosa"
                )
                
                TipRow(
                    icon: "⏰",
                    title: "Come despacio",
                    description: "Tómate 5-10 minutos entre cada alimento"
                )
                
                TipRow(
                    icon: "🚰",
                    title: "Hidrátate",
                    description: "Bebe agua entre cada alimento para mejor digestión"
                )
                
                TipRow(
                    icon: "🍞",
                    title: "Carbohidratos al final",
                    description: "Deja los carbohidratos simples para el final"
                )
            }
        }
    }
}

struct FoodOrderRow: View {
    let food: FoodItem
    let position: Int
    
    var body: some View {
        HStack(spacing: 12) {
            // Número de orden
            Text("\(position)")
                .font(.title3)
                .bold()
                .foregroundStyle(.white)
                .frame(width: 28, height: 28)
                .background(levelColor(for: food.glycemicLevel))
                .clipShape(Circle())
            
            // Información del alimento
            VStack(alignment: .leading, spacing: 2) {
                Text(food.name)
                    .font(.body)
                    .bold()
                
                Text(food.glycemicImpact)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            // Indicador de nivel
            Text(food.glycemicLevel == .low ? "Bajo" : food.glycemicLevel == .medium ? "Medio" : "Alto")
                .font(.caption)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(levelColor(for: food.glycemicLevel).opacity(0.2))
                .foregroundStyle(levelColor(for: food.glycemicLevel))
                .cornerRadius(8)
        }
        .padding(.vertical, 4)
    }
    
    private func levelColor(for level: GlycemicLevel) -> Color {
        switch level {
        case .low: return .green
        case .medium: return .orange
        case .high: return .red
        }
    }
}

struct TipRow: View {
    let icon: String
    let title: String
    let description: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Text(icon)
                .font(.title2)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.body)
                    .bold()
                
                Text(description)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    GlycemicAnalysisView(foods: [
        FoodItem(name: "Ensalada", glycemicLevel: .low, baseIncrease: 10),
        FoodItem(name: "Pasta", glycemicLevel: .high, baseIncrease: 60),
        FoodItem(name: "Pollo", glycemicLevel: .medium, baseIncrease: 20)
    ])
}
