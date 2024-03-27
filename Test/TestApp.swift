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
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "heart.fill")
                }
            HomeView()
                .tabItem {
                    Label("US Elections", systemImage: "star.fill")
                }
        }
    }
    
}
