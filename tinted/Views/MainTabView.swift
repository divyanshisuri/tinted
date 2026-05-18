import SwiftUI

struct MainTabView: View {
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 0.97, green: 0.95, blue: 0.93, alpha: 1)
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    var body: some View {
        TabView {
            HomeView()
                .tabItem { Label("Home", systemImage: "house") }
            DiscoverView()
                .tabItem { Label("Discover", systemImage: "magnifyingglass") }
            LiveView()
                .tabItem { Label("Live", systemImage: "play.circle") }
            ScanView()
                .tabItem { Label("Scan", systemImage: "camera.viewfinder") }
            MeView()
                .tabItem { Label("Me", systemImage: "person") }
        }
        .tint(Color(red: 0.07, green: 0.07, blue: 0.07))
    }
}
