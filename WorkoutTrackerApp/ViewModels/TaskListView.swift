//
//  TaskListView.swift
//  WorkoutTrackerApp
//
//  Created by CS3714 on 10/10/25.
//

import SwiftUI

struct TaskListView: View {
    // Access shared task/view model
    @EnvironmentObject private var vm: TaskViewModel

    // Shows add-task sheet
    @State private var showAdd = false
    // Tracks which task is being edited
    @State private var editTask: Task? = nil
    // Toggles sorting by due date
    @State private var sortByDueDate = true
    // Stores current filter category
    @State private var filterCategory: String? = nil

    // Computes the list of tasks to display, filtered and sorted as needed
    private var displayedTasks: [Task] {
        var list = vm.tasks
        // Filter by selected category
        if let cat = filterCategory { list = list.filter { $0.category == cat }}
        // Sort if enabled
        if sortByDueDate { list.sort { $0.dueDate < $1.dueDate } }
        return list
    }

    // Main UI
    var body: some View {
        List {
            // Category filter bar if categories exist
            if !vm.categories.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        // 'All' button resets filter
                        Button(action: { filterCategory = nil }) {
                            Label("All", systemImage: "line.3.horizontal.decrease.circle")
                        }
                        .buttonStyle(.bordered)
                        // Buttons for each category to filter
                        ForEach(vm.categories, id: \.self) { cat in
                            Button(action: {filterCategory = cat }) {
                                Text(cat)
                            }
                            .buttonStyle(.bordered)
                            .tint(filterCategory == cat ? .accentColor : .gray)
                        }
                    }
                    .padding(.vertical, 4)
                }
            }

            // List out each task row, tap to edit, swipe to delete
            ForEach(displayedTasks) { task in
                TaskRowView(task: task){
                    vm.cycleStatus(for: task.id)
                }
                .contentShape(Rectangle())
                .onTapGesture { editTask = task}
            }
            .onDelete { offsets in
                let ids = offsets.map { displayedTasks[$0].id }
                vm.deleteTasks(with: ids)
            }
        }
        .navigationTitle("Workout Tasks")
        // Toolbar: sort toggle and add button
        .toolbar {
            ToolbarItemGroup(placement: .topBarLeading) {
                Toggle(isOn: $sortByDueDate) { Image(systemName: "calendar") }
            }
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button { showAdd = true } label: { Image(systemName: "plus") }
            }
        }
        // Show add/edit sheets
        .sheet(isPresented: $showAdd) {
            NavigationStack { AddEditTaskView(mode: .add) }
        }
        .sheet(item: $editTask) { task in
            NavigationStack { AddEditTaskView(mode: .edit(task)) }
        }
    }
}

