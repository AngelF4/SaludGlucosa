//
//  Signup.swift
//  Taggo
//
//  Created by Yahir Fuentes on 30/05/25.
//

import SwiftUI

struct SignInView: View {
    @EnvironmentObject var appState: AppState
    @StateObject private var viewModel = SigninViewModel()
    @FocusState private var isUsernameFocused: Bool
    @FocusState private var isPasswordFocused: Bool
    @State private var showHome = false
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 30) {
                    
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
                    VStack(alignment: .leading, spacing: 25) {
                        // Campo de usuario
                        InputAuthField(
                            icon: "person.fill",
                            title: "Usuario",
                            placeholder: "Ingresa tu usuario",
                            text: $viewModel.username,
                            isFocused: $isUsernameFocused,
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
                            .foregroundColor(.pink)
                            
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.pink)
                        }
                    }
                    .fullScreenCover(isPresented: $viewModel.showSignup) {
                        SignUpView()
                    }
                    Spacer()
                        .frame(height: 50)
                }
            }
        }
        .onChange(of: viewModel.isLoggedIn) { isLogged in
            if isLogged {
                showHome = true
            }
        }
        .fullScreenCover(isPresented: $showHome) {
            NavigationStack {
                HomeView().environmentObject(appState.menuViewModel)
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
