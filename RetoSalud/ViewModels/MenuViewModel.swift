//
//  MenuViewModel.swift
//  RetoSalud
//
//  Created by Angel HG on 07/06/25.
//

import Foundation

class MenuViewModel: ObservableObject {
    @Published var categories: [Category] = []
    @Published var selectedDish: Dish?

    init() {
        loadSampleData()
    }

    private func loadSampleData() {
        categories = [
            Category(name: "Bajo (120-150)", dishes: [
                Dish(
                    name: "Ensalada",
                    imageName: "ensalada",
                    calories: 90,
                    description: "Frescura de lechuga, pepino y zanahoria con aderezo ligero.",
                    glycemicEffects: ["5g carbohidratos netos 🥗", "Incremento de 5–8 mg/dL"],
                    ingredients: [
                        Ingredient(name: "Lechuga", emoji: "🥬", portion: "50g"),
                        Ingredient(name: "Pepino", emoji: "🥒", portion: "50g"),
                        Ingredient(name: "Zanahoria", emoji: "🥕", portion: "30g"),
                    ]
                ),
                Dish(
                    name: "Pescado a la plancha",
                    imageName: "pescado_plancha",
                    calories: 150,
                    description: "Filete de pescado blanco con hierbas y limón.",
                    glycemicEffects: ["0g carbohidratos netos 🐟", "Sin efecto significativo"],
                    ingredients: [
                        Ingredient(name: "Filete de pescado", emoji: "🐟", portion: "120g"),
                        Ingredient(name: "Limón", emoji: "🍋", portion: "1/2 unidad"),
                    ]
                ),
                Dish(
                    name: "Jugo verde",
                    imageName: "jugo_verde",
                    calories: 70,
                    description: "Mezcla de espinacas, manzana y apio licuados.",
                    glycemicEffects: ["8g carbohidratos netos 🥤", "Incremento de 6–10 mg/dL"],
                    ingredients: [
                        Ingredient(name: "Espinaca", emoji: "🥬", portion: "40g"),
                        Ingredient(name: "Manzana verde", emoji: "🍏", portion: "1/2 unidad"),
                        Ingredient(name: "Apio", emoji: "🌱", portion: "30g"),
                    ]
                ),
                Dish(
                    name: "Avena",
                    imageName: "avena",
                    calories: 180,
                    description: "Avena cocida con agua y toque de canela.",
                    glycemicEffects: ["27g carbohidratos netos 🌾", "Incremento de 12–15 mg/dL"],
                    ingredients: [
                        Ingredient(name: "Avena", emoji: "🥣", portion: "50g"),
                        Ingredient(name: "Canela", emoji: "🍂", portion: "1g"),
                    ]
                ),
                Dish(
                    name: "Lentejas",
                    imageName: "lentejas",
                    calories: 160,
                    description: "Guiso de lentejas con verduras y especias.",
                    glycemicEffects: ["20g carbohidratos netos 🥣", "Incremento de 10–14 mg/dL"],
                    ingredients: [
                        Ingredient(name: "Lentejas", emoji: "🥣", portion: "60g"),
                        Ingredient(name: "Zanahoria", emoji: "🥕", portion: "30g"),
                        Ingredient(name: "Cebolla", emoji: "🧅", portion: "20g"),
                    ]
                )
            ]),
            Category(name: "Medio (150-160)", dishes: [
                Dish(
                    name: "Pollo a la plancha",
                    imageName: "pollo_plancha",
                    calories: 200,
                    description: "Pechuga de pollo marinada en hierbas y asada.",
                    glycemicEffects: ["0g carbohidratos netos 🍗", "Sin efecto significativo"],
                    ingredients: [
                        Ingredient(name: "Pechuga de pollo", emoji: "🍗", portion: "100g"),
                        Ingredient(name: "Hierbas", emoji: "🌿", portion: "5g"),
                    ]
                ),
                Dish(
                    name: "Carne asada",
                    imageName: "carne_asada",
                    calories: 250,
                    description: "Tiras de res a la parrilla con especias.",
                    glycemicEffects: ["0g carbohidratos netos 🥩", "Sin efecto significativo"],
                    ingredients: [
                        Ingredient(name: "Res", emoji: "🥩", portion: "120g"),
                        Ingredient(name: "Especias", emoji: "🧂", portion: "al gusto"),
                    ]
                ),
                Dish(
                    name: "Cremas",
                    imageName: "cremas",
                    calories: 140,
                    description: "Sopa crema de verduras con leche desnatada.",
                    glycemicEffects: ["10g carbohidratos netos 🥣", "Incremento de 8–12 mg/dL"],
                    ingredients: [
                        Ingredient(name: "Calabaza", emoji: "🎃", portion: "50g"),
                        Ingredient(name: "Leche desnatada", emoji: "🥛", portion: "100ml"),
                    ]
                ),
                Dish(
                    name: "Sopas",
                    imageName: "sopas",
                    calories: 150,
                    description: "Sopa de pollo con verduras.",
                    glycemicEffects: ["12g carbohidratos netos 🍲", "Incremento de 7–11 mg/dL"],
                    ingredients: [
                        Ingredient(name: "Caldo de pollo", emoji: "🍲", portion: "150ml"),
                        Ingredient(name: "Verduras mixtas", emoji: "🥦", portion: "50g"),
                    ]
                ),
                Dish(
                    name: "Empanadas integrales",
                    imageName: "empanadas_integrales",
                    calories: 220,
                    description: "Empanadas horneadas rellenas de queso bajo en grasa.",
                    glycemicEffects: ["30g carbohidratos netos 🥟", "Incremento de 15–20 mg/dL"],
                    ingredients: [
                        Ingredient(name: "Masa integral", emoji: "🌾", portion: "50g"),
                        Ingredient(name: "Queso cottage", emoji: "🧀", portion: "40g"),
                    ]
                ),
                Dish(
                    name: "Puré de camote",
                    imageName: "pure_camote",
                    calories: 180,
                    description: "Camote cocido y triturado con toque de mantequilla ligera.",
                    glycemicEffects: ["25g carbohidratos netos 🍠", "Incremento de 14–18 mg/dL"],
                    ingredients: [
                        Ingredient(name: "Camote", emoji: "🍠", portion: "100g"),
                        Ingredient(name: "Mantequilla ligera", emoji: "🧈", portion: "5g"),
                    ]
                )
            ]),
            Category(name: "Alto (≥170)", dishes: [
                Dish(
                    name: "Pasta",
                    imageName: "pasta",
                    calories: 330,
                    description: "Pasta con salsa de tomate y queso rallado.",
                    glycemicEffects: ["45g carbohidratos netos 🍝", "Incremento de 25–30 mg/dL"],
                    ingredients: [
                        Ingredient(name: "Pasta seca", emoji: "🍝", portion: "100g"),
                        Ingredient(name: "Salsa de tomate", emoji: "🍅", portion: "60g"),
                    ]
                ),
                Dish(
                    name: "Puré de papa",
                    imageName: "pure_papa",
                    calories: 200,
                    description: "Puré cremoso de papa con leche entera.",
                    glycemicEffects: ["35g carbohidratos netos 🥔", "Incremento de 20–25 mg/dL"],
                    ingredients: [
                        Ingredient(name: "Papa", emoji: "🥔", portion: "100g"),
                        Ingredient(name: "Leche entera", emoji: "🥛", portion: "50ml"),
                    ]
                ),
                Dish(
                    name: "Pan",
                    imageName: "pan",
                    calories: 250,
                    description: "Rebanada de pan blanco industrial.",
                    glycemicEffects: ["50g carbohidratos netos 🍞", "Incremento de 30–35 mg/dL"],
                    ingredients: [
                        Ingredient(name: "Pan blanco", emoji: "🍞", portion: "1 rebanada"),
                    ]
                )
            ])
        ]
    }
}
