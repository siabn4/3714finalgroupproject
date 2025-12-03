//
//  TaskRowView.swift
//  WorkoutTrackerApp
//
//  Created by CS3714 on 10/10/25.
//

import SwiftUI

struct TaskRowView: View {
    let task: Task
    var onStatusTap: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            Button(action: onStatusTap) {
                Image(systemName: task.status.iconName)
                    .foregroundStyle(task.status.color)
                    .imageScale(.large)
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text(task.title)
                    .font(.headline)
                HStack(spacing: 8) {
                    Label(task.category, systemImage: "dumbell")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(task.dueDate, style: .date)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            Spacer()
            Text("\(task.estimatedTime, specifier: "%.1f")h")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 4)
    }
}
