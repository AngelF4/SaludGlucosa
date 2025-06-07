//
//  ContentView.swift
//  RetoSalud
//
//  Created by Angel HG on 07/06/25.
//

import SwiftUI

struct ContentView: View {
    @State private var pageIndex = 0
    private let pages: [Page] = Page.samplePages
    private let dotAppearance = UIPageControl.appearance()
    
    var body: some View {
        NavigationView {
            ZStack {
              

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
                        NavigationLink(destination: SignUpView()) {
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
