//
//  glyindex.swift
//  RetoSalud
//
//  Created by Alejandro on 07/06/25.
//

import Foundation

enum TipoAlimento: String {
    case fibra
    case proteina
    case carbohidrato
}

let igDictionary: [String: Int] = [
    "aguacate": 15, "lechuga": 10, "tomate": 30, "zanahoria": 47,
    "pepino": 15, "espinaca": 15, "cebolla": 10, "brocoli": 15,
    "coliflor": 15, "champiñones": 10, "pimiento": 15, "repollo": 10,
    "manzana": 38, "pera": 38, "platano": 52, "naranja": 42,
    "sandia": 72, "uvas": 46, "fresas": 41, "arandanos": 53,
    "lentejas": 32, "garbanzos": 28, "frijoles": 30, "arroz integral": 50,
    "arroz blanco": 73, "pasta integral": 42, "pasta blanca": 49,
    "pan integral": 50, "pan blanco": 75, "tortilla de maiz": 52,
    "tortilla de harina": 70, "cereal de avena": 55, "zucaritas": 82,
    "repostería": 85, "galletas dulces": 77, "yogur natural": 35,
    "leche entera": 41, "leche descremada": 32, "queso": 0,
    "huevo": 0, "pollo": 0, "carne de res": 0, "pescado": 0,
    "tofu": 15, "bebida azucarada": 70, "jugo de naranja": 50,
    "jugo verde": 30, "crema": 10, "sopa de verduras": 25,
    "sopa de fideos": 60, "pizza": 80, "hamburguesa": 66,
    "papas fritas": 75, "pure de papa": 85, "camote": 61, "ensalada": 130,
    "pescado a la plancha": 130,
    "avena": 130,
    "pan": 170,
    "empanadas integrales": 155,
    "sopas": 155,
    "puré de camote": 155,
    "bebidas endulzadas": 170, "leche entera": 41, "leche": 41,
    "leche descremada": 32,
    
]


let tipoAlimento: [String: TipoAlimento] = [
    // Fibra
    "ensalada": .fibra,
    "espinaca": .fibra,
    "lechuga": .fibra,
    "jugo verde": .fibra,
    "lentejas": .fibra,
    "avena": .fibra,
    "frijoles": .fibra,
    "pan integral": .fibra,

    // Proteína
    "pollo": .proteina,
    "carne de res": .proteina,
    "huevo": .proteina,
    "pescado": .proteina,
    "queso": .proteina,
    "tofu": .proteina,
    "empanadas integrales": .proteina,
    "leche": .proteina,
    "leche entera": .proteina,
    "leche descremada": .proteina,

    // Carbohidrato
    "manzana": .carbohidrato,
    "hamburguesa": .carbohidrato,
    "pan": .carbohidrato,
    "pure de papa": .carbohidrato,
    "zucaritas": .carbohidrato,
    "arroz blanco": .carbohidrato,
    "repostería": .carbohidrato,
    "pasta": .carbohidrato,
    "bebidas endulzadas": .carbohidrato
]

let traducciones: [String: String] = [
    "avocado": "aguacate", "lettuce": "lechuga", "tomato": "tomate",
    "carrot": "zanahoria", "cucumber": "pepino", "spinach": "espinaca",
    "onion": "cebolla", "broccoli": "brocoli", "cauliflower": "coliflor",
    "mushroom": "champiñones", "pepper": "pimiento", "cabbage": "repollo",
    "apple": "manzana", "pear": "pera", "banana": "platano",
    "orange": "naranja", "watermelon": "sandia", "grape": "uvas",
    "strawberry": "fresas", "blueberry": "arandanos", "lentils": "lentejas",
    "chickpeas": "garbanzos", "beans": "frijoles", "brown rice": "arroz integral",
    "white rice": "arroz blanco", "whole wheat pasta": "pasta integral",
    "pasta": "pasta blanca", "whole wheat bread": "pan integral",
    "white bread": "pan blanco", "corn tortilla": "tortilla de maiz",
    "flour tortilla": "tortilla de harina", "oatmeal": "cereal de avena",
    "frosted flakes": "zucaritas", "pastry": "repostería", "cookies": "galletas dulces",
    "yogurt": "yogur natural", "whole milk": "leche entera",
    "skim milk": "leche descremada", "cheese": "queso", "egg": "huevo",
    "chicken": "pollo", "beef": "carne de res", "fish": "pescado",
    "tofu": "tofu", "soda": "bebida azucarada", "orange juice": "jugo de naranja",
    "green juice": "jugo verde", "cream": "crema", "vegetable soup": "sopa de verduras",
    "noodle soup": "sopa de fideos", "pizza": "pizza", "hamburger": "hamburguesa",
    "french fries": "papas fritas", "mashed potatoes": "pure de papa",
    "sweet potato": "camote", "salad": "ensalada",
    "grilled fish": "pescado a la plancha",
    "sweetened drinks": "bebidas endulzadas",
    "mashed sweet potato": "puré de camote",
    "soups": "sopas",
    "whole wheat empanadas": "empanadas integrales",
    "bread": "pan", "leche": "milk"
]
