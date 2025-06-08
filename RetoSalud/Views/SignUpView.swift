//
//  Signup.swift
//  Taggo
//
//  Created by Yahir Fuentes on 30/05/25.
//

import SwiftUI

struct SignUpView: View {
    @StateObject private var viewModel = SignupViewModel()
    @State private var step: Int = 0
    @State var showHome = false
    @State private var hasModifiedDetails = false
    @FocusState private var isUsernameFocused: Bool
    @FocusState private var isEmailFocused: Bool
    @FocusState private var isPasswordFocused: Bool
    @FocusState private var isConfirmPasswordFocused: Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    VStack(spacing: 30) {
                        Spacer().frame(height: 10)
                        
                        
                        
                        // Header dinámico
                        VStack(spacing: 8) {
                            Text(step == 0 ? "¡Bienvenido!" : "Antes de continuar...")
                                .font(.system(size: 32, weight: .bold, design: .rounded))
                                .foregroundColor(.pink)
                            
                            Text(step == 0 ? "Regístrate para continuar" : "Por favor, proporcionanos los siguientes datos")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.secondary)
                        }
                        
                        WizardStepper(currentStep: $step, totalSteps: 2)
                        
                        // Formulario dinámico
                        VStack(alignment: .leading, spacing: 25) {
                            if step == 0 {
                                SignUpStepOne(
                                    viewModel: viewModel,
                                    isUsernameFocused: _isUsernameFocused,
                                    isEmailFocused: _isEmailFocused,
                                    isPasswordFocused: _isPasswordFocused,
                                    isConfirmPasswordFocused: _isConfirmPasswordFocused
                                )
                            } else {
                                SignUpStepTwo(
                                    selectedNumber: $viewModel.age,
                                    selected: $viewModel.hasDiabetes,
                                    hasModified: $hasModifiedDetails
                                )
                            }
                        }
                        .padding(.horizontal, 30)
                        
                        HStack {
                            Button(action: {
                                if step == 0 {
                                    step = 1
                                } else {
                                    if viewModel.isFormValid && viewModel.isDetailsValid {
                                        viewModel.register()
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                            showHome = true
                                        }
                                    } else {
                                        viewModel.showAlert = true
                                        viewModel.alertMessage = "Por favor completa correctamente todos los datos antes de continuar."
                                    }
                                }
                            }) {
                                HStack {
                                    if viewModel.isLoading && step == 1 {
                                        ProgressView()
                                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                            .scaleEffect(0.8)
                                    } else {
                                        Image(systemName: "arrow.right.circle.fill")
                                            .font(.system(size: 20))
                                        Text(step == 0 ? "Continuar" : "Registrarme")
                                            .font(.system(size: 16, weight: .semibold))
                                    }
                                }
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(
                                    LinearGradient(
                                        gradient: Gradient(colors: [Color.pink, Color.pink.opacity(0.8)]),
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .shadow(color: Color.pink.opacity(0.3), radius: 8, x: 0, y: 4)
                            }
                        }
                        .padding(.horizontal, 30)
                        .disabled(
                            step == 1 && (!viewModel.isDetailsValid || !hasModifiedDetails || viewModel.isLoading)
                        )
                        .opacity(
                            step == 0 ? 1.0 : (viewModel.isDetailsValid && hasModifiedDetails ? 1.0 : 0.6)
                        )
                        

                    }
                }
            }
            .fullScreenCover(isPresented: $showHome) {
                NavigationStack {
                    HomeView()
                }
            }
            .alert("Información", isPresented: $viewModel.showAlert) {
                Button("OK") { }
            } message: {
                Text(viewModel.alertMessage)
            }
            .onTapGesture {
                hideKeyboard()
            }
        }
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}


#Preview {
    SignUpView()
}
