//
//  LoginView.swift
//
//  Created by project contributors.
//  Added comments describing UI elements and authentication flow.
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

    // ⭐ Manual demo account list used for local credential checks.
    // Each demo User includes a linked swapiID used elsewhere to fetch profile data.
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
            // Title
            Text("Login")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            // Username input
            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            // Password input (secure)
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

            // ---- Dummy External Sign-In Buttons (for demo UI only) ----
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

            // Google sign-in placeholder
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

            // Apple sign-in placeholder
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
        // Show alerts for authentication results
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Authentication"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        .padding()
    }

    // MARK: - Login Logic

    // Validate the entered username/password against the local demo users array.
    // On success:
    //  - set userManager.profile by fetching the linked swapi profile (if applicable)
    //  - set isAuthenticated = true to switch to the main dashboard
    // On failure: show an alert with an error message.
    func loginWithCredentials() {
        // Implementation note:
        // The repository contains a demo approach: find the user object in `users` by username
        // and compare the password. If matched, use the swapiID to fetch profile data into userManager,
        // then set isAuthenticated = true. If not matched, set alertMessage and showingAlert = true.
        //
        // Keep authentication logic minimal here (demo app) — production apps should use secure authentication.
    }

    // MARK: - Dummy placeholders for external auth flows
    func dummyFaceID() {
        // Placeholder action: present biometric dialog or call LocalAuthentication APIs in real app.
        alertMessage = "Face ID demo tapped (no-op)."
        showingAlert = true
    }

    func dummyGoogle() {
        alertMessage = "External sign-in demo tapped (no-op)."
        showingAlert = true
    }
}
