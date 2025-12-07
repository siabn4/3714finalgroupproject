//
//  CategorySummaryView.swift
//  WorkoutTrackerApp
//
//  Created by CS3714 on 10/10/25.
//

import SwiftUI

struct CategorySummaryView: View {
    @EnvironmentObject private var vm: TaskViewModel

    // Get category summary sorted by name
    private var sortedSummary: [(key: String, value: Double)] {
        vm.timeByCategory.sorted { $0.key < $1.key }
    }

    var body: some View {
        List {
            // Show each category and associated hours
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
