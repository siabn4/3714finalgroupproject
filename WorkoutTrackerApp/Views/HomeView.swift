import SwiftUI

// MARK: - Main Entry Point

struct HealthDashboard: View {
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    
                    // Search Bar
                    SearchBar()

                    // Category Grid
                    CategoryGrid()

                    // Featured Program
                    FeaturedProgramCard()
                        .padding(.horizontal)

                    // Course Banners List
                    CoursesList()
                }
            }
            .background(Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all))
            .navigationBarHidden(true)
        }
    }
}

// MARK: Preview
#Preview {
    HealthDashboard()
}
