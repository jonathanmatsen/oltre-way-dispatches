import Foundation
import Combine

// MARK: - Content Service Protocol
/// Protocol for content fetching — swap LocalContentService for an API-backed one in Phase 2
protocol ContentServiceProtocol {
    func fetchArticles() -> [Article]
    func fetchArticle(by id: UUID) -> Article?
    func fetchDestinations() -> [Destination]
    func fetchArticles(for category: ContentCategory) -> [Article]
    func fetchArticles(for destination: Destination) -> [Article]
    func featuredArticle() -> Article?
}

// MARK: - Local Content Service
/// MVP implementation — returns hardcoded local content
final class LocalContentService: ContentServiceProtocol {
    private let articles: [Article]
    private let destinations: [Destination]

    init() {
        self.articles = SampleData.articles
        self.destinations = SampleData.destinations
    }

    func fetchArticles() -> [Article] {
        articles.sorted { $0.date > $1.date }
    }

    func fetchArticle(by id: UUID) -> Article? {
        articles.first { $0.id == id }
    }

    func fetchDestinations() -> [Destination] {
        destinations
    }

    func fetchArticles(for category: ContentCategory) -> [Article] {
        articles.filter { $0.category == category }.sorted { $0.date > $1.date }
    }

    func fetchArticles(for destination: Destination) -> [Article] {
        articles.filter { destination.articleIDs.contains($0.id) }
    }

    func featuredArticle() -> Article? {
        articles.sorted { $0.date > $1.date }.first
    }
}
