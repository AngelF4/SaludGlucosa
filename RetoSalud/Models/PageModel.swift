//
//  PageModel.swift
//  Taggo
//
//  Created by Yahir Fuentes on 29/05/25.
//

//this page is the "component" for the pages created on the onboarding carousel

import Foundation

struct Page: Identifiable, Equatable {
    let id = UUID()
    var name: String
    var description: String
    var imageUrl: String
    var tag: Int
    
    static var samplePage = Page(
        name: "Controla tu glucosa",
        description: "Añade tus comidas al calendario y deja que la inteligencia artificial las ordene para mantener tus niveles de glucosa lo más bajos posible.",
        imageUrl: "calendarIcon",
        tag: 0
    )
    
    static var samplePages: [Page] = [
        Page(
            name: "Controla tu glucosa",
            description: "Agrega tus comidas y deja que la IA te ayude a mantener la glucosa baja.",
            imageUrl: "calendarIcon",
            tag: 0
        ),
        Page(
            name: "Registra tus alimentos",
            description: "Consulta tus alimentos y sus ingredientes. Añade nuevos fácilmente.",
            imageUrl: "foodListIcon",
            tag: 1
        ),
        Page(
            name: "Revisa tu historial",
            description: "Revisa tus comidas pasadas y un gráfico estimado de glucosa.",
            imageUrl: "historyGraphIcon",
            tag: 2
        )
    ]
    
}

