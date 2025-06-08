//
//  SelectorNumber.swift
//  RetoSalud
//
//  Created by Alejandro on 07/06/25.
//

import SwiftUI

struct SelectorNumber: View {
    var icon: String
    var title: String
    var range: [Int]  
    @Binding var selectedNumber: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.pink)
                    .frame(width: 20)
                Text(title)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.secondary)
            }

            Picker(selection: $selectedNumber, label: Text("")) {
                ForEach(range, id: \.self) { number in
                    Text("\(number)").tag(number)
                }
            }
            .pickerStyle(.wheel)
            .frame(height: 120)
            .clipped()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white.opacity(0.8))
                    .shadow(color: Color.pink.opacity(0.1), radius: 8, x: 0, y: 2)
            )
        }
    }
}

#Preview {
    PreviewWrapper()
}

private struct PreviewWrapper: View {
    @State private var selectedNumber: Int = 5

    var body: some View {
        SelectorNumber(
            icon: "number.circle.fill",
            title: "Edad",
            range: Array(1...100),
            selectedNumber: $selectedNumber
        )
        .padding()
        .background(Color(.systemGroupedBackground))
    }
}
