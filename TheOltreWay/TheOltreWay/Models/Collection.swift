import Foundation

// MARK: - User Collection
struct ArticleCollection: Identifiable, Codable, Hashable {
    let id: UUID
    var name: String
    var coverImageName: String?
    var articleIDs: [UUID]
    let createdDate: Date

    init(
        id: UUID = UUID(),
        name: String,
        coverImageName: String? = nil,
        articleIDs: [UUID] = [],
        createdDate: Date = Date()
    ) {
        self.id = id
        self.name = name
        self.coverImageName = coverImageName
        self.articleIDs = articleIDs
        self.createdDate = createdDate
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: ArticleCollection, rhs: ArticleCollection) -> Bool {
        lhs.id == rhs.id
    }
}
