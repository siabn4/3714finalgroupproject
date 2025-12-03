//
//  Task.swift
//  WorkoutTrackerApp
//
//  Created by CS3714 on 10/10/25.
//

import Foundation
import SwiftUI

enum TaskStatus: String, CaseIterable, Identifiable, Codable {
    case notStarted = "Not Started"
    case inProgress = "In Progress"
    case complete = "Complete"
    
    var id: String { rawValue }
    
    var iconName: String{
        switch self {
        case .notStarted: return "circle"
        case .inProgress: return "circle.lefthalf.filled"
        case .complete: return "checkmark.circle.fill"
        }
    }
    
    var color: Color{
        switch self{
        case .notStarted: return .red
        case .inProgress: return .yellow
        case .complete: return .green
        }
    }
}

struct Task: Identifiable, Codable {
    let id: UUID
    var title: String
    var description: String
    var dueDate: Date
    var category: String
    var estimatedTime: Double
    var status: TaskStatus
    
    init(id: UUID = UUID(), title: String, description: String = "", dueDate: Date, category: String, estimatedTime: Double = 1.0, status: TaskStatus = .notStarted){
        self.id = id
        self.title = title
        self.description = description
        self.dueDate = dueDate
        self.category = category
        self.estimatedTime = estimatedTime
        self.status = status
    }
    
}

