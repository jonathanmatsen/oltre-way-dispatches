import SwiftUI

/// Home tab — featured/latest content in a vertical scroll
struct HomeView: View {
    @Binding var showMenu: Bool
    @EnvironmentObject var articleViewModel: ArticleViewModel
    @EnvironmentObject var savedViewModel: SavedViewModel
    @State private var selectedArticle: Article?
    @State private var showGlobeTransition = false

    var body: some View {
        NavigationStack {
            ZStack {
                OltreColors.cream.ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 0) {
                        // Hero card for featured article
                        if let featured = articleViewModel.featuredArticle {
                            HeroArticleCard(article: featured) {
                                triggerArticleOpen(featured)
                            }
                        }

                        // Article feed
                        LazyVStack(spacing: 24) {
                            ForEach(articleViewModel.filteredArticles().dropFirst(1)) { article in
                                ArticleCardView(article: article) {
                                    triggerArticleOpen(article)
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 24)
                        .padding(.bottom, 100)
                    }
                }
                .refreshable {
                    articleViewModel.loadContent()
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            showMenu = true
                        }
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .foregroundColor(OltreColors.textDark)
                    }
                }

                ToolbarItem(placement: .principal) {
                    Text("THE OLTRE WAY")
                        .font(OltreFonts.category(11))
                        .tracking(3)
                        .foregroundColor(OltreColors.deepBurgundy)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .fullScreenCover(isPresented: $showGlobeTransition) {
                if let article = selectedArticle {
                    GlobeTransitionView(article: article)
                }
            }
        }
    }

    private func triggerArticleOpen(_ article: Article) {
        selectedArticle = article
        showGlobeTransition = true
    }
}

// MARK: - Hero Article Card

struct HeroArticleCard: View {
    let article: Article
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            ZStack(alignment: .bottomLeading) {
                // Hero image placeholder
                Rectangle()
                    .fill(
                        LinearGradient(
                            colors: heroGradient(for: article),
                            startPoint: .topTrailing,
                            endPoint: .bottomLeading
                        )
                    )
                    .frame(height: 420)
                    .overlay(
                        // Attempt to load actual image
                        Image(article.heroImageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipped()
                    )
                    .clipped()

                // Gradient overlay for text readability
                LinearGradient(
                    colors: [.clear, .black.opacity(0.7)],
                    startPoint: .center,
                    endPoint: .bottom
                )

                // Text overlay
                VStack(alignment: .leading, spacing: 8) {
                    // Category tag
                    Text(article.category.rawValue.uppercased())
                        .font(OltreFonts.category(10))
                        .tracking(2)
                        .foregroundColor(OltreColors.goldAccent)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(Color.black.opacity(0.3))

                    Text(article.title)
                        .font(OltreFonts.bold(26))
                        .foregroundColor(.white)
                        .lineLimit(3)

                    Text(article.subtitle)
                        .font(OltreFonts.body(14))
                        .foregroundColor(.white.opacity(0.8))
                        .lineLimit(2)

                    HStack(spacing: 12) {
                        Text(article.author)
                            .font(OltreFonts.regular(12))
                            .foregroundColor(.white.opacity(0.6))

                        Text("·")
                            .foregroundColor(.white.opacity(0.4))

                        Text("\(article.estimatedReadTime) min read")
                            .font(OltreFonts.regular(12))
                            .foregroundColor(.white.opacity(0.6))
                    }
                }
                .padding(24)
            }
        }
        .buttonStyle(.plain)
    }

    private func heroGradient(for article: Article) -> [Color] {
        switch article.id {
        case SampleData.jacksonHoleID:
            return [Color(hex: "8a9aac"), Color(hex: "3a4a5c")]
        case SampleData.banffID:
            return [Color(hex: "c8d8e8"), Color(hex: "3a5a6a")]
        case SampleData.miamiID:
            return [Color(hex: "1a1028"), Color(hex: "0A0A0F")]
        default:
            return [OltreColors.navy, OltreColors.charcoal]
        }
    }
}
