//
//  DatabaseGlucemica.swift
//  RetoSalud
//
//  Created by Yahir Fuentes on 08/06/25.
//
import Foundation

enum GlycemicLevel: Int, CaseIterable {
    case low = 135    // Promedio de 120-150
    case medium = 155 // Promedio de 150-160
    case high = 170   // 170
    
    var range: String {
        switch self {
        case .low: return "120-150 mg/dl"
        case .medium: return "150-160 mg/dl"
        case .high: return "170+ mg/dl"
        }
    }
    
    var color: String {
        switch self {
        case .low: return "green"
        case .medium: return "orange"
        case .high: return "red"
        }
    }
}

struct FoodItem: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let glycemicLevel: GlycemicLevel
    let baseIncrease: Int // mg/dl que aumenta la glucosa
    
    var glycemicImpact: String {
        return "\(baseIncrease-10)-\(baseIncrease+10) mg/dl"
    }
}

class GlycemicDatabase: ObservableObject {
    static let shared = GlycemicDatabase()
    
    let foods: [FoodItem] = [
        // Bajo (120-150)
        FoodItem(name: "Ensalada", glycemicLevel: .low, baseIncrease: 10),
        FoodItem(name: "Pescado a la plancha", glycemicLevel: .low, baseIncrease: 15),
        FoodItem(name: "Jugo verde", glycemicLevel: .low, baseIncrease: 20),
        FoodItem(name: "Avena", glycemicLevel: .low, baseIncrease: 25),
        FoodItem(name: "Lentejas", glycemicLevel: .low, baseIncrease: 20),
        FoodItem(name: "Manzana", glycemicLevel: .low, baseIncrease: 15),
        FoodItem(name: "Huevo", glycemicLevel: .low, baseIncrease: 5),
        FoodItem(name: "Leche", glycemicLevel: .low, baseIncrease: 12),
        FoodItem(name: "Legumbres", glycemicLevel: .low, baseIncrease: 18),
        FoodItem(name: "Pan Integral", glycemicLevel: .low, baseIncrease: 30),
        FoodItem(name: "Espinacas", glycemicLevel: .low, baseIncrease: 8),
        
        // Medio (150-160)
        FoodItem(name: "Pollo a la plancha", glycemicLevel: .medium, baseIncrease: 20),
        FoodItem(name: "Carne asada", glycemicLevel: .medium, baseIncrease: 25),
        FoodItem(name: "Cremas", glycemicLevel: .medium, baseIncrease: 35),
        FoodItem(name: "Sopas", glycemicLevel: .medium, baseIncrease: 30),
        FoodItem(name: "Empanada integral", glycemicLevel: .medium, baseIncrease: 40),
        FoodItem(name: "Puré de camote", glycemicLevel: .medium, baseIncrease: 45),
        FoodItem(name: "Arroz integral", glycemicLevel: .medium, baseIncrease: 35),
        
        // Alto (170+)
        FoodItem(name: "Pasta", glycemicLevel: .high, baseIncrease: 60),
        FoodItem(name: "Puré de papa", glycemicLevel: .high, baseIncrease: 70),
        FoodItem(name: "Pan", glycemicLevel: .high, baseIncrease: 65),
        FoodItem(name: "Bebidas endulzantes", glycemicLevel: .high, baseIncrease: 80),
        FoodItem(name: "Sandía", glycemicLevel: .high, baseIncrease: 50),
        FoodItem(name: "Repostería", glycemicLevel: .high, baseIncrease: 90),
        FoodItem(name: "Zucaritas", glycemicLevel: .high, baseIncrease: 85),
        FoodItem(name: "Arroz blanco", glycemicLevel: .high, baseIncrease: 75)
    ]
    
    func getFoodByName(_ name: String) -> FoodItem? {
        return foods.first {
            name.lowercased().contains($0.name.lowercased())
        }
    }
    
    func getFoodsByLevel(_ level: GlycemicLevel) -> [FoodItem] {
        return foods.filter { $0.glycemicLevel == level }
    }
}

// MARK: - Algoritmo de ordenamiento glucémico
struct GlycemicOrderingAlgorithm {
    
    /// Ordena una lista de alimentos para minimizar el impacto glucémico
    /// Regla: Fibra/Proteína primero, luego carbohidratos complejos, finalmente carbohidratos simples
    static func optimalEatingOrder(foods: [FoodItem]) -> [FoodItem] {
        return foods.sorted { food1, food2 in
            // Primero por nivel glucémico (bajo primero)
            if food1.glycemicLevel.rawValue != food2.glycemicLevel.rawValue {
                return food1.glycemicLevel.rawValue < food2.glycemicLevel.rawValue
            }
            // Si tienen el mismo nivel, ordenar por impacto específico
            return food1.baseIncrease < food2.baseIncrease
        }
    }
    
    /// Calcula el impacto glucémico total considerando el orden
    static func calculateTotalGlycemicImpact(orderedFoods: [FoodItem]) -> Int {
        var totalImpact = 0
        var multiplier = 1.0
        
        for (index, food) in orderedFoods.enumerated() {
            // Los primeros alimentos tienen menos impacto si son de bajo índice glucémico
            if food.glycemicLevel == .low && index == 0 {
                multiplier = 0.8 // 20% menos impacto
            } else if food.glycemicLevel == .high && index == orderedFoods.count - 1 {
                multiplier = 1.0 // Impacto normal al final
            } else if food.glycemicLevel == .high && index < orderedFoods.count / 2 {
                multiplier = 1.3 // 30% más impacto si se come primero
            }
            
            totalImpact += Int(Double(food.baseIncrease) * multiplier)
        }
        
        return totalImpact
    }
    
    /// Genera recomendaciones de orden de consumo
    static func generateEatingRecommendations(foods: [FoodItem]) -> [String] {
        let orderedFoods = optimalEatingOrder(foods: foods)
        var recommendations: [String] = []
        
        recommendations.append("Orden recomendado para minimizar impacto glucémico:")
        
        for (index, food) in orderedFoods.enumerated() {
            let position = index + 1
            let reason = getReasonForPosition(food: food, position: position, totalFoods: orderedFoods.count)
            recommendations.append("\(position). \(food.name) - \(reason)")
        }
        
        let totalImpact = calculateTotalGlycemicImpact(orderedFoods: orderedFoods)
        let unorderedImpact = foods.reduce(0) { $0 + $1.baseIncrease }
        let savings = unorderedImpact - totalImpact
        
        if savings > 0 {
            recommendations.append("💡 Siguiendo este orden podrías reducir tu impacto glucémico en aproximadamente \(savings) mg/dl")
        }
        
        return recommendations
    }
    
    private static func getReasonForPosition(food: FoodItem, position: Int, totalFoods: Int) -> String {
        switch food.glycemicLevel {
        case .low:
            if position == 1 {
                return "Fibra/proteína ayuda a estabilizar la glucosa"
            } else {
                return "Impacto glucémico bajo"
            }
        case .medium:
            return "Impacto moderado, mejor en medio de la comida"
        case .high:
            if position == totalFoods {
                return "Alto impacto glucémico, mejor al final"
            } else {
                return "⚠️ Considera comerlo al final para menor impacto"
            }
        }
    }
}
