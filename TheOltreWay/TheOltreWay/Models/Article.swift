import SwiftUI

// MARK: - Content Category
enum ContentCategory: String, CaseIterable, Codable, Identifiable {
    case dispatches = "Dispatches"
    case living = "Living"
    case studio = "Studio"

    var id: String { rawValue }

    var color: Color {
        switch self {
        case .dispatches: return OltreColors.deepBurgundy
        case .living: return OltreColors.forestGreen
        case .studio: return OltreColors.navy
        }
    }
}

// MARK: - Article
struct Article: Identifiable, Codable, Hashable {
    let id: UUID
    let title: String
    let subtitle: String
    let category: ContentCategory
    let heroImageName: String
    let bodySegments: [ArticleSegment]
    let practicalInfoBoxes: [PracticalInfo]
    let locations: [ArticleLocation]
    let date: Date
    let estimatedReadTime: Int
    let timeGradientStops: [TimeGradientStop]
    let tags: [String]
    let author: String

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Article, rhs: Article) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - Article Segment
/// Represents a section of article content — text, pull quote, or section break
enum ArticleSegment: Codable, Hashable {
    case text(String)
    case pullQuote(String)
    case sectionBreak

    func hash(into hasher: inout Hasher) {
        switch self {
        case .text(let str): hasher.combine("text"); hasher.combine(str)
        case .pullQuote(let str): hasher.combine("quote"); hasher.combine(str)
        case .sectionBreak: hasher.combine("break")
        }
    }
}

// MARK: - Article Location
struct ArticleLocation: Identifiable, Codable, Hashable {
    let id: UUID
    let name: String
    let latitude: Double
    let longitude: Double
    let note: String?

    init(id: UUID = UUID(), name: String, latitude: Double, longitude: Double, note: String? = nil) {
        self.id = id
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.note = note
    }
}

// MARK: - Practical Info
struct PracticalInfo: Identifiable, Codable, Hashable {
    let id: UUID
    let title: String
    let items: [PracticalInfoItem]

    init(id: UUID = UUID(), title: String, items: [PracticalInfoItem]) {
        self.id = id
        self.title = title
        self.items = items
    }
}

struct PracticalInfoItem: Identifiable, Codable, Hashable {
    let id: UUID
    let label: String
    let detail: String

    init(id: UUID = UUID(), label: String, detail: String) {
        self.id = id
        self.label = label
        self.detail = detail
    }
}

// MARK: - Time Gradient Stop
struct TimeGradientStop: Codable, Hashable {
    let scrollPercentage: Double
    let colorHexes: [String]
    let opacity: Double

    init(scrollPercentage: Double, colorHexes: [String], opacity: Double = 0.08) {
        self.scrollPercentage = scrollPercentage
        self.colorHexes = colorHexes
        self.opacity = opacity
    }

    var colors: [Color] {
        colorHexes.map { Color(hex: $0).opacity(opacity) }
    }
}
