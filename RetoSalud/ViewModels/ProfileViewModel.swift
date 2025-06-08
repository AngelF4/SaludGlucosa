import SwiftUI
import Combine

class ProfileViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var userName: String = "Juan Pérez"
    @Published var userDescription: String = "Ingeniero electromecánico"
    @Published var email: String = "maria.gonzalez@email.com"
    @Published var age: String = "53 años"
    @Published var isDiabetic: Bool = true
    @Published var memberSince: String = "Junio 2025"
    @Published var profileImage: UIImage?
    
    // MARK: - Private Properties
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    init() {
        loadUserData()
    }
    
    // MARK: - Public Methods
    func editProfile() {
        // Implementar navegación a vista de edición
        print("Editando perfil...")
    }
    
    func changeProfileImage() {
        // Implementar selección de imagen
        print("Cambiando imagen de perfil...")
        // Aquí podrías abrir ImagePicker o PHPicker
    }
    
    func openNotifications() {
        print("Abriendo configuración de notificaciones...")
    }
    
    func openPrivacy() {
        print("Abriendo configuración de privacidad...")
    }
    
    func openHelp() {
        print("Abriendo centro de ayuda...")
    }
    
    func logout() {
        print("Cerrando sesión...")
        //
    }
    
    // MARK: - Private Methods
    private func loadUserData() {
        // simulando datos
        // cargar datos de usuarios lolol
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            // Simular datos cargados
            self.objectWillChange.send()
        }
    }
    
    func updateProfile(name: String, description: String, email: String, age: String, isDiabetic: Bool) {
        self.userName = name
        self.userDescription = description
        self.email = email
        self.age = age
        self.isDiabetic = isDiabetic
        
        // guardando datos lol
        saveUserData()
    }
    
    private func saveUserData() {
        // Implementar guardado de datos
        print("Guardando datos del usuario...")
    }
}
