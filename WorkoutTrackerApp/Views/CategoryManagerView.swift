//
//  CategoryManagerView.swift
//  WorkoutTrackerApp
//
//  Created by CS3714 on 10/10/25.
//

import SwiftUI

struct CategoryManagerView: View {
    @EnvironmentObject private var vm: TaskViewModel
    @State private var newCategory = ""
    @State private var showInUseAlert = false
    
    var body: some View {
        List {
            Section("Add Category") {
                HStack {
                    TextField("New Category (eg., Calves)", text: $newCategory)
                    Button("Add") { vm.addCategory(newCategory); newCategory = "" }
                        .buttonStyle(.borderedProminent)
                }
            }
            
            Section("All Categories") {
                ForEach(vm.categories, id: \.self) { cat in
                    HStack {
                        Image(systemName: "folder")
                        Text(cat)
                        Spacer()
                        Text("\(vm.tasks.filter{ $0.category == cat }.count)")
                            .foregroundColor(.secondary)
                    }
                }
                .onDelete { idxSet in for index in idxSet { vm.deleteCategory(vm.categories[index], policy: .moveToUncategorized) }
                }
            }
        }
        .navigationTitle("Categories")
        .toolbar { EditButton() }
    }
}
