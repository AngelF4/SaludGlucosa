//
//  TimelineView.swift
//  RetoSalud
//
//  Created by Angel HG on 07/06/25.
//

import SwiftUI

struct TimelineView: View {
    let items: [TimelineItem]
    
    let namespace: Namespace

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(items.indices) { index in
                TimelineRowView(
                    item: items[index],
                    isFirst: index == 0,
                    isLast: index == items.count - 1,
                    namespace: namespace
                )
            }
        }
    }
}

#Preview {
    @Previewable @Namespace var namespace
    TimelineView(items: [
        TimelineItem(iconName: "sunrise.fill", title: "Trackear", subtitle: "Tu glucosa se mantiene dentro del rango tras el desayuno 80% de los días", foregroundStyle: .yellow),
        TimelineItem(iconName: "sun.max.fill", title: "Medir alimentos", subtitle: "Tu mayor variabilidad de glucosa se presenta después del almuerzo", foregroundStyle: .orange),
        TimelineItem(iconName: "moon.fill", title: "Medir alimentos", subtitle: "Tu mayor variabilidad de glucosa se presenta después de la cena", foregroundStyle: .indigo)
    ], namespace: _namespace)
}
