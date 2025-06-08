//
//  HomeView.swift
//  RetoSalud
//
//  Created by Angel HG on 07/06/25.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedDate: Date = .now
    @State private var scrollOffset: CGFloat = 0
    @Environment(\.colorScheme) private var colorScheme
    @Namespace private var namespace

    private var meshColors: [Color] {
        if colorScheme == .dark {
            return [
                Color(red: 0.6, green: 0.4, blue: 0.5), // muted rose
                Color(red: 0.5, green: 0.3, blue: 0.4), // deeper blush
                Color(red: 0.4, green: 0.6, blue: 0.7), // soft cyan-dark
                Color(red: 0.3, green: 0.5, blue: 0.6), // slate cyan
                Color(red: 0.2, green: 0.4, blue: 0.5), // dark cyan
                Color.black.opacity(0.2),
                Color.black.opacity(0.3),
                Color.black.opacity(0.4),
                Color.black.opacity(0.5)
            ]
        } else {
            return [
                Color(red: 1.00, green: 0.88, blue: 0.92), // ultra light pink
                Color(red: 0.95, green: 0.75, blue: 0.85), // light blush
                Color(red: 0.85, green: 0.80, blue: 0.95), // pastel lavender
                Color(red: 0.78, green: 0.94, blue: 0.90), // pastel mint
                Color(red: 0.80, green: 0.90, blue: 1.00), // pastel cyan
                Color.white, Color.white, Color.white, Color.white
            ]
        }
    }

    var body: some View {
        ZStack {
            GeometryReader { geo in
                MeshGradient(
                    width: 3, height: 3,
                    points: [
                        .init(0, 0), .init(0.5, 0), .init(1, 0),
                        .init(0, 0.5), .init(0.5, 0.5), .init(1, 0.5),
                        .init(0, 1), .init(0.5, 1), .init(1, 1)
                    ],
                    colors: meshColors
                )
                .frame(width: geo.size.width, height: geo.size.height * 0.3)
                .ignoresSafeArea(edges: .top)
                .opacity(scrollOffset >= 0 ? 1 : 0)
            }
            
            ScrollView {
                GeometryReader { proxy in
                    Color.clear
                        .preference(key: ScrollOffsetKey.self, value: proxy.frame(in: .named("scroll")).minY)
                }
                .frame(height: 0)
                
                DateCarouselView(selectedDate: $selectedDate)
                TimelineView(items: timelineItems, namespace: _namespace)
                    .padding(.horizontal, 30)
            }
            .coordinateSpace(name: "scroll")
            .onPreferenceChange(ScrollOffsetKey.self) { value in
                scrollOffset = value
            }
        }
        .navigationTitle("Inicio")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    
                } label: {
                    Image(systemName: "person.circle")
                        .font(.system(size: 25))
                }
            }
        }
    }
}


#Preview {
    NavigationStack {
        HomeView()
    }
}

private let timelineItems: [TimelineItem] = [
    TimelineItem(iconName: "sunrise.fill", title: "Desayuno", subtitle: "Toca para registrar tu desayuno y mantener tu glucosa estable", foregroundStyle: .yellow),
    TimelineItem(iconName: "sun.max.fill", title: "Comida", subtitle: "Toca para registrar lo que comiste y evitar picos de glucosa", foregroundStyle: .orange),
    TimelineItem(iconName: "moon.fill", title: "Cena", subtitle: "Toca para agregar tu cena y cuidar tus niveles de glucosa", foregroundStyle: .indigo)
]

private struct ScrollOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
