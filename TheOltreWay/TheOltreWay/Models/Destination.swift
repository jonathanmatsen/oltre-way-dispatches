import Foundation

// MARK: - Destination
struct Destination: Identifiable, Codable, Hashable {
    let id: UUID
    let name: String
    let region: String
    let description: String
    let coverImageName: String
    let latitude: Double
    let longitude: Double
    let articleIDs: [UUID]

    init(
        id: UUID = UUID(),
        name: String,
        region: String,
        description: String,
        coverImageName: String,
        latitude: Double,
        longitude: Double,
        articleIDs: [UUID] = []
    ) {
        self.id = id
        self.name = name
        self.region = region
        self.description = description
        self.coverImageName = coverImageName
        self.latitude = latitude
        self.longitude = longitude
        self.articleIDs = articleIDs
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Destination, rhs: Destination) -> Bool {
        lhs.id == rhs.id
    }
}
