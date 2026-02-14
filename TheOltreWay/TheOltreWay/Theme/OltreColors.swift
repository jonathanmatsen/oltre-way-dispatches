import SwiftUI

/// Brand color palette for The Oltre Way
struct OltreColors {
    // MARK: - Primary Palette
    static let deepBurgundy = Color(hex: "722F37")
    static let forestGreen = Color(hex: "2D4A3E")
    static let navy = Color(hex: "1B2A4A")
    static let warmTerracotta = Color(hex: "C46E4E")
    static let cream = Color(hex: "F5F0E8")
    static let warmWhite = Color(hex: "FDFBF7")
    static let charcoal = Color(hex: "2A2A2A")
    static let textDark = Color(hex: "2A2118")
    static let textMuted = Color(hex: "6B5E52")
    static let goldAccent = Color(hex: "C9A96E")

    // MARK: - Gradient Palettes
    static let splashGradientColors: [Color] = [
        deepBurgundy,
        navy,
        forestGreen,
        deepBurgundy
    ]

    // MARK: - Time-of-Day Gradient Presets

    /// Morning: soft gold and cream
    static let morningGradient: [Color] = [
        Color(hex: "F2C675").opacity(0.08),
        Color(hex: "FAF7F2").opacity(0.05)
    ]

    /// Afternoon: warm terracotta wash
    static let afternoonGradient: [Color] = [
        Color(hex: "C46E4E").opacity(0.06),
        Color(hex: "F5F0E8").opacity(0.04)
    ]

    /// Sunset: gold to deep burgundy
    static let sunsetGradient: [Color] = [
        Color(hex: "C9A96E").opacity(0.10),
        Color(hex: "722F37").opacity(0.06)
    ]

    /// Night: deep navy to burgundy
    static let nightGradient: [Color] = [
        Color(hex: "1B2A4A").opacity(0.10),
        Color(hex: "722F37").opacity(0.08)
    ]

    /// Dawn: soft pink and cream
    static let dawnGradient: [Color] = [
        Color(hex: "D4587A").opacity(0.08),
        Color(hex: "F2C675").opacity(0.06)
    ]
}

// MARK: - Color Hex Extension
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
