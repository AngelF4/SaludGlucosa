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
    
    static var samplePage = Page(name: "taggo", description: "typeshi", imageUrl: "streetstickers", tag: 0)
    
    static var samplePages: [Page] = [
        Page(name: "Función de la app 1", description: "Información rapida de la función 1", imageUrl: "streetstickers", tag: 0),
    
        Page(name: "Función de la app 2", description: "Información rapida de la función 2", imageUrl: "streetstickers", tag: 1),
    
        Page(name: "Función de la app 3", description: "Información rapida de la función 3", imageUrl: "streetstickers", tag: 2),
    ]
    
}

