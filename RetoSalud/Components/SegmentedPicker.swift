//
//  SwitchSelector.swift
//  RetoSalud
//
//  Created by Alejandro on 07/06/25.
//

import SwiftUI

struct SegmentedPicker: View {
    var icon: String
    var title: String
    var options: [String] // Segmentos visibles
    @Binding var selectedOption: String

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

            Picker("", selection: $selectedOption) {
                ForEach(options, id: \.self) { option in
                    Text(option).tag(option)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
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
    @State private var selected: String = "Sí"

    var body: some View {
        SegmentedPicker(
            icon: "checkmark.circle.fill",
            title: "¿Aceptas?",
            options: ["Sí", "No"],
            selectedOption: $selected
        )
        .padding()
        .background(Color(.systemGroupedBackground))
    }
}
