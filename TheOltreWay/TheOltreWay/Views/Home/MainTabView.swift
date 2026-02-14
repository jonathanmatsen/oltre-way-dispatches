import SwiftUI

/// Main tab bar navigation — Home, Explore, Saved, Profile
struct MainTabView: View {
    @EnvironmentObject var articleViewModel: ArticleViewModel
    @EnvironmentObject var savedViewModel: SavedViewModel
    @State private var selectedTab: Tab = .home
    @State private var showMenu = false

    enum Tab: String, CaseIterable {
        case home = "Home"
        case explore = "Explore"
        case saved = "Saved"
        case profile = "Profile"

        var iconName: String {
            switch self {
            case .home: return "house"
            case .explore: return "globe"
            case .saved: return "bookmark"
            case .profile: return "person"
            }
        }
    }

    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                HomeView(showMenu: $showMenu)
                    .tag(Tab.home)

                ExploreView()
                    .tag(Tab.explore)

                SavedView()
                    .tag(Tab.saved)

                ProfileView()
                    .tag(Tab.profile)
            }
            .tint(OltreColors.warmTerracotta)
            .overlay(alignment: .bottom) {
                customTabBar
            }

            // Hamburger menu overlay
            if showMenu {
                HamburgerMenuView(isPresented: $showMenu)
                    .transition(.move(edge: .leading).combined(with: .opacity))
                    .zIndex(100)
            }
        }
    }

    // MARK: - Custom Tab Bar

    private var customTabBar: some View {
        HStack(spacing: 0) {
            ForEach(Tab.allCases, id: \.self) { tab in
                Button {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        selectedTab = tab
                    }
                } label: {
                    VStack(spacing: 4) {
                        Image(systemName: selectedTab == tab ? "\(tab.iconName).fill" : tab.iconName)
                            .font(.system(size: 18))
                        Text(tab.rawValue)
                            .font(OltreFonts.category(10))
                            .tracking(0.5)
                    }
                    .foregroundColor(selectedTab == tab ? OltreColors.warmTerracotta : OltreColors.textMuted)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 10)
                    .padding(.bottom, 4)
                }
            }
        }
        .padding(.bottom, 20)
        .background(
            Rectangle()
                .fill(OltreColors.cream)
                .shadow(color: .black.opacity(0.05), radius: 8, y: -4)
                .ignoresSafeArea(edges: .bottom)
        )
    }
}
