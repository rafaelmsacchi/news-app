import SwiftUI

@main
struct TestApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}

struct MainView: View {
    
    var body: some View {
        TabView {
            HomeView(viewModel: HomeViewModel())
                .tabItem {
                    Label("Home", systemImage: "heart.fill")
                }
            EmptyView()
                .tabItem {
                    Label("Favorites", systemImage: "star.fill")
                }
        }
    }
    
}
