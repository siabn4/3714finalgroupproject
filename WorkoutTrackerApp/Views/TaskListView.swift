//
//  TaskListView.swift
//  WorkoutTrackerApp
//
//  Created by CS3714 on 10/10/25.
//

import SwiftUI

struct TaskListView: View {
    @EnvironmentObject private var vm: TaskViewModel
    @State private var showAdd = false
    @State private var editTask: Task? = nil
    @State private var sortByDueDate = true
    @State private var filterCategory: String? = nil
    
    private var displayedTasks: [Task] {
        var list = vm.tasks
        if let cat = filterCategory { list = list.filter { $0.category == cat }}
        if sortByDueDate { list.sort { $0.dueDate < $1.dueDate } }
        return list
    }
    
    var body: some View {
        List {
            if !vm.categories.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        Button(action: { filterCategory = nil }) {
                            Label("All", systemImage: "line.3.horizontal.decrease.circle")
                        }
                        .buttonStyle(.bordered)
                        
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
        .toolbar {
            ToolbarItemGroup(placement: .topBarLeading) {
                Toggle(isOn: $sortByDueDate) { Image(systemName: "calendar") }
            }
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button { showAdd = true } label: { Image(systemName: "plus") }
            }
        }
        .sheet(isPresented: $showAdd) {
            NavigationStack { AddEditTaskView(mode: .add) }
        }
        .sheet(item: $editTask) { task in
            NavigationStack { AddEditTaskView(mode: .edit(task)) }
        }
    }
    
}
