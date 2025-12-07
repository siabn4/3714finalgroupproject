//
//  LoginView.swift
//  login
//
//  Created by CS3714 on 12/3/25.
//

import SwiftUI
import LocalAuthentication

struct LoginView: View {
    
    @State private var username = ""
    @State private var password = ""
    
    @State private var showingAlert = false
    @Binding var isAuthenticated: Bool
    @State private var alertMessage = ""
    
    let correctUsername = "Froggy"
    let correctPassword = "1234"
    
    var body: some View {
        
        
        VStack {
            Text("Login")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            // UI for username/password
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
            
            // Sign In with Face ID, Google,
            // and AppleID Buttons
            
            Button(action: {
                dummyFaceID()
            }) {
                HStack {
                    Image(systemName: "faceid")
                        .font(.title)
                    Text("Sign In with Face ID")
                        .font(.headline)
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
                    Image(systemName: "g.circle")
                        .font(.title)
                    Text("Sign in with Google")
                        .font(.headline)
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
                    Image(systemName: "apple.logo")
                        .font(.title)
                    Text("Sign in with AppleID")
                        .font(.headline)
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
    
    func loginWithCredentials() {
            if username == correctUsername && password == correctPassword {
                alertMessage = "Login Successful!"
                isAuthenticated = true
                
            } else {
                alertMessage = "Incorrect username or password."
                isAuthenticated = false
            }
            showingAlert = true
        }
    
}
#Preview {
    LoginView(isAuthenticated: .constant(false))
}
