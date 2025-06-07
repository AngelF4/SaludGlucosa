//
//  Signup.swift
//  Taggo
//
//  Created by Yahir Fuentes on 30/05/25.
//

import SwiftUI

struct SignInView: View {
    @StateObject private var viewModel = SignupViewModel()
    @FocusState private var isUsernameFocused: Bool
    @FocusState private var isPasswordFocused: Bool
    
    var body: some View {
        ZStack {
            // Fondo con gradiente rosa del sistema
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.pink.opacity(0.1),
                    Color.pink.opacity(0.2)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            // Elementos decorativos
            GeometryReader { geometry in
                // Círculo superior derecho
                Circle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.red.opacity(0.3),
                                Color.red.opacity(0.1)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 200, height: 200)
                    .position(x: geometry.size.width - 50, y: 100)
                
                // Círculo inferior izquierdo
                Circle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.pink.opacity(0.4),
                                Color.pink.opacity(0.05)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 150, height: 150)
                    .position(x: 75, y: geometry.size.height - 150)
            }
            
            ScrollView {
                VStack(spacing: 30) {
                    Spacer()
                        .frame(height: 60)
                    
                    // Header
                    VStack(spacing: 8) {
                        Text("¡Bienvenido!")
                            .font(.system(size: 32, weight: .bold, design: .rounded))
                            .foregroundColor(.pink)
                        
                        Text("Inicia sesión para continuar")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.secondary)
                    }
                    .padding(.bottom, 20)
                    
                    // Formulario
                    VStack(spacing: 20) {
                        // Campo de usuario
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Image(systemName: "person.fill")
                                    .foregroundColor(.pink)
                                    .frame(width: 20)
                                Text("Usuario")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.secondary)
                            }
                            
                            TextField("Ingresa tu usuario", text: $viewModel.username)
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
                                        .stroke(
                                            isUsernameFocused ?
                                            Color.pink :
                                            Color.clear,
                                            lineWidth: 2
                                        )
                                )
                                .focused($isUsernameFocused)
                                .autocapitalization(.none)
                                .textContentType(.username)
                        }
                        
                        // Campo de contraseña
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Image(systemName: "lock.fill")
                                    .foregroundColor(.pink)
                                    .frame(width: 20)
                                Text("Contraseña")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.secondary)
                            }
                            
                            HStack {
                                if viewModel.isSecured {
                                    SecureField("Ingresa tu contraseña", text: $viewModel.password)
                                        .textFieldStyle(PlainTextFieldStyle())
                                } else {
                                    TextField("Ingresa tu contraseña", text: $viewModel.password)
                                        .textFieldStyle(PlainTextFieldStyle())
                                }
                                
                                Button(action: {
                                    viewModel.togglePasswordVisibility()
                                }) {
                                    Image(systemName: viewModel.isSecured ? "eye.slash.fill" : "eye.fill")
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
                                    .stroke(
                                        isPasswordFocused ?
                                        Color.pink :
                                        Color.clear,
                                        lineWidth: 2
                                    )
                            )
                            .focused($isPasswordFocused)
                            .textContentType(.password)
                        }
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
                    
                    // Enlaces adicionales
                    VStack(spacing: 15) {
                        Button("¿Olvidaste tu contraseña?") {
                            viewModel.forgotPassword()
                        }
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.pink)
                        
                        HStack {
                            Text("¿No tienes cuenta?")
                                .font(.system(size: 14))
                                .foregroundColor(.secondary)
                            
                            Button("Regístrate") {
                                viewModel.goToSignup()
                            }
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.pink)
                        }
                    }
                    
                    Spacer()
                        .frame(height: 50)
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
    SignInView()
}
