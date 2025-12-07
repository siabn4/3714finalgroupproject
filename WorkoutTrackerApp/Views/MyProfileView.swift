//
//  MyProfileView.swift
//  WorkoutTrackerApp
//
//  Created by Saveer Pande on 12/7/25.
//

import SwiftUI

struct MyProfileView: View {
    @ObservedObject var userManager: UserManager

    // Random workouts for demo purposes
    private var randomWorkouts: Int {
        Int.random(in: 0...1000)
    }

    var body: some View {
        VStack(spacing: 24) {

            // MARK: - Profile Picture + Name
            VStack(spacing: 8) {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 90, height: 90)
                    .foregroundColor(.blue.opacity(0.8))

                // Name from API or placeholder
                Text(userManager.profile?.name ?? "Unknown User")
                    .font(.title2)
                    .fontWeight(.bold)

                // Age/Other info - SWAPI birth_year used for display
                if let birthYear = userManager.profile?.birth_year {
                    Text("Birth Year: \(birthYear)")
                        .foregroundColor(.gray)
                } else {
                    Text("Birth Year: N/A")
                        .foregroundColor(.gray)
                }
            }

            // MARK: - Stats Card
            VStack(spacing: 20) {
                HStack {
                    // Height and Weight from SWAPI
                    StatItem(title: "Height", value: formattedHeight(userManager.profile?.height))
                    Spacer()
                    StatItem(title: "Weight", value: formattedWeight(userManager.profile?.mass))
                }

                Divider()

                HStack {
                    StatItem(title: "Workouts", value: "\(randomWorkouts)")
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

    // MARK: - Helpers
    func formattedHeight(_ height: String?) -> String {
        guard let h = height, let hInt = Int(h) else { return "N/A" }
        // Convert cm to ft/in
        let inchesTotal = Double(hInt) / 2.54
        let feet = Int(inchesTotal / 12)
        let inches = Int(inchesTotal) % 12
        return "\(feet)'\(inches)\""
    }

    func formattedWeight(_ mass: String?) -> String {
        guard let m = mass, let mDouble = Double(m) else { return "N/A" }
        let lbs = Int(mDouble * 2.20462) // kg to lbs
        return "\(lbs) lbs"
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
    // Provide a dummy UserManager for preview
    let userManager = UserManager()
    MyProfileView(userManager: userManager)
}
