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
    @Published var tasks: [Task] = []
    @Published var categories: [String] = [
        "Chest", "Back", "Legs", "Shoulders", "Arms", "Core", "Cardio"
    ]
    
    
    init() {
        seedSampleData()
    }


    func addTask(_ task: Task) {
        tasks.append(task)
    }

    func updateTask(_ task: Task) {
        guard let idx = tasks.firstIndex(where: { $0.id == task.id}) else { return }
        tasks[idx] = task
    }

    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }

    func cycleStatus(for taskID: UUID) {
        guard let idx = tasks.firstIndex(where: { $0.id == taskID }) else { return }
        switch tasks[idx].status {
        case .notStarted: tasks[idx].status = .inProgress
        case .inProgress: tasks[idx].status = .notStarted
        case .complete: tasks[idx].status = .notStarted
        }
    }
    
    func addCategory(_ name: String) {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty, !categories.contains(trimmed) else { return }
        categories.append(trimmed)
    }
    
    
    enum CategoryDeletePolicy { case preventIfUsed, moveToUncategorized, deleteTasks}
    
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
    
    var timeByCategory: [String: Double] {
        let grouped = Dictionary(grouping: tasks, by: { $0.category })
        var out: [String: Double] = [:]
        for (cat, list) in grouped { out[cat] = list.reduce(0.0) { $0 + $1.estimatedTime }}
        return out
    }
    
    func deleteTasks( with ids: [UUID] ) {
        tasks.removeAll { ids.contains($0.id) }
    }
    
    private func seedSampleData() {
        let demo: [Task] = [
            Task(title: "Bench Press 5x5", description: "Warmup + working sets", dueDate: Date().addingTimeInterval(60*60*24), category: "Chest", estimatedTime: 1.0, status: .notStarted),
            Task(title: "Deadlift triples", description: "Work up to RPE 8", dueDate: Date().addingTimeInterval(60*60*48), category: "Back", estimatedTime: 1.2, status: .inProgress),
            Task(title: "Leg Day: Leg Press", description: "Quad focus", dueDate: Date().addingTimeInterval(60*60*72), category: "Legs", estimatedTime: 1.5, status: .complete)
        ]
        tasks = demo
    }
    
    

}

