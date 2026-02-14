import SwiftUI

/// Saved tab — collections and bookmarked articles
struct SavedView: View {
    @EnvironmentObject var savedViewModel: SavedViewModel
    @EnvironmentObject var articleViewModel: ArticleViewModel
    @State private var showNewCollection = false
    @State private var newCollectionName = ""
    @State private var selectedArticle: Article?
    @State private var showGlobeTransition = false

    var body: some View {
        NavigationStack {
            ZStack {
                OltreColors.cream.ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 32) {
                        // Collections section
                        collectionsSection

                        // All saved articles
                        allSavedSection
                    }
                    .padding(.bottom, 100)
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("SAVED")
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
            .alert("New Collection", isPresented: $showNewCollection) {
                TextField("Collection name", text: $newCollectionName)
                Button("Create") {
                    guard !newCollectionName.isEmpty else { return }
                    savedViewModel.createCollection(name: newCollectionName)
                    let impact = UIImpactFeedbackGenerator(style: .medium)
                    impact.impactOccurred()
                    newCollectionName = ""
                }
                Button("Cancel", role: .cancel) {
                    newCollectionName = ""
                }
            }
        }
    }

    // MARK: - Collections Section

    private var collectionsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("COLLECTIONS")
                    .font(OltreFonts.category(10))
                    .tracking(2.5)
                    .foregroundColor(OltreColors.textMuted)

                Spacer()

                Button {
                    showNewCollection = true
                } label: {
                    Image(systemName: "plus.circle")
                        .font(.system(size: 20))
                        .foregroundColor(OltreColors.warmTerracotta)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)

            if savedViewModel.collections.isEmpty {
                VStack(spacing: 8) {
                    Image(systemName: "folder")
                        .font(.system(size: 28))
                        .foregroundColor(OltreColors.textMuted.opacity(0.4))

                    Text("No collections yet")
                        .font(OltreFonts.regular(14))
                        .foregroundColor(OltreColors.textMuted)

                    Text("Tap + to create your first collection")
                        .font(OltreFonts.body(12))
                        .foregroundColor(OltreColors.textMuted.opacity(0.6))
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 32)
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(savedViewModel.collections) { collection in
                            NavigationLink {
                                CollectionDetailView(collection: collection)
                            } label: {
                                collectionCard(collection)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                }
            }
        }
    }

    private func collectionCard(_ collection: ArticleCollection) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            // Cover
            Rectangle()
                .fill(
                    LinearGradient(
                        colors: [OltreColors.navy.opacity(0.7), OltreColors.deepBurgundy.opacity(0.5)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 160, height: 100)
                .overlay(
                    VStack {
                        Image(systemName: "bookmark.fill")
                            .font(.system(size: 24))
                            .foregroundColor(OltreColors.goldAccent.opacity(0.6))
                        Text("\(collection.articleIDs.count)")
                            .font(OltreFonts.regular(12))
                            .foregroundColor(.white.opacity(0.7))
                    }
                )
                .cornerRadius(6)

            Text(collection.name)
                .font(OltreFonts.medium(14))
                .foregroundColor(OltreColors.textDark)
                .lineLimit(1)

            Text("\(collection.articleIDs.count) articles")
                .font(OltreFonts.regular(11))
                .foregroundColor(OltreColors.textMuted)
        }
        .frame(width: 160)
    }

    // MARK: - All Saved Section

    private var allSavedSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("ALL SAVED")
                .font(OltreFonts.category(10))
                .tracking(2.5)
                .foregroundColor(OltreColors.textMuted)
                .padding(.horizontal, 20)

            let saved = savedViewModel.savedArticles(from: articleViewModel.articles)

            if saved.isEmpty {
                VStack(spacing: 8) {
                    Image(systemName: "bookmark")
                        .font(.system(size: 28))
                        .foregroundColor(OltreColors.textMuted.opacity(0.4))

                    Text("No saved articles")
                        .font(OltreFonts.regular(14))
                        .foregroundColor(OltreColors.textMuted)

                    Text("Bookmark articles to find them here")
                        .font(OltreFonts.body(12))
                        .foregroundColor(OltreColors.textMuted.opacity(0.6))
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 32)
            } else {
                LazyVStack(spacing: 16) {
                    ForEach(saved) { article in
                        ArticleCardView(article: article) {
                            selectedArticle = article
                            showGlobeTransition = true
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
        }
    }
}
