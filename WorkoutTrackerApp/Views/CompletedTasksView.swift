//
//  CompletedTasksView.swift
//  WorkoutTrackerApp
//
//  Created by CS3714 on 10/10/25.
//

import SwiftUI

struct CompletedTasksView: View {
    @EnvironmentObject private var vm: TaskViewModel

    // Filters only completed tasks from all tasks
    private var completed: [Task] { vm.tasks.filter { $0.status == .complete } }

    var body: some View {
        List(completed) { task in
            // Show a row for each completed task (no tap/cycle)
            TaskRowView(task: task) {}
        }
        // Overlay with content unavailable view if no completed tasks found
        .overlay {
            if completed.isEmpty {
                ContentUnavailableView(
                    "No Completed Workouts",
                    systemImage: "checkmrk.seal",
                    description: Text("Mark tasks as complete to see them here.")
                )
            }
        }
        .navigationTitle("Completed")
    }
}
