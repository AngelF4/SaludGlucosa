//
//  MenuViewModel.swift
//  RetoSalud
//
//  Created by Yahir Fuentes on 08/06/25.
//

import Foundation
import SwiftUI

@MainActor
class MenuViewModel: ObservableObject {
    @Published var categories: [Category] = []
    @Published var selectedDish: Dish?
    @Published var selectedFoods: [FoodItem] = []
    @Published var showingOptimalOrder = false
    @Published var eatingRecommendations: [String] = []
    
    private let glycemicDB = GlycemicDatabase.shared
    
    init() {
        loadCategories()
    }
    
    private func loadCategories() {
        categories = [
            Category(name: "🥗 Fibra y Vegetales", dishes: createFiberDishes()),
            Category(name: "🍗 Proteínas", dishes: createProteinDishes()),
            Category(name: "🍞 Carbohidratos", dishes: createCarbDishes())
        ]
    }
    
    private func createFiberDishes() -> [Dish] {
        return [
            Dish(
                name: "Ensalada",
                imageName: "salad",
                imageURL: "https://imagenes.elpais.com/resizer/v2/3KWQUZHLQFGVRIWYQGO3A5WFD4.jpg?auth=f2d14d8886b49351024920c894e7f4b9f518886e962c654538d191ee37e30bac&width=1200",
                calories: 85,
                description: "Ensalada fresca con vegetales de hoja verde",
                glycemicEffects: [
                    "Incremento glucémico: 5-15 mg/dl",
                    "Rica en fibra que ayuda a estabilizar la glucosa",
                    "Ideal como primer plato para reducir impacto de otros alimentos"
                ],
                ingredients: [
                    Ingredient(name: "Lechuga", emoji: "🥬", portion: "50g"),
                    Ingredient(name: "Tomate", emoji: "🍅", portion: "30g"),
                    Ingredient(name: "Aguacate", emoji: "🥑", portion: "25g"),
                    Ingredient(name: "Cebolla", emoji: "🧅", portion: "15g")
                ]
            ),
            Dish(
                name: "Espinacas al vapor",
                imageName: "spinach",
                imageURL: "https://i.ytimg.com/vi/zCepgS5F3GY/maxresdefault.jpg",
                calories: 45,
                description: "Espinacas frescas cocidas al vapor",
                glycemicEffects: [
                    "Incremento glucémico: 3-13 mg/dl",
                    "Muy bajo impacto glucémico",
                    "Rica en hierro y fibra"
                ],
                ingredients: [
                    Ingredient(name: "Espinacas", emoji: "🥬", portion: "100g"),
                    Ingredient(name: "Ajo", emoji: "🧄", portion: "5g"),
                    Ingredient(name: "Aceite de oliva", emoji: "🫒", portion: "5ml")
                ]
            ),
            Dish(
                name: "Jugo Verde",
                imageName: "green_juice",
                imageURL: "https://image.tuasaude.com/media/article/ws/se/suco-verde_67718.jpg",
                calories: 95,
                description: "Jugo natural de vegetales verdes",
                glycemicEffects: [
                    "Incremento glucémico: 15-25 mg/dl",
                    "Antioxidantes naturales",
                    "Fibra soluble que ayuda con la glucosa"
                ],
                ingredients: [
                    Ingredient(name: "Apio", emoji: "🥬", portion: "50g"),
                    Ingredient(name: "Pepino", emoji: "🥒", portion: "100g"),
                    Ingredient(name: "Espinacas", emoji: "🥬", portion: "30g"),
                    Ingredient(name: "Manzana verde", emoji: "🍏", portion: "50g")
                ]
            )
        ]
    }
    
    private func createProteinDishes() -> [Dish] {
        return [
            Dish(
                name: "Pescado a la plancha",
                imageName: "grilled_fish",
                imageURL: "https://cdn0.recetasgratis.net/es/posts/3/1/3/filete_de_pescado_a_la_plancha_sin_que_se_pegue_59313_orig.jpg",
                calories: 185,
                description: "Pescado fresco cocido a la plancha",
                glycemicEffects: [
                    "Incremento glucémico: 10-20 mg/dl",
                    "Proteína de alta calidad",
                    "Omega-3 para salud cardiovascular"
                ],
                ingredients: [
                    Ingredient(name: "Filete de pescado", emoji: "🐟", portion: "120g"),
                    Ingredient(name: "Limón", emoji: "🍋", portion: "15ml"),
                    Ingredient(name: "Hierbas finas", emoji: "🌿", portion: "5g")
                ]
            ),
            Dish(
                name: "Pollo a la plancha",
                imageName: "grilled_chicken",
                imageURL: "https://www.paulinacocina.net/wp-content/uploads/2023/06/pollo-a-la-plancha-receta-1200x676.jpg",
                calories: 220,
                description: "Pechuga de pollo sin piel a la plancha",
                glycemicEffects: [
                    "Incremento glucémico: 15-25 mg/dl",
                    "Proteína magra de calidad",
                    "Impacto glucémico moderado-bajo"
                ],
                ingredients: [
                    Ingredient(name: "Pechuga de pollo", emoji: "🍗", portion: "120g"),
                    Ingredient(name: "Especias", emoji: "🧂", portion: "3g"),
                    Ingredient(name: "Aceite de oliva", emoji: "🫒", portion: "5ml")
                ]
            ),
            Dish(
                name: "Huevos revueltos",
                imageName: "scrambled_eggs",
                imageURL: "https://imag.bonviveur.com/fotografia-de-unos-huevos-revueltos.jpg",
                calories: 155,
                description: "Huevos frescos revueltos",
                glycemicEffects: [
                    "Incremento glucémico: 0-10 mg/dl",
                    "Muy bajo impacto glucémico",
                    "Proteína completa de alta calidad"
                ],
                ingredients: [
                    Ingredient(name: "Huevos", emoji: "🥚", portion: "2 piezas"),
                    Ingredient(name: "Leche", emoji: "🥛", portion: "30ml"),
                    Ingredient(name: "Mantequilla", emoji: "🧈", portion: "5g")
                ]
            )
        ]
    }
    
