import SwiftUI

// MARK: - Main Entry Point
struct HealthDashboard: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    
                    Image(systemName: "square.fill.on.square.fill")
                    Text("Today")
                }
            
            Text("Explore Content")
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Explore")
                }
            
            Text("Profile Content")
                .tabItem {
                    Image(systemName: "person.circle")
                    Text("George")
                }
        }
        .accentColor(.orange)
    }
}

// MARK: - Home View
struct HomeView: View {
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
struct HealthDashboard_Previews: PreviewProvider {
    static var previews: some View {
        HealthDashboard()
    }
}
