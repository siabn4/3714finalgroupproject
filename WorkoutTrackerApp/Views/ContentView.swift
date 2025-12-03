//
//  ContentView.swift
//  WorkoutTrackerApp
//
//  Created by CS3714 on 10/10/25.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject private var vm: TaskViewModel
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack {
                TaskListView()
            }
            .tabItem { Label("Tasks", systemImage: "list.bullet") }
            .tag(0)
            
            NavigationStack {
                CompletedTasksView()
            }
            .tabItem { Label("Completed", systemImage: "checkmark.circle") }
            .tag(1)
            
            NavigationStack {
                CategorySummaryView()
            }
            .tabItem { Label("Summary", systemImage: "chart.bar") }
            .tag(2)
            
            NavigationStack{
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
