import Foundation
import SwiftUI

// MARK: - Saved View Model
final class SavedViewModel: ObservableObject {
    @Published var savedArticleIDs: Set<UUID> = []
    @Published var collections: [ArticleCollection] = []

    private let savedKey = "oltreWaySavedArticles"
    private let collectionsKey = "oltreWayCollections"

    init() {
        loadSaved()
        loadCollections()
    }

    // MARK: - Bookmark Actions

    func isBookmarked(_ article: Article) -> Bool {
        savedArticleIDs.contains(article.id)
    }

    func toggleBookmark(_ article: Article) {
        if savedArticleIDs.contains(article.id) {
            savedArticleIDs.remove(article.id)
        } else {
            savedArticleIDs.insert(article.id)
        }
        saveToDisk()
    }

    func savedArticles(from allArticles: [Article]) -> [Article] {
        allArticles.filter { savedArticleIDs.contains($0.id) }
    }

    // MARK: - Collection Actions

    func createCollection(name: String) {
        let collection = ArticleCollection(name: name)
        collections.append(collection)
        saveCollections()
    }

    func deleteCollection(_ collection: ArticleCollection) {
        collections.removeAll { $0.id == collection.id }
        saveCollections()
    }

    func addArticle(_ article: Article, to collection: ArticleCollection) {
        guard let index = collections.firstIndex(where: { $0.id == collection.id }) else { return }
        if !collections[index].articleIDs.contains(article.id) {
            collections[index].articleIDs.append(article.id)
            saveCollections()
        }
    }

    func removeArticle(_ article: Article, from collection: ArticleCollection) {
        guard let index = collections.firstIndex(where: { $0.id == collection.id }) else { return }
        collections[index].articleIDs.removeAll { $0 == article.id }
        saveCollections()
    }

    func articles(in collection: ArticleCollection, from allArticles: [Article]) -> [Article] {
        allArticles.filter { collection.articleIDs.contains($0.id) }
    }

    // MARK: - Persistence

    private func saveToDisk() {
        let idStrings = savedArticleIDs.map { $0.uuidString }
        UserDefaults.standard.set(idStrings, forKey: savedKey)
    }

    private func loadSaved() {
        if let idStrings = UserDefaults.standard.stringArray(forKey: savedKey) {
            savedArticleIDs = Set(idStrings.compactMap { UUID(uuidString: $0) })
        }
    }

    private func saveCollections() {
        if let data = try? JSONEncoder().encode(collections) {
            UserDefaults.standard.set(data, forKey: collectionsKey)
        }
    }

    private func loadCollections() {
        if let data = UserDefaults.standard.data(forKey: collectionsKey),
           let decoded = try? JSONDecoder().decode([ArticleCollection].self, from: data) {
            collections = decoded
        }
    }
}
