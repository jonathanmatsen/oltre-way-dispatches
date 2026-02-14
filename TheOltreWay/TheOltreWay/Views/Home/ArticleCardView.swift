import SwiftUI

/// Compact article card for the feed below the hero
struct ArticleCardView: View {
    let article: Article
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 16) {
                // Thumbnail
                Rectangle()
                    .fill(
                        LinearGradient(
                            colors: thumbnailGradient(for: article),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 110, height: 110)
                    .overlay(
                        Image(article.heroImageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipped()
                    )
                    .clipped()
                    .cornerRadius(4)

                // Text content
                VStack(alignment: .leading, spacing: 6) {
                    // Category
                    Text(article.category.rawValue.uppercased())
                        .font(OltreFonts.category(9))
                        .tracking(1.5)
                        .foregroundColor(article.category.color)

                    // Title
                    Text(article.title)
                        .font(OltreFonts.medium(16))
                        .foregroundColor(OltreColors.textDark)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)

                    // Subtitle
                    Text(article.subtitle)
                        .font(OltreFonts.body(13))
                        .foregroundColor(OltreColors.textMuted)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)

                    // Meta
                    HStack(spacing: 8) {
                        Text(formattedDate(article.date))
                            .font(OltreFonts.regular(11))
                            .foregroundColor(OltreColors.textMuted.opacity(0.7))

                        Text("·")
                            .foregroundColor(OltreColors.textMuted.opacity(0.4))

                        Text("\(article.estimatedReadTime) min")
                            .font(OltreFonts.regular(11))
                            .foregroundColor(OltreColors.textMuted.opacity(0.7))
                    }
                }

                Spacer(minLength: 0)
            }
            .padding(12)
            .background(OltreColors.warmWhite)
            .cornerRadius(6)
            .shadow(color: .black.opacity(0.04), radius: 8, y: 2)
        }
        .buttonStyle(.plain)
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        return formatter.string(from: date)
    }

    private func thumbnailGradient(for article: Article) -> [Color] {
        switch article.id {
        case SampleData.jacksonHoleID:
            return [Color(hex: "8a9aac"), Color(hex: "3a4a5c")]
        case SampleData.banffID:
            return [Color(hex: "a8c0d4"), Color(hex: "3a5a6a")]
        case SampleData.miamiID:
            return [Color(hex: "1a1028"), Color(hex: "0d1a2d")]
        default:
            return [OltreColors.navy, OltreColors.charcoal]
        }
    }
}
