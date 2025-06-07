//
//  SignupViewModel.swift
//  Taggo
//
//  Created by Yahir Fuentes on 06/06/25.
//

import SwiftUI
import Combine

class SignupViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isSecured: Bool = true
    @Published var isLoading: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var isLoggedIn: Bool = false
    
    // MARK: - Validation
    var isFormValid: Bool {
        !username.isEmpty && !password.isEmpty && password.count >= 6
    }
    
    var usernameError: String? {
        if username.isEmpty {
            return nil
        }
        return username.count < 3 ? "El usuario debe tener al menos 3 caracteres" : nil
    }
    
    var passwordError: String? {
        if password.isEmpty {
            return nil
        }
        return password.count < 6 ? "La contraseña debe tener al menos 6 caracteres" : nil
    }
    
    // MARK: - Actions
    func togglePasswordVisibility() {
        isSecured.toggle()
    }
    
    func login() {
        guard isFormValid else {
            showError("Por favor completa todos los campos correctamente")
            return
        }
        
        isLoading = true
        
        // Simulación de llamada a API
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.performLogin()
        }
    }
    
    private func performLogin() {
        // Aquí iría tu lógica real de autenticación
        // Por ejemplo, llamada a tu backend
        
        // Simulación de éxito/error
        if username.lowercased() == "admin" && password == "123456" {
            isLoggedIn = true
            showError("¡Bienvenido!")
        } else {
            showError("Usuario o contraseña incorrectos")
        }
        
        isLoading = false
    }
    
    func forgotPassword() {
        // Lógica para recuperar contraseña
        showError("Funcionalidad de recuperación de contraseña")
    }
    
    func goToSignup() {
        // Navegación a registro
        print("Navegar a registro")
    }
    
    private func showError(_ message: String) {
        alertMessage = message
        showAlert = true
    }
    
    // MARK: - Cleanup
    func clearFields() {
        username = ""
        password = ""
        isSecured = true
    }
}
