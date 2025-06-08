//
//  RegisterStepTwo.swift
//  RetoSalud
//
//  Created by Alejandro on 07/06/25.
//

import SwiftUI

struct SignUpStepTwo: View {
    @Binding var selectedNumber: Int
    @Binding var selected: String
    @Binding var hasModified: Bool

    var body: some View {
        VStack(spacing: 25) {
            SelectorNumber(
                icon: "calendar",
                title: "¿Cuál es tu edad?",
                range: Array(1...100),
                selectedNumber: $selectedNumber
            )
            .onChange(of: selectedNumber) { _ in hasModified = true }

            SegmentedPicker(
                icon: "drop.fill",
                title: "¿Tienes diabetes?",
                options: ["Sí", "No"],
                selectedOption: $selected
            )
            .onChange(of: selected) { _ in hasModified = true }
        }
    }
}
