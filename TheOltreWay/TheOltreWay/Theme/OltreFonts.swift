import SwiftUI

/// Typography system for The Oltre Way
/// Primary font: Sora (bundled or fallback to system)
/// When Sora font files are added to the bundle, update the font names below.
struct OltreFonts {
    // MARK: - Font Names
    // Replace these with "Sora-Light", "Sora-Regular", etc. once the font files are bundled
    private static let lightFontName: String? = nil    // "Sora-Light"
    private static let regularFontName: String? = nil   // "Sora-Regular"
    private static let mediumFontName: String? = nil    // "Sora-Medium"
    private static let boldFontName: String? = nil      // "Sora-Bold"

    // MARK: - Body Text (Light 300)
    static func body(_ size: CGFloat = 17) -> Font {
        if let name = lightFontName {
            return .custom(name, size: size)
        }
        return .system(size: size, weight: .light, design: .default)
    }

    // MARK: - UI Elements (Regular 400)
    static func regular(_ size: CGFloat = 15) -> Font {
        if let name = regularFontName {
            return .custom(name, size: size)
        }
        return .system(size: size, weight: .regular, design: .default)
    }

    // MARK: - Subheads, Card Titles, Navigation (Medium 500)
    static func medium(_ size: CGFloat = 16) -> Font {
        if let name = mediumFontName {
            return .custom(name, size: size)
        }
        return .system(size: size, weight: .medium, design: .default)
    }

    // MARK: - Article Titles, Headlines (Bold 700)
    static func bold(_ size: CGFloat = 24) -> Font {
        if let name = boldFontName {
            return .custom(name, size: size)
        }
        return .system(size: size, weight: .bold, design: .default)
    }

    // MARK: - Category Labels (Small Caps Style)
    static func category(_ size: CGFloat = 11) -> Font {
        if let name = mediumFontName {
            return .custom(name, size: size)
        }
        return .system(size: size, weight: .medium, design: .default)
    }

    // MARK: - Brand Wordmark
    static func wordmark(_ size: CGFloat = 28) -> Font {
        if let name = lightFontName {
            return .custom(name, size: size)
        }
        return .system(size: size, weight: .light, design: .default)
    }
}
