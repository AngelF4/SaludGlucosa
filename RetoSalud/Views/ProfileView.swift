import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    @State private var logout = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // pfp header
                profileHeader
                
                // info personal
                personalInfoSection
                

                
                // configuración
                settingsSection
                
                Spacer(minLength: 100) // scroll space
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
        }
        .background(
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.pink.opacity(0.1),
                    Color.white
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
        )
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Editar") {
                    viewModel.editProfile()
                }
                .foregroundColor(.pink)
                .fontWeight(.medium)
            }
        }
    }
    
    private var profileHeader: some View {
        VStack(spacing: 16) {
            // Foto de perfil
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.pink.opacity(0.3),
                                Color.pink
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 120, height: 120)
                
                if let profileImage = viewModel.profileImage {
                    Image(uiImage: profileImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 110, height: 110)
                        .clipShape(Circle())
                } else {
                    Image(systemName: "person.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.white)
                }
            }
            .onTapGesture {
                viewModel.changeProfileImage()
            }
            
            // Nombre y descripción
            VStack(spacing: 8) {
                Text(viewModel.userName)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Text(viewModel.userDescription)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
            }
        }
    }
    
    private var personalInfoSection: some View {
        VStack(spacing: 16) {
            HStack {
                Text("Información Personal")
                    .font(.headline)
                    .fontWeight(.semibold)
                Spacer()
            }
            
            VStack(spacing: 12) {
                ProfileInfoRow(icon: "envelope.fill", title: "Email", value: viewModel.email)
                ProfileInfoRow(icon: "person.fill", title: "Edad", value: viewModel.age)
                ProfileInfoRow(icon: "cross.circle.fill", title: "Diabético", value: viewModel.isDiabetic ? "Sí" : "No")
                ProfileInfoRow(icon: "calendar", title: "Miembro desde", value: viewModel.memberSince)
            }
        }
        .padding(20)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.pink.opacity(0.1), radius: 10, x: 0, y: 5)
    }

    
    private var settingsSection: some View {
        VStack(spacing: 16) {
            HStack {
                Text("Configuración")
                    .font(.headline)
                    .fontWeight(.semibold)
                Spacer()
            }
            
            VStack(spacing: 0) {
                SettingsRow(icon: "bell.fill", title: "Notificaciones", showChevron: true) {
                    viewModel.openNotifications()
                }
                
                Divider()
                    .background(Color.pink.opacity(0.3))
                
                SettingsRow(icon: "lock.fill", title: "Privacidad", showChevron: true) {
                    viewModel.openPrivacy()
                }
                
                Divider()
                    .background(Color(hex: "FFE2E8"))
                
                SettingsRow(icon: "questionmark.circle.fill", title: "Ayuda", showChevron: true) {
                    viewModel.openHelp()
                }
                
                Divider()
                    .background(Color(hex: "FFE2E8"))
                
                SettingsRow(icon: "rectangle.portrait.and.arrow.right.fill", title: "Cerrar Sesión", showChevron: false, isDestructive: true) {
                    logout = true
                    viewModel.logout()
                }
            }
        }
        .padding(20)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.pink.opacity(0.1), radius: 10, x: 0, y: 5)
        .fullScreenCover(isPresented: $logout) {
            ContentView()
        }
    }
}

#Preview {
    NavigationView {
        ProfileView()
    }
}
