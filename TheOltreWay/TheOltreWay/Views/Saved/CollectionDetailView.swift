import SwiftUI

/// Detail view for a single collection — shows its articles as cards
struct CollectionDetailView: View {
    let collection: ArticleCollection
    @EnvironmentObject var savedViewModel: SavedViewModel
    @EnvironmentObject var articleViewModel: ArticleViewModel
    @State private var selectedArticle: Article?
    @State private var showGlobeTransition = false

    var body: some View {
        ZStack {
            OltreColors.cream.ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // Header
                    VStack(alignment: .leading, spacing: 8) {
                        Text(collection.name)
                            .font(OltreFonts.bold(24))
                            .foregroundColor(OltreColors.textDark)

                        Text("\(articles.count) articles")
                            .font(OltreFonts.regular(13))
                            .foregroundColor(OltreColors.textMuted)

                        let formatter = DateFormatter()
                        let _ = formatter.dateFormat = "MMM d, yyyy"
                        Text("Created \(formatter.string(from: collection.createdDate))")
                            .font(OltreFonts.regular(12))
                            .foregroundColor(OltreColors.textMuted.opacity(0.6))
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 16)

                    Rectangle()
                        .fill(OltreColors.textMuted.opacity(0.15))
                        .frame(height: 1)
                        .padding(.horizontal, 20)

                    if articles.isEmpty {
                        VStack(spacing: 12) {
                            Image(systemName: "doc.text")
                                .font(.system(size: 32))
                                .foregroundColor(OltreColors.textMuted.opacity(0.3))

                            Text("No articles in this collection yet")
                                .font(OltreFonts.regular(14))
                                .foregroundColor(OltreColors.textMuted)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 60)
                    } else {
                        LazyVStack(spacing: 16) {
                            ForEach(articles) { article in
                                ArticleCardView(article: article) {
                                    selectedArticle = article
                                    showGlobeTransition = true
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                }
                .padding(.bottom, 100)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .fullScreenCover(isPresented: $showGlobeTransition) {
            if let article = selectedArticle {
                GlobeTransitionView(article: article)
            }
        }
    }

    private var articles: [Article] {
        savedViewModel.articles(in: collection, from: articleViewModel.articles)
    }
}
