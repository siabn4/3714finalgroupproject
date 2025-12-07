//
//  MyProfileView.swift
//  WorkoutTrackerApp
//
//  Created by Saveer Pande on 12/7/25.
//

import SwiftUI

// MyProfileView displays the user's profile information fetched via UserManager.
// - Shows avatar, display name, and a couple of simple stats derived from profile fields.
// - Uses helper functions to format height/weight and to sanitize birth year strings.
struct MyProfileView: View {
    @ObservedObject var userManager: UserManager

    // Random workout count for demo purposes (not persisted).
    private var randomWorkouts: Int {
        Int.random(in: 0...1000)
    }
    

    var body: some View {
        VStack(spacing: 24) {

            // MARK: - Profile Picture + Name
            VStack(spacing: 8) {
                // Placeholder system image used for profile avatar in demo.
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 90, height: 90)
                    .foregroundColor(.blue.opacity(0.8))

                // Display name pulled from the userManager.profile; fallback to "Unknown User"
                Text(userManager.profile?.name ?? "Unknown User")
                    .font(.title2)
                    .fontWeight(.bold)

                // Age/Other info - this demo uses SWAPI birth_year as a display value.
                if let birthYear = userManager.profile?.birth_year {
                    Text("Age:  \(cleanedBirthYear(userManager.profile?.birth_year))")
                        .foregroundColor(.gray)
                } else {
                    Text("Age: N/A")
                        .foregroundColor(.gray)
                }
            }

            // MARK: - Stats Card
            VStack(spacing: 20) {
                HStack {
                    // Height and Weight are read from the profile and converted to human-friendly strings.
                    StatItem(title: "Height", value: formattedHeight(userManager.profile?.height))
                    Spacer()
                    StatItem(title: "Weight", value: formattedWeight(userManager.profile?.mass))
                }

                Divider()

                HStack {
                    // Demo-only stats: random workouts and weekly average, meant to illustrate UI layout.
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

    // Convert SWAPI height string (cm) into feet and inches for display.
    func formattedHeight(_ height: String?) -> String {
        guard let h = height, let hInt = Int(h) else { return "N/A" }
        // Convert cm to ft/in
        let inchesTotal = Double(hInt) / 2.54
        let feet = Int(inchesTotal / 12)
        let inches = Int(inchesTotal) % 12
        return "\(feet)'\(inches)\""
    }

    // Convert SWAPI mass string (kg) into lbs for display.
    func formattedWeight(_ mass: String?) -> String {
        guard let m = mass, let mDouble = Double(m) else { return "N/A" }
        let lbs = Int(mDouble * 2.20462) // kg to lbs
        return "\(lbs) lbs"
    }
    
    // Clean the birth_year value by removing SWAPI suffixes like BBY/ABY.
    func cleanedBirthYear(_ birthYear: String?) -> String {
        guard let birthYear = birthYear else { return "N/A" }

        return birthYear
            .replacingOccurrences(of: "BBY", with: "")
            .replacingOccurrences(of: "ABY", with: "")
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

// MARK: - Stat Item
// Small reusable view to display a statistic label and value.
struct StatItem: View {
    let title: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
            Text(value)
                .font(.headline)
                .fontWeight(.semibold)
        }
    }
}
