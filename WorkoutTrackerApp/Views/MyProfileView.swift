//
//  MyProfileView.swift
//  WorkoutTrackerApp
//
//  Created by Saveer Pande on 12/7/25.
//

import SwiftUI

struct MyProfileView: View {
    var body: some View {
        let randomWorkOuts = Int.random(in: 0...1000)

        VStack(spacing: 24) {

            // MARK: - Profile Picture + Name
            VStack(spacing: 8) {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 90, height: 90)
                    .foregroundColor(.blue.opacity(0.8))

                Text("Froggy Frogard")
                    .font(.title2)
                    .fontWeight(.bold)

                Text("Age 21 • Male")
                    .foregroundColor(.gray)
            }

            // MARK: - Stats Card
            VStack(spacing: 20) {
                HStack {
                    StatItem(title: "Height", value: "5'11\"")
                    Spacer()
                    StatItem(title: "Weight", value: "178 lbs")
                }

                Divider()

                HStack {
                    StatItem(title: "Workouts", value: "\(randomWorkOuts)")
                    Spacer()
                    StatItem(title: "Weekly Avg", value: "4 sessions")
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(color: .black.opacity(0.05), radius: 6, y: 3)

            Spacer()
        }
        .padding()
        .background(Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all))
        .navigationTitle("My Profile")
    }
}

// MARK: - Stat Item
struct StatItem: View {
    let title: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(value)
                .font(.system(size: 18, weight: .bold))
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
}
#Preview {
    MyProfileView()
}
