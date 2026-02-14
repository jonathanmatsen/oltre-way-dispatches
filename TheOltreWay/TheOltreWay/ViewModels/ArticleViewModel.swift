import Foundation
import SwiftUI

// MARK: - Article View Model
final class ArticleViewModel: ObservableObject {
    @Published var articles: [Article] = []
    @Published var featuredArticle: Article?
    @Published var destinations: [Destination] = []
    @Published var selectedCategory: ContentCategory?

    private let contentService: ContentServiceProtocol

    init(contentService: ContentServiceProtocol = LocalContentService()) {
        self.contentService = contentService
        loadContent()
    }

    func loadContent() {
        articles = contentService.fetchArticles()
        featuredArticle = contentService.featuredArticle()
        destinations = contentService.fetchDestinations()
    }

    func filteredArticles() -> [Article] {
        if let category = selectedCategory {
            return contentService.fetchArticles(for: category)
        }
        return articles
    }

    func articles(for destination: Destination) -> [Article] {
        articles.filter { destination.articleIDs.contains($0.id) }
    }

    func article(by id: UUID) -> Article? {
        contentService.fetchArticle(by: id)
    }
}
