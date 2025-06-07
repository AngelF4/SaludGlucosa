//
//  ContentView.swift
//  RetoSalud
//
//  Created by Angel HG on 07/06/25.
//

import SwiftUI

struct ContentView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var wrongUsername = ""
    @State private var wrongPassword = ""
    @State private var showingLoginScreen = false
    
    @State private var pageIndex = 0
    private let pages: [Page] = Page.samplePages
    private let dotAppearance = UIPageControl.appearance()
    
    var body: some View {
        NavigationView {
            ZStack {
                // Fondo con degradado
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.pink.opacity(0.1),
                        Color.pink.opacity(0.2)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                GeometryReader { geometry in
                    // Círculo superior derecho
                    Circle()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.red.opacity(0.3),
                                    Color.red.opacity(0.1)
                                ]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 200, height: 200)
                        .position(x: geometry.size.width - 300, y: 100)
                    
                    // Círculo inferior izquierdo
                    Circle()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.pink.opacity(0.4),
                                    Color.pink.opacity(0.05)
                                ]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 150, height: 150)
                        .position(x: 400, y: geometry.size.height - 100)
                }

                VStack(spacing: 0) {
                    // TabView ocupa el espacio principal
                    TabView(selection: $pageIndex) {
                        ForEach(pages) { page in
                            VStack {
                                PageView(page: page)
                            }
                            .tag(page.tag)
                        }
                    }
                    .tabViewStyle(.page)
                    .onAppear {
                        UIPageControl.appearance().isHidden = true
                    }
                    
                    
                    // AnimatedPageControl centrado
                    AnimatedPageControl(numberOfPages: pages.count, currentPage: pageIndex)
                    
                    // Espaciado uniforme inferior
                    Spacer()
                        .frame(height: 50)
                    
                    // Botones de navegación
                    VStack {
                        NavigationLink(destination: SignInView()) {
                            Text("Regístrate")
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(
                                    LinearGradient(
                                        gradient: Gradient(colors: [
                                            Color.pink,
                                            Color.pink.opacity(0.8)
                                        ]),
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .cornerRadius(10)
                                .padding([.horizontal, .bottom])
                        }

                        NavigationLink(destination: SignInView()) {
                            Text("Inicia sesión")
                                .foregroundColor(.pink)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .cornerRadius(30)
                                .padding([.horizontal, .bottom])
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
