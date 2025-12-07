//
//  TaskViewModel.swift
//  WorkoutTrackerApp
//
//  Created by CS3714 on 10/10/25.
//

import Foundation
import Combine
import SwiftUI

final class TaskViewModel: ObservableObject {
    // Array of current tasks in the system
    @Published var tasks: [Task] = []

    // Supported workout categories
    @Published var categories: [String] = [
        "Chest", "Back", "Legs", "Shoulders", "Arms", "Core", "Cardio"
    ]

    // Initializes view model (seeds sample data on creation)
    init() {
        seedSampleData()
    }

    // Adds a new task
    func addTask(_ task: Task) {
        tasks.append(task)
    }

    // Updates existing task if found by id
    func updateTask(_ task: Task) {
        guard let idx = tasks.firstIndex(where: { $0.id == task.id}) else { return }
        tasks[idx] = task
    }

    // Deletes a task at the specified offsets
    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }

    // Cycles the status of a task among notStarted, inProgress, complete
    func cycleStatus(for taskID: UUID) {
        guard let idx = tasks.firstIndex(where: { $0.id == taskID }) else { return }
        switch tasks[idx].status {
        case .notStarted: tasks[idx].status = .inProgress
        case .inProgress: tasks[idx].status = .notStarted
        case .complete: tasks[idx].status = .notStarted
        }
    }

    // Adds a new category (if not empty or existing)
    func addCategory(_ name: String) {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty, !categories.contains(trimmed) else { return }
        categories.append(trimmed)
    }

    // Policies for how to handle category deletions
    enum CategoryDeletePolicy { case preventIfUsed, moveToUncategorized, deleteTasks}

    // Deletes category based on policy: prevent, move tasks, or delete tasks
    func deleteCategory(_ name: String, policy: CategoryDeletePolicy = .moveToUncategorized) {
        guard categories.contains(name) else { return }
        switch policy {
        case .preventIfUsed:
            let used = tasks.contains { $0.category == name}
            guard !used else { return }
            categories.removeAll { $0 == name }
        case .moveToUncategorized:
            if !categories.contains("Uncategorized") { categories.append("Uncategorized") }
            for i in tasks.indices { if tasks[i].category == name { tasks[i].category = "Uncategorized"} }
            categories.removeAll { $0 == name }
        case .deleteTasks:
            tasks.removeAll { $0.category == name }
            categories.removeAll { $0 == name }
        }
    }

    // Computes estimated time spent for each category
    var timeByCategory: [String: Double] {
        let grouped = Dictionary(grouping: tasks, by: { $0.category })
        var out: [String: Double] = [:]
        for (cat, list) in grouped { out[cat] = list.reduce(0.0) { $0 + $1.estimatedTime }}
        return out
    }

    // Deletes tasks by their IDs
    func deleteTasks( with ids: [UUID] ) {
        tasks.removeAll { ids.contains($0.id) }
    }

    // Seeds the task list with sample data for demonstration or testing
    private func seedSampleData() {
        let demo: [Task] = [
            Task(title: "Bench Press 5x5", description: "Warmup + working sets", dueDate: Date().addingTimeInterval(60*60*24), category: "Chest", estimatedTime: 1.0, status: .notStarted),
            Task(title: "Deadlift triples", description: "Work up to RPE 8", dueDate: Date().addingTimeInterval(60*60*48), category: "Back", estimatedTime: 1.2, status: .inProgress),
            Task(title: "Leg Day: Leg Press", description: "Quad focus", dueDate: Date().addingTimeInterval(60*60*72), category: "Legs", estimatedTime: 1.5, status: .complete)
        ]
        tasks = demo
    }
}
