//
//  CategorySummaryView.swift
//  WorkoutTrackerApp
//
//  Created by CS3714 on 10/10/25.
//

import SwiftUI

struct CategorySummaryView: View {
    @EnvironmentObject private var vm: TaskViewModel
    
    private var sortedSummary: [(key: String, value: Double)] {
        vm.timeByCategory.sorted { $0.key < $1.key }
    }
    
    var body: some View {
        List {
            ForEach(sortedSummary, id: \.key) {cat, hours in
                HStack {
                    Text(cat)
                    Spacer()
                    Text("\(hours, specifier: "%.1f") hrs")
                        .foregroundColor(.secondary)
                }}
        }
    }
}
