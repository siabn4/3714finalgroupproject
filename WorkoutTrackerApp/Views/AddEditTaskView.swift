//
//  AddEditTaskView.swift
//  WorkoutTrackerApp
//
//  Created by CS3714 on 10/10/25.
//

import SwiftUI

struct AddEditTaskView: View {
    enum Mode { case add, edit(Task) } // Controls add/edit state

    @EnvironmentObject private var vm: TaskViewModel
    @Environment(\.dismiss) private var dismiss

    let mode: Mode // Keeps track if adding or editing an existing task

    // UI states for task fields
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var dueDate: Date = Date()
    @State private var category: String = ""
    @State private var estimatedTime: Double = 1.0
    @State private var status: TaskStatus = .notStarted

    init(mode: Mode) { self.mode = mode }

    var body: some View {
        Form {
            Section("Task Details") {
                TextField("Title", text: $title)
                TextField("Description", text: $description, axis: .vertical)
                    .lineLimit(1...3)
            }

            Section("Planning") {
                DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
                Picker("Category", selection: $category) {
                    ForEach(vm.categories, id: \.self) { Text($0).tag($0) }
                }
                Stepper("Estimated Time: \(estimatedTime, specifier: "%.1f") hrs", value: $estimatedTime, in: 0.5...20, step: 0.5)
                Picker("Status", selection: $status) {
                    ForEach(TaskStatus.allCases) { s
                        in Label(s.rawValue, systemImage: s.iconName).tag(s)
                    }
                }
            }
        }
        .navigationTitle(titleForMode) // Title changes between "Add" and "Edit"
        .toolbar {
            ToolbarItem(placement: .topBarLeading) { Button("Cancel", role: .cancel) { dismiss() } }
            ToolbarItem(placement: .topBarTrailing) { Button("Save", action: save) }
        }
        .onAppear(perform: loadIfNeeded) // Preloads task data in edit mode
    }

    // Provides navigation title
    private var titleForMode: String {
        switch mode { case .add: return "Add Task"; case .edit: return "Edit Task" }
    }

    // Loads existing task data if editing, sets defaults if adding
    private func loadIfNeeded() {
        if case let .edit(task) = mode {
            title = task.title
            description = task.description
            dueDate = task.dueDate
            category = vm.categories.contains(task.category) ? task.category : (vm.categories.first ?? "")
            estimatedTime = task.estimatedTime
            status = task.status
        } else {
            category = vm.categories.first ?? "Uncategorized"
        }
    }

    // Handles saving logic for both add and edit modes
    private func save() {
        let trimmed = title.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        let newTask = Task(title: trimmed, description: description, dueDate: dueDate, category: category, estimatedTime: estimatedTime, status: status)
        switch mode {
        case .add:
            vm.addTask(newTask)
        case .edit(let original):
            vm.updateTask(Task(id: original.id, title: trimmed, description: description, dueDate: dueDate, category: category, estimatedTime: estimatedTime, status: status))
        }
        dismiss()
    }
}
