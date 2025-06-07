//
//  AnimatedPageControl.swift
//  RetoSalud
//
//  Created by Alejandro on 07/06/25.
//


import SwiftUI

struct AnimatedPageControl: View {
    var numberOfPages: Int
    var currentPage: Int
    
    @State private var previousPage: Int = 0
    @State private var dragOffset: CGFloat = 0
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<numberOfPages, id: \.self) { index in
                ZStack {
                    // Dot base
                    Capsule()
                        .fill(Color.pink.opacity(0.3))
                        .frame(width: 10, height: 10)
                    
                    // Dot activo con animación direccional
                    if index == currentPage {
                        Capsule()
                            .fill(Color.pink)
                            .frame(width: 35, height: 10)
                            .transition(
                                .asymmetric(
                                    insertion: .move(edge: currentPage > previousPage ? .trailing : .leading)
                                        .combined(with: .scale),
                                    removal: .move(edge: currentPage > previousPage ? .leading : .trailing)
                                        .combined(with: .scale)
                                )
                            )
                    }
                }
                .animation(
                    .spring(response: 0.5, dampingFraction: 0.7),
                    value: currentPage
                )
            }
        }
        .padding(.vertical, 8)
        .onChange(of: currentPage) { newValue in
            withAnimation {
                previousPage = currentPage
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                previousPage = newValue
            }
        }
        .onAppear {
            previousPage = currentPage
        }
    }
}

#Preview {
    VStack(spacing: 30) {
        AnimatedPageControl(numberOfPages: 4, currentPage: 1)
    }
}
