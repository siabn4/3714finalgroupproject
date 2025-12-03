//
//  CompletedTasksView.swift
//  WorkoutTrackerApp
//
//  Created by CS3714 on 10/10/25.
//

import SwiftUI



struct CompletedTasksView: View {
    @EnvironmentObject private var vm: TaskViewModel
    
    private var completed: [Task] {vm.tasks.filter {$0.status == .complete } }
    
    var body: some View {
        List(completed) { task in
            TaskRowView(task: task) {}
        }
        .overlay {
            if completed.isEmpty {
                ContentUnavailableView("No Completed Workouts", systemImage: "checkmrk.seal", description: Text("Mark tasks as complete to see them here."))
            }
        }
        .navigationTitle("Completed")
    }
}
