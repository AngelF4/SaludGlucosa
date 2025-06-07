//
//  TimelineRowView.swift
//  RetoSalud
//
//  Created by Angel HG on 07/06/25.
//

import SwiftUI

struct TimelineRowView: View {
    let item: TimelineItem
    let isFirst: Bool
    let isLast: Bool

    var body: some View {
        HStack(alignment: .top) {
            // Timeline indicator
            VStack(spacing: 0) {
                // Upper line segment
                Rectangle()
                    .fill(Color.pink.secondary)
                    .frame(width: 2)
                    .opacity(isFirst ? 0 : 1)
                    .frame(maxHeight: .infinity)

                // Icon circle
                Circle()
                    .stroke(Color.pink.secondary, lineWidth: 2)
                    .background(Circle().fill(Color.white))
                    .frame(width: 32, height: 32)
                    .overlay(
                        Image(systemName: item.iconName)
                            .foregroundColor(.pink)
                    )

                // Lower line segment
                Rectangle()
                    .fill(Color.pink.secondary)
                    .frame(width: 2)
                    .opacity(isLast ? 0 : 1)
                    .frame(maxHeight: .infinity)
            }
            .frame(width: 40)

            // Card content
            VStack(alignment: .leading, spacing: 10) {
                Text(item.title)
                    .font(.headline)
                Text(item.subtitle)
                    .font(.headline)
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(20)
            .background(item.foregroundStyle.quaternary)
            .cornerRadius(20)
            .overlay(
                Image(systemName: "plus")
                    .padding(),
                alignment: .topTrailing
            )
            .padding(.bottom)
        }
    }
}

#Preview {
    HomeView()
}
