//
//  InputPasswordComponent.swift
//  RetoSalud
//
//  Created by Alejandro on 07/06/25.
//

import Foundation
import SwiftUI

struct SecureInputAuthField: View {
    var icon: String
    var title: String
    var placeholder: String
    @Binding var text: String
    @Binding var isSecured: Bool
    @FocusState.Binding var isFocused: Bool

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

            HStack {
                if isSecured {
                    SecureField(placeholder, text: $text)
                        .textFieldStyle(PlainTextFieldStyle())
                } else {
                    TextField(placeholder, text: $text)
                        .textFieldStyle(PlainTextFieldStyle())
                }

                Button(action: {
                    isSecured.toggle()
                }) {
                    Image(systemName: isSecured ? "eye.slash.fill" : "eye.fill")
                        .foregroundColor(.pink)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white.opacity(0.8))
                    .shadow(color: Color.pink.opacity(0.1), radius: 8, x: 0, y: 2)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isFocused ? Color.pink : Color.clear, lineWidth: 2)
            )
            .focused($isFocused)
            .textContentType(.password)
        }
    }
}
