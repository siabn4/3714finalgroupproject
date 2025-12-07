//
//  ContentView.swift
//  WorkoutTrackerApp
//
//  Created by CS3714 on 10/10/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var vm: TaskViewModel
    @State private var selectedTab = 0 // Tracks which tab is selected

    var body: some View {
        TabView(selection: $selectedTab) {
            // Tab 0: All Tasks
            NavigationStack {
                TaskListView()
            }
            .tabItem { Label("Tasks", systemImage: "list.bullet") }
            .tag(0)

            // Tab 1: Completed Tasks
            NavigationStack {
                CompletedTasksView()
            }
            .tabItem { Label("Completed", systemImage: "checkmark.circle") }
            .tag(1)

            // Tab 2: Time by Category Summary
            NavigationStack {
                CategorySummaryView()
            }
            .tabItem { Label("Summary", systemImage: "chart.bar") }
            .tag(2)

            // Tab 3: Manage Categories
            NavigationStack {
                CategoryManagerView()
            }
            .tabItem { Label("Categories", systemImage: "folder") }
            .tag(3)
        }
    }
}

#Preview {
    ContentView().environmentObject(TaskViewModel())
}
