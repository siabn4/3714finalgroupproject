//
//  LaunchView.swift
//  login
//
//  Created by CS3714 on 12/3/25.
//

import SwiftUI

struct LaunchView: View {
    @State private var isAuthenticated = false

    var body: some View {
        if isAuthenticated {
            HealthDashboard()
        } else {
            LoginView(isAuthenticated: $isAuthenticated)
        }
    }
}

#Preview {
    LaunchView()
}
