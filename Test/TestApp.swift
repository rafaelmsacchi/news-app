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
            NavigationStack {
                HomeView()
                    .environment(HomeViewModel())
                    .tabItem {
                        Label("Home", systemImage: "heart.fill")
                    }
                    .navigationTitle("Today's News")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbarBackground(.visible, for: .navigationBar)
            }
            EmptyView()
                .tabItem {
                    Label("Favorites", systemImage: "star.fill")
                }
        }
    }
    
}
