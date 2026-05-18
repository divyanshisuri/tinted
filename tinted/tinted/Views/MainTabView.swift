import SwiftUI

struct MainTabView: View {
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
            RoutineView()
                .tabItem { Label("Routine", systemImage: "calendar") }
            MeView()
                .tabItem { Label("Me", systemImage: "person") }
        }
        .tint(Color(red: 0.07, green: 0.07, blue: 0.07))
    }
}
