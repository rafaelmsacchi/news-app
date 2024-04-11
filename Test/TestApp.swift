import SwiftUI

var set = Set<Int>()

extension Int {

    static func unique() -> Int {
        var result: Int = 0
        while true {
            let rand = Int.random(in: min...max)
            if !set.contains(rand) {
                set.insert(rand)
                result = rand
                break
            }
        }
        return result
    }

}

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
                HomeView(viewModel: HomeViewModel())
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
