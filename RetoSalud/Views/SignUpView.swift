//
//  Signup.swift
//  Taggo
//
//  Created by Yahir Fuentes on 30/05/25.
//

import SwiftUI

struct SignUpView: View {
    @StateObject private var viewModel = SignupViewModel()
    @FocusState private var isUsernameFocused: Bool
    @FocusState private var isEmailFocused: Bool
    @FocusState private var isPasswordFocused: Bool
    @FocusState private var isConfirmPasswordFocused: Bool
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 30) {
                    Spacer()
                        .frame(height: 20)
                    
                    // Header
                    VStack(spacing: 8) {
                        Text("¡Bienvenido!")
                            .font(.system(size: 32, weight: .bold, design: .rounded))
                            .foregroundColor(.pink)
                        
                        Text("Regístrate para continuar")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.secondary)
                    }
                    .padding(.bottom, 5)
                    
                    // Formulario
                    VStack(alignment: .leading, spacing: 25) {
                            InputAuthField(
                                icon: "person.fill",
                                title: "Usuario",
                                placeholder: "Ingresa tu usuario",
                                text: $viewModel.username,
                                isFocused: $isUsernameFocused,
                                textContentType: .username
                            )
                        InputAuthField(
                            icon: "person.fill",
                            title: "Correo electrónico",
                            placeholder: "Ingresa tu correo electrónico",
                            text: $viewModel.email,
                            isFocused: $isEmailFocused,
                            textContentType: .username
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
                            isSecured: $viewModel.isSecured,
                            isFocused: $isConfirmPasswordFocused
                        )
                    }
                    .padding(.horizontal, 30)
                    
                    // Botón de login
                    Button(action: {
                        viewModel.login()
                    }) {
                        HStack {
                            if viewModel.isLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                    .scaleEffect(0.8)
                            } else {
                                Image(systemName: "arrow.right.circle.fill")
                                    .font(.system(size: 20))
                            }
                            
                            Text(viewModel.isLoading ? "Iniciando sesión..." : "Iniciar Sesión")
                                .font(.system(size: 16, weight: .semibold))
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.pink,
                                    Color.pink.opacity(0.8)
                                ]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .shadow(color: Color.pink.opacity(0.3), radius: 8, x: 0, y: 4)
                    }
                    .padding(.horizontal, 30)
                    .disabled(!viewModel.isFormValid || viewModel.isLoading)
                    .opacity(viewModel.isFormValid ? 1.0 : 0.6)
                    
                    Spacer()
                        .frame(height: 20)
                    
                    // Enlaces adicionales
                    VStack(spacing: 15) {
                        Button("¿Olvidaste tu contraseña?") {
                            viewModel.forgotPassword()
                        }
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.pink)
                        
                        HStack {
                            Text("¿Ya tienes cuenta?")
                                .font(.system(size: 14))
                                .foregroundColor(.secondary)
                            
                            Button("Inicia sesión") {
                                viewModel.goToSignin()
                            }
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.pink)
                        }
                    }
                    .fullScreenCover(isPresented: $viewModel.showSignin) {
                        SignInView()
                    }
                }
            }
        }
        .onTapGesture {
            hideKeyboard()
        }
        .alert("Información", isPresented: $viewModel.showAlert) {
            Button("OK") { }
        } message: {
            Text(viewModel.alertMessage)
        }
    }
    
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    SignUpView()
}