    private func createCarbDishes() -> [Dish] {
        return [
            Dish(
                name: "Avena integral",
                imageName: "oatmeal",
                imageURL: "https://enrilemoine.com/wp-content/uploads/2017/10/1.-Avena-con-leche-SAVOIR-FAIRE-by-enrilemoine-1-scaled.jpg",
                calories: 140,
                description: "Avena cocida con fibra natural",
                glycemicEffects: [
                    "Incremento glucémico: 20-30 mg/dl",
                    "Fibra soluble que ayuda a controlar glucosa",
                    "Liberación lenta de energía"
                ],
                ingredients: [
                    Ingredient(name: "Avena integral", emoji: "🥣", portion: "40g"),
                    Ingredient(name: "Leche descremada", emoji: "🥛", portion: "200ml"),
                    Ingredient(name: "Canela", emoji: "🧂", portion: "1g")
                ]
            ),
            Dish(
                name: "Pan integral",
                imageName: "whole_bread",
                imageURL: "https://assets.tmecosys.com/image/upload/t_web_rdp_recipe_584x480/img/recipe/ras/Assets/791D03F1-A753-4B51-8208-8935C35F6587/Derivates/bd564d0a-8247-477b-9a52-48f2202d454e.jpg",
                calories: 180,
                description: "Pan integral con fibra",
                glycemicEffects: [
                    "Incremento glucémico: 25-35 mg/dl",
                    "Mejor opción que el pan blanco",
                    "Combinar con proteína para menor impacto"
                ],
                ingredients: [
                    Ingredient(name: "Pan integral", emoji: "🍞", portion: "2 rebanadas"),
                    Ingredient(name: "Aguacate", emoji: "🥑", portion: "30g")
                ]
            ),
            Dish(
                name: "Arroz integral",
                imageName: "brown_rice",
                imageURL: "https://assets.tmecosys.com/image/upload/t_web_rdp_recipe_584x480/img/recipe/ras/Assets/7F99AEE8-50AA-4CAA-A340-81E4891F912F/Derivates/3de10392-9a13-48e5-9098-af5149c40c0a.jpg",
                calories: 160,
                description: "Arroz integral cocido",
                glycemicEffects: [
                    "Incremento glucémico: 30-40 mg/dl",
                    "Mejor que arroz blanco",
                    "Comer en porciones moderadas"
                ],
                ingredients: [
                    Ingredient(name: "Arroz integral", emoji: "🍚", portion: "60g cocido"),
                    Ingredient(name: "Sal", emoji: "🧂", portion: "1g")
                ]
            )
        ]
    }
    
    func addFoodToMeal(_ foodName: String) {
        if let food = glycemicDB.getFoodByName(foodName),
           !selectedFoods.contains(where: { $0.name.lowercased() == food.name.lowercased() }) {
            selectedFoods.append(food)
        }
    }
    
    func removeFoodFromMeal(_ food: FoodItem) {
        selectedFoods.removeAll { $0.id == food.id }
    }
    
    func generateOptimalOrder() {
        guard !selectedFoods.isEmpty else { return }

        let ordenados = ordenarAlimentosPorPrioridad(selectedFoods)

        // Crear texto de recomendaciones
        var recomendaciones: [String] = []
        recomendaciones.append("Orden recomendado para minimizar impacto glucémico:")

        for (i, food) in ordenados.enumerated() {
            let position = i + 1
            let tipo = tipoAlimento[food.name.lowercased()] ?? .carbohidrato
            let tipoTexto: String = {
                switch tipo {
                case .fibra: return "Fibra - estabiliza la glucosa"
                case .proteina: return "Proteína - impacto moderado"
                case .carbohidrato: return "Carbohidrato - mejor al final"
                }
            }()
            recomendaciones.append("\(position). \(food.name) - \(tipoTexto)")
        }

        let totalImpact = GlycemicOrderingAlgorithm.calculateTotalGlycemicImpact(orderedFoods: ordenados)
        let unorderedImpact = selectedFoods.reduce(0) { $0 + $1.baseIncrease }
        let ahorro = unorderedImpact - totalImpact

        if ahorro > 0 {
            recomendaciones.append("💡 Siguiendo este orden podrías reducir tu impacto glucémico en aproximadamente \(ahorro) mg/dl")
        }

        eatingRecommendations = recomendaciones
        showingOptimalOrder = true
    }
    
    func clearMeal() {
        selectedFoods.removeAll()
        eatingRecommendations.removeAll()
    }
    
    func calculateTotalImpact() -> Int {
        let orderedFoods = GlycemicOrderingAlgorithm.optimalEatingOrder(foods: selectedFoods)
        return GlycemicOrderingAlgorithm.calculateTotalGlycemicImpact(orderedFoods: orderedFoods)
    }
}
