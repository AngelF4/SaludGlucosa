//
//  HomeView.swift
//  RetoSalud
//
//  Created by Angel HG on 07/06/25.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedDate: Date = .now

    var body: some View {
        ScrollView {
            DateCarouselView(selectedDate: $selectedDate)
            TimelineView(items: timelineItems)
                .padding(.horizontal, 30)
        }
        .navigationTitle("Inicio")
    }
}


#Preview {
    NavigationStack {
        HomeView()
    }
}

private let timelineItems: [TimelineItem] = [
    TimelineItem(iconName: "sunrise.fill", title: "Trackear", subtitle: "Tu glucosa se mantiene dentro del rango tras el desayuno 80% de los días", foregroundStyle: .yellow),
    TimelineItem(iconName: "sun.max.fill", title: "Medir alimentos", subtitle: "Tu mayor variabilidad de glucosa se presenta después del almuerzo", foregroundStyle: .orange),
    TimelineItem(iconName: "moon.fill", title: "Medir alimentos", subtitle: "Tu mayor variabilidad de glucosa se presenta después de la cena", foregroundStyle: .indigo)
]
