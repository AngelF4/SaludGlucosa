//
//  RetoSaludApp.swift
//  RetoSalud
//
//  Created by Angel HG on 07/06/25.
//

import SwiftUI


@main
struct RetoSaludApp: App {
    @StateObject private var appState: AppState

    init() {
        _appState = StateObject(wrappedValue: AppState())
    }

    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
        }
    }
}

@MainActor
final class AppState: ObservableObject {
    @Published var menuViewModel = MenuViewModel()
}

