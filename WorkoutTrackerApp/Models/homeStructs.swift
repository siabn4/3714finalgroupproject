//
//  homeStructs.swift
//  login
//
//  Created by CS3714 on 12/3/25.
//

import Foundation
import SwiftUI

// MARK: - Search Bar
struct SearchBar: View {
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            Text("Search")
                .foregroundColor(.gray)
            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(30)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
        .padding(.horizontal)
        .padding(.top, 10)
    }
}

// MARK: - Category Grid
struct CategoryGrid: View {
    @ObservedObject var userManager: UserManager
    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
            
            NavigationLink(destination: MyProfileView(userManager: userManager)) {
                CategoryCard(
                    title: "My Profile",
                    color: Color(red: 0.8, green: 0.4, blue: 0.2),
                    icon: "sun.max.fill"
                )
            }

            NavigationLink(destination: LaunchView().navigationBarBackButtonHidden(true)) {
                CategoryCard(
                    title: "Log Out",
                    color: Color(red: 0.2, green: 0.15, blue: 0.4),
                    icon: "moon.stars.fill"
                )
            }

            NavigationLink(destination: ContentView()) {
                CategoryCard(
                    title: "Move",
                    color: Color(red: 0.8, green: 0.3, blue: 0.5),
                    icon: "figure.run"
                )
            }

            NavigationLink(destination: JournalView()) {
                CategoryCard(
                    title: "Journal",
                    color: Color(red: 0.1, green: 0.4, blue: 0.8),
                    icon: "book.closed"
                )
            }

        }
        .padding(.horizontal)
    }
}

// MARK: - Category Card
struct CategoryCard: View {
    let title: String
    let color: Color
    let icon: String
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                Spacer()
            }
            Spacer()
            HStack {
                Spacer()
                Image(systemName: icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white.opacity(0.6))
            }
        }
        .padding()
        .frame(height: 80)
        .background(color)
        .cornerRadius(16)
    }
}

// MARK: - Featured Program Card
struct FeaturedProgramCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Guided Program")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(8)
                    
                    Text("Strength Unlimited")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    HStack(spacing: 4) {
                        Image(systemName: "chart.bar.fill")
                        Text("Beginner level")
                    }
                    .font(.caption)
                    .foregroundColor(.gray)
                    
                    HStack(spacing: 4) {
                        Image(systemName: "calendar")
                        Text("4 weeks • 30 mins a day")
                    }
                    .font(.caption)
                    .foregroundColor(.gray)
                }
                .padding()
                
                Spacer()
                    .frame(width: 100, height: 140)
                    .clipped()
            }
        }
        .background(Color.gray.opacity(0.15))
        .cornerRadius(16)
    }
}

// MARK: - Course Banner
struct CourseBanner: View {
    let title: String
    let color: Color
    let icon: String
    let bgPattern: AnyView
    
    var body: some View {
        ZStack {
            color
            
            GeometryReader { geo in
                bgPattern
                    .frame(width: geo.size.width, height: geo.size.height)
                    .clipped()
            }
            
            HStack {
                Text(title)
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
                
                Spacer()
                
                Image(systemName: "play.fill")
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Color.white.opacity(0.3))
                    .clipShape(Circle())
            }
            .padding()
        }
        .frame(height: 80)
        .cornerRadius(16)
    }
}

// MARK: - Courses List
struct CoursesList: View {
    var body: some View {
        VStack(spacing: 16) {
            CourseBanner(
                title: "Beginning Meditation",
                color: .orange,
                icon: "face.smiling.fill",
                bgPattern: AnyView(
                    Circle()
                        .fill(Color.yellow.opacity(0.5))
                        .offset(x: 50, y: 20)
                )
            )
            
            CourseBanner(
                title: "Basics of Journaling",
                color: Color(red: 0.2, green: 0.6, blue: 1.0),
                icon: "cloud.fill",
                bgPattern: AnyView(
                    Image(systemName: "cloud.fill")
                        .resizable()
                        .foregroundColor(.white.opacity(0.3))
                        .frame(width: 100, height: 60)
                        .offset(x: 60, y: 30)
                )
            )
            
            CourseBanner(
                title: "Home Exercise Insights",
                color: Color(red: 1.0, green: 0.5, blue: 0.7),
                icon: "heart.fill",
                bgPattern: AnyView(
                    Rectangle()
                        .fill(Color.orange)
                        .rotationEffect(.degrees(45))
                        .offset(x: 80, y: 0)
                )
            )
        }
        .padding(.horizontal)
        .padding(.bottom, 20)
    }
}
