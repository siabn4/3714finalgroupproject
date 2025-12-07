//
//  LoginView.swift
//  login
//
//  Created by CS3714 on 12/3/25.
//

import SwiftUI
import LocalAuthentication

// LoginView handles manual credential input and presents a few dummy
// external sign-in buttons (FaceID, Google, Apple). It communicates
// authentication success to its parent via the isAuthenticated binding.

struct LoginView: View {

    // Observed manager that holds user/profile data (shared from LaunchView).
    @ObservedObject var userManager: UserManager

    // Local form state for username and password fields.
    @State private var username = ""
    @State private var password = ""

    // Alert presentation state to show authentication messages/errors.
    @State private var showingAlert = false
    @Binding var isAuthenticated: Bool
    @State private var alertMessage = ""

    // Manual login accounts with linked SWAPI IDs
    let users: [User] = [
        User(username: "Boba Fett", password: "1234", swapiID: 22),
        User(username: "Jar Jar Binks", password: "1234", swapiID: 36),
        User(username: "Chewbacca", password: "1234", swapiID: 13),
        User(username: "Shaak Ti", password: "1234", swapiID: 78),
        User(username: "Bib Fortuna", password: "1234", swapiID: 45),
        User(username: "Cliegg Lars", password: "1234", swapiID: 62),
        User(username: "Tion Medon", password: "1234", swapiID: 83),
        User(username: "Wilhuff Tarkin", password: "1234", swapiID: 12)
    ]

    var body: some View {

        VStack {
            //Title
            Text("EQUIL")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(.purple) // optional styling
                .padding(.top, 40)
            
            Text("Login")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            //User
            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            //PWD
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            // Primary login button - calls loginWithCredentials to validate local demo users.
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

            // ---- Dummy Buttons ----
            // Face ID button - placeholder for biometric authentication.
            Button(action: { dummyFaceID() }) {
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

            Button(action: { dummyGoogle() }) {
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

            Button(action: { dummyGoogle() }) {
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
    }

    // MARK: - Login Logic

    func loginWithCredentials() {
        if let user = users.first(where: { $0.username == username && $0.password == password }) {
            alertMessage = "Login Successful!"
            showingAlert = true
            isAuthenticated = true

            // Fetch SWAPI profile for this user
            userManager.fetchUser(user.swapiID)

        } else {
            alertMessage = "Incorrect username or password."
            showingAlert = true
            isAuthenticated = false
        }
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

// Simple manual login model
struct User {
    let username: String
    let password: String
    let swapiID: Int
}

#Preview {
    LoginView(userManager: UserManager(), isAuthenticated: .constant(false))
}
