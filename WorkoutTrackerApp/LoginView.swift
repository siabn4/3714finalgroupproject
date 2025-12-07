//
//  LoginView.swift
//  login
//
//  Created by CS3714 on 12/3/25.
//

import SwiftUI
import LocalAuthentication

struct LoginView: View {
    
    @ObservedObject var userManager: UserManager        // ⭐ NEW
    
    @State private var username = ""
    @State private var password = ""
    
    @State private var showingAlert = false
    @Binding var isAuthenticated: Bool
    @State private var alertMessage = ""
    
    // ⭐ Keep your original dummy login credentials
    let correctUsername = "froggy"
    let correctPassword = "1234"
    
    var body: some View {
        
        VStack {
            Text("Login")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: {
                loginWithCredentials()
            }) {
                Text("Login")
                    .font(.headline)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(10)
            }
            .padding(.top, 10)
            
            
            // ---- Dummy Buttons (Unchanged) ----
            
            Button(action: {
                dummyFaceID()
            }) {
                HStack {
                    Image(systemName: "faceid").font(.title)
                    Text("Sign In with Face ID").font(.headline)
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(10)
            }
            .padding(.top, 10)
            
            
            Button(action: {
                dummyGoogle()
            }) {
                HStack {
                    Image(systemName: "g.circle").font(.title)
                    Text("Sign in with Google").font(.headline)
                }
                .padding()
                .foregroundColor(.red)
                .background(Color.white)
                .border(Color.black, width: 3)
                .cornerRadius(5)
            }
            .padding(.top, 10)
            
            
            Button(action: {
                dummyGoogle()
            }) {
                HStack {
                    Image(systemName: "apple.logo").font(.title)
                    Text("Sign in with AppleID").font(.headline)
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.black)
                .border(Color.black, width: 3)
                .cornerRadius(5)
            }
            .padding(.top, 10)
            
            Spacer()
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Authentication"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        .padding()
        .onAppear {
            userManager.fetchUsers()        // ⭐ Load your 8 SWAPI users
        }
    }
    
    
    // MARK: - Login Logic
    
    func loginWithCredentials() {
        
        // ⭐ First: Try hard-coded dummy login
        if username == correctUsername && password == correctPassword {
            alertMessage = "Login Successful (Dummy User)!"
            showingAlert = true
            isAuthenticated = true
            return
        }
        
        // ⭐ Second: Try SWAPI user login
        if let matchedUser = userManager.allUsers.first(where: {
            $0.name.lowercased() == username.lowercased()
        }) {
            if password == matchedUser.birth_year {
                alertMessage = "Login Successful (SWAPI User)!"
                isAuthenticated = true
            } else {
                alertMessage = "Incorrect password."
                isAuthenticated = false
            }
        } else {
            alertMessage = "User not found."
            isAuthenticated = false
        }
        
        showingAlert = true
    }
    
    
    // MARK: - Dummy Authentication Buttons
    
    func dummyFaceID() {
        alertMessage = "Pretending to authenticate… Success!"
        showingAlert = true
        isAuthenticated = true
    }
    
    func dummyGoogle() {
        alertMessage = "Pretending to authenticate… Success!"
        showingAlert = true
        isAuthenticated = true
    }
}

#Preview {
    LoginView(userManager: UserManager(), isAuthenticated: .constant(false))
}
