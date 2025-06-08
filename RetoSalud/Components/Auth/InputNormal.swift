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
                    .foregroundColor(.accentColor)
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
                        .fill(Color(.systemBackground).opacity(0.8))
                        .shadow(color: Color.accentColor.opacity(0.1), radius: 8, x: 0, y: 2)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(isFocused ? Color.accentColor : Color.clear, lineWidth: 2)
                )
                .focused($isFocused)
                .autocapitalization(.none)
                .textContentType(textContentType)
        }
    }
}

#Preview {
    @Previewable @State var text = ""
    @FocusState var isFocused: Bool

    InputAuthField(
        icon: "person",
        title: "Usuario",
        placeholder: "Ingresa aquí",
        text: $text,
        isFocused: $isFocused
    )
    .padding()
}
