//
//  WizardStepper.swift
//  RetoSalud
//
//  Created by Alejandro on 07/06/25.
//

import SwiftUI

struct WizardStepper: View {
    @Binding var currentStep: Int
    let totalSteps: Int

    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<totalSteps, id: \.self) { index in
                Rectangle()
                    .fill(index <= currentStep ? Color.pink : Color.gray.opacity(0.3))
                    .frame(height: 6)
                    .cornerRadius(3)
                    .onTapGesture {
                        currentStep = index
                    }
            }
        }
        .padding(.horizontal, 30)
        .padding(.top, 20)
    }
}
