import SwiftUI

@main
struct TheOltreWayApp: App {
    @StateObject private var authViewModel = AuthViewModel()
    @StateObject private var articleViewModel = ArticleViewModel()
    @StateObject private var savedViewModel = SavedViewModel()

    var body: some Scene {
        WindowGroup {
            Group {
                if authViewModel.isAuthenticated {
                    MainTabView()
                } else {
                    SplashView()
                }
            }
            .environmentObject(authViewModel)
            .environmentObject(articleViewModel)
            .environmentObject(savedViewModel)
        }
    }
}
