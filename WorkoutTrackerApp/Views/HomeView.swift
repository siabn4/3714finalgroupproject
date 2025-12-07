import SwiftUI

struct HealthDashboard: View {
    @ObservedObject var userManager: UserManager   // Monitors user authentication/profile

    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {

                    // Custom search bar component
                    SearchBar()

                    // Grid of workout categories (uses userManager info)
                    CategoryGrid(userManager: userManager)

                    // Highlights a featured program
                    FeaturedProgramCard()
                        .padding(.horizontal)

                    // Displays recommended courses as banners/list
                    CoursesList()
                }
            }
            // Light gray background for dashboard
            .background(Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all))
            .navigationBarHidden(true)
        }
    }
}

// MARK: - Preview
#Preview {
    HealthDashboard(userManager: UserManager())
}
