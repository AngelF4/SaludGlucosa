//
//  RegisterStepOne.swift
//  RetoSalud
//
//  Created by Alejandro on 07/06/25.
//

import SwiftUI

struct SignUpStepOne: View {
    @ObservedObject var viewModel: SignupViewModel
    @FocusState var isUsernameFocused: Bool
    @FocusState var isEmailFocused: Bool
    @FocusState var isPasswordFocused: Bool
    @FocusState var isConfirmPasswordFocused: Bool

    var body: some View {
        VStack(spacing: 25) {
            InputAuthField(
                icon: "person.fill",
                title: "Usuario",
                placeholder: "Ingresa tu usuario",
                text: $viewModel.username,
                isFocused: $isUsernameFocused,
                textContentType: .username
            )

            InputAuthField(
                icon: "envelope.fill",
                title: "Correo electrónico",
                placeholder: "Ingresa tu correo electrónico",
                text: $viewModel.email,
                isFocused: $isEmailFocused,
                textContentType: .emailAddress
            )

            SecureInputAuthField(
                icon: "lock.fill",
                title: "Contraseña",
                placeholder: "Ingresa tu contraseña",
                text: $viewModel.password,
                isSecured: $viewModel.isSecured,
                isFocused: $isPasswordFocused
            )

            SecureInputAuthField(
                icon: "lock.fill",
                title: "Confirmar contraseña",
                placeholder: "Confirma tu contraseña",
                text: $viewModel.confirmPassword,
                isSecured: $viewModel.isConfirmSecured,
                isFocused: $isConfirmPasswordFocused
            )
        }
    }
}
