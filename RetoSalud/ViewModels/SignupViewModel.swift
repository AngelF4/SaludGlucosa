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
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var isSecured: Bool = true
    @Published var isConfirmSecured: Bool = true
    @Published var isLoading: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var showSignin: Bool = false
    @Published var age: Int = 20
    @Published var hasDiabetes: String = "No"

    
    // MARK: - Validation
    var isFormValid: Bool {
        !username.isEmpty && !password.isEmpty && password.count >= 6 && confirmPassword.count >= 6 && password == confirmPassword
    }
    
    var usernameError: String? {
        if username.isEmpty {
            return nil
        }
        return username.count < 3 ? "El usuario debe tener al menos 3 caracteres" : nil
    }
    
    var emailError: String? {
        if !email.contains("@") {
            return nil
        }
        return username.count < 3 ? "Debes ingresar un correo electrónico válido" : nil
    }
    
    var passwordError: String? {
        guard !password.isEmpty else { return nil }
        
        if password != confirmPassword {
            return "Las contraseñas no coinciden"
        }
        
        if password.count < 6 {
            return "La contraseña debe tener al menos 6 caracteres"
        }
        
        return nil
    }
    
    // MARK: - Actions
    func togglePasswordVisibility() {
        isSecured.toggle()
    }
    
    func toggleConfirmPasswordVisibility() {
        isConfirmSecured.toggle()
    }
    
    var isDetailsValid: Bool {
        age > 0 && !hasDiabetes.isEmpty
    }
    
    func register() {
        guard isFormValid else {
            showError("Por favor completa todos los campos correctamente")
            return
        }
        
        isLoading = true
        
        // Simulación de llamada a API
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.performRegister()
        }
    }
    
    private func performRegister() {
        isLoading = false
    }
    
    func forgotPassword() {
        // Lógica para recuperar contraseña
        showError("Funcionalidad de recuperación de contraseña")
    }
    
    func goToSignin() {
        showSignin = true
    }
    
    private func showError(_ message: String) {
        alertMessage = message
        showAlert = true
    }
    
    // MARK: - Cleanup
    func clearFields() {
        username = ""
        email = ""
        confirmPassword = ""
        password = ""
        isSecured = true
    }
}
