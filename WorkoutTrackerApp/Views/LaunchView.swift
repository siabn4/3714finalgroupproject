//
//  LaunchView.swift
//  login
//
//  Created by CS3714 on 12/3/25.
//

import SwiftUI

struct LaunchView: View {
    @State private var isAuthenticated = false
    @StateObject private var userManager = UserManager()   // ⭐ Create a single instance

    var body: some View {
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
