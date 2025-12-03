//
//  WorkoutTrackerApp.swift
//  WorkoutTrackerApp
//
//  Created by CS3714 on 10/10/25.
//

import SwiftUI

@main
struct WorkoutTrackerApp: App {
    @StateObject private var viewModel = TaskViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
