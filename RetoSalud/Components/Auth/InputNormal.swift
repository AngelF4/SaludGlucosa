//
//  InputNormalComponent.swift
//  RetoSalud
//
//  Created by Alejandro on 07/06/25.
//
import SwiftUI

struct InputAuthField: View {
    var icon: String
    var title: String
    var placeholder: String
    @Binding var text: String
    @FocusState.Binding var isFocused: Bool
    var textContentType: UITextContentType?

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

            TextField(placeholder, text: $text)
                .textFieldStyle(PlainTextFieldStyle())
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
                .autocapitalization(.none)
                .textContentType(textContentType)
        }
    }
}
