//
//  LaunchView.swift
//  login
//
//  Created by CS3714 on 12/3/25.
//

import SwiftUI

// LaunchView is the app's entry point view that decides whether to show
// the authenticated dashboard or the login screen.
//
// - Maintains a single UserManager instance as a @StateObject so that
//   profile/session state is shared across child views.
// - Uses a simple isAuthenticated @State boolean to toggle between
//   the LoginView and the main HealthDashboard view.
struct LaunchView: View {
    // Tracks whether the user is authenticated; toggled by LoginView when login succeeds
    @State private var isAuthenticated = false

    // Create a single instance of the user manager and keep it alive for the app session.
    // Using @StateObject ensures this object is created once for the view hierarchy.
    @StateObject private var userManager = UserManager()   // ⭐ Create a single instance

    var body: some View {
        // If authenticated, show the main dashboard and pass the shared userManager.
        // Otherwise, present the LoginView and bind the isAuthenticated flag so it can be set on success.
        if isAuthenticated {
            HealthDashboard(userManager: userManager)
        } else {
            LoginView(userManager: userManager, isAuthenticated: $isAuthenticated)
        }
    }
}

#Preview {
    LaunchView()
}
