import SwiftUI
import MapKit

/// The core reading experience — full article view with time-of-day gradient,
/// body text, pull quotes, practical info boxes, and embedded map.
struct ArticleView: View {
    let article: Article
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var savedViewModel: SavedViewModel
    @State private var scrollOffset: CGFloat = 0
    @State private var contentHeight: CGFloat = 1
    @State private var showCollectionPicker = false

    var body: some View {
        ZStack(alignment: .top) {
            // Time-of-day gradient background
            timeGradientBackground

            ScrollView {
                VStack(spacing: 0) {
                    // Geometry reader to track scroll
                    GeometryReader { geo in
                        Color.clear
                            .preference(
                                key: ScrollOffsetKey.self,
                                value: -geo.frame(in: .named("articleScroll")).minY
                            )
                    }
                    .frame(height: 0)

                    // Hero section
                    articleHero

                    // Article meta
                    articleMeta
                        .padding(.horizontal, horizontalPadding)

                    // Body content
                    articleBody
                        .padding(.horizontal, horizontalPadding)

                    // Practical info boxes
                    practicalInfoSection
                        .padding(.horizontal, horizontalPadding)

                    // Embedded map
                    articleMap
                        .padding(.horizontal, horizontalPadding)
                        .padding(.top, 32)

                    // Footer
                    articleFooter
                        .padding(.horizontal, horizontalPadding)

                    Spacer(minLength: 80)
                }
                .background(
                    GeometryReader { geo in
                        Color.clear.preference(
                            key: ContentHeightKey.self,
                            value: geo.size.height
                        )
                    }
                )
            }
            .coordinateSpace(name: "articleScroll")
            .onPreferenceChange(ScrollOffsetKey.self) { value in
                scrollOffset = max(0, value)
            }
            .onPreferenceChange(ContentHeightKey.self) { value in
                contentHeight = max(1, value)
            }

            // Navigation overlay
            navigationBar
        }
        .ignoresSafeArea(edges: .top)
        .sheet(isPresented: $showCollectionPicker) {
            CollectionPickerSheet(article: article)
        }
    }

    // MARK: - Layout Constants

    private var horizontalPadding: CGFloat { 24 }

    // MARK: - Scroll Progress (0.0 to 1.0)

    private var scrollProgress: Double {
        guard contentHeight > 0 else { return 0 }
        return min(1.0, max(0.0, Double(scrollOffset / contentHeight)))
    }

    // MARK: - Time-of-Day Gradient Background

    private var timeGradientBackground: some View {
        let colors = interpolatedGradientColors()
        return LinearGradient(
            colors: [OltreColors.warmWhite] + colors + [OltreColors.warmWhite],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }

    private func interpolatedGradientColors() -> [Color] {
        let stops = article.timeGradientStops.sorted { $0.scrollPercentage < $1.scrollPercentage }
        guard stops.count >= 2 else {
            return [OltreColors.warmWhite.opacity(0.05)]
        }

        // Find the two stops we're between
        var lowerStop = stops[0]
        var upperStop = stops[1]

        for i in 0..<stops.count - 1 {
            if scrollProgress >= stops[i].scrollPercentage && scrollProgress <= stops[i + 1].scrollPercentage {
                lowerStop = stops[i]
                upperStop = stops[i + 1]
                break
            }
        }

        if scrollProgress >= stops.last!.scrollPercentage {
            return stops.last!.colors
        }

        // Interpolation factor
        let range = upperStop.scrollPercentage - lowerStop.scrollPercentage
        let factor = range > 0 ? (scrollProgress - lowerStop.scrollPercentage) / range : 0

        // Blend colors
        let lowerColors = lowerStop.colors
        let upperColors = upperStop.colors
        let count = max(lowerColors.count, upperColors.count)

        return (0..<count).map { i in
            let lc = i < lowerColors.count ? lowerColors[i] : .clear
            let uc = i < upperColors.count ? upperColors[i] : .clear
            return blendColor(lc, uc, factor: factor)
        }
    }

    private func blendColor(_ c1: Color, _ c2: Color, factor: Double) -> Color {
        // Simple opacity-based blend since we can't decompose SwiftUI Colors easily
        return c1.opacity(1 - factor).opacity(0.5)
    }

    // MARK: - Hero Section

    private var articleHero: some View {
        ZStack(alignment: .bottomLeading) {
            Rectangle()
                .fill(
                    LinearGradient(
                        colors: heroColors,
                        startPoint: .topTrailing,
                        endPoint: .bottomLeading
                    )
                )
                .frame(height: 400)
                .overlay(
                    Image(article.heroImageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipped()
                )
                .clipped()

            // Text overlay gradient
            LinearGradient(
                colors: [.clear, .clear, .black.opacity(0.6), .black.opacity(0.85)],
                startPoint: .top,
                endPoint: .bottom
            )

            VStack(alignment: .leading, spacing: 10) {
                Text(article.category.rawValue.uppercased())
                    .font(OltreFonts.category(10))
                    .tracking(2.5)
                    .foregroundColor(OltreColors.goldAccent)

                Text(article.title)
                    .font(OltreFonts.bold(28))
                    .foregroundColor(.white)
                    .lineSpacing(4)

                Text(article.subtitle)
                    .font(OltreFonts.body(15))
                    .foregroundColor(.white.opacity(0.8))
                    .italic()
                    .lineSpacing(4)
            }
            .padding(24)
            .padding(.bottom, 8)
        }
    }

    private var heroColors: [Color] {
        switch article.id {
        case SampleData.jacksonHoleID:
            return [Color(hex: "8a9aac"), Color(hex: "4a5a6c"), Color(hex: "2a3a4c")]
        case SampleData.banffID:
            return [Color(hex: "c8d8e8"), Color(hex: "7a9bb8"), Color(hex: "3a5a6a")]
        case SampleData.miamiID:
            return [Color(hex: "1a1028"), Color(hex: "0d1a2d"), Color(hex: "0A0A0F")]
        default:
            return [OltreColors.navy, OltreColors.charcoal]
        }
    }

    // MARK: - Article Meta

    private var articleMeta: some View {
        HStack {
            Text("\(article.author) · The Oltre Way")
                .font(OltreFonts.category(11))
                .tracking(1.5)
                .foregroundColor(OltreColors.textMuted)

            Spacer()

            Text(formattedDate)
                .font(OltreFonts.category(11))
                .tracking(1.5)
                .foregroundColor(OltreColors.textMuted)
        }
        .padding(.vertical, 24)
        .overlay(alignment: .bottom) {
            Rectangle()
                .fill(OltreColors.textMuted.opacity(0.2))
                .frame(height: 1)
        }
        .padding(.bottom, 32)
    }

    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: article.date)
    }

    // MARK: - Article Body

    private var articleBody: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(Array(article.bodySegments.enumerated()), id: \.offset) { index, segment in
                switch segment {
                case .text(let content):
                    Text(content)
                        .font(OltreFonts.body(17))
                        .foregroundColor(OltreColors.textDark)
                        .lineSpacing(10)
                        .padding(.bottom, 24)

                case .pullQuote(let quote):
                    PullQuoteView(text: quote)
                        .padding(.vertical, 16)

                case .sectionBreak:
                    HStack {
                        Spacer()
                        Text("· · ·")
                            .font(OltreFonts.regular(14))
                            .tracking(8)
                            .foregroundColor(OltreColors.textMuted.opacity(0.4))
                        Spacer()
                    }
                    .padding(.vertical, 20)
                }
            }
        }
    }

    // MARK: - Practical Info Section

    private var practicalInfoSection: some View {
        VStack(spacing: 20) {
            ForEach(article.practicalInfoBoxes) { box in
                PracticalInfoBoxView(info: box)
            }
        }
        .padding(.top, 12)
    }

    // MARK: - Map Section

    private var articleMap: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("LOCATIONS")
                .font(OltreFonts.category(10))
                .tracking(2.5)
                .foregroundColor(OltreColors.textMuted)

            ArticleMapView(locations: article.locations)
                .frame(height: 280)
                .cornerRadius(8)
        }
    }

    // MARK: - Footer

    private var articleFooter: some View {
        VStack(spacing: 12) {
            Rectangle()
                .fill(OltreColors.textMuted.opacity(0.2))
                .frame(height: 1)
                .padding(.top, 40)

            Text("THE OLTRE WAY")
                .font(OltreFonts.category(10))
                .tracking(4)
                .foregroundColor(OltreColors.deepBurgundy)
                .padding(.top, 16)

            Text("Where sophisticated taste meets strategic investment,\nand travel becomes transformation.")
                .font(OltreFonts.body(13))
                .italic()
                .foregroundColor(OltreColors.textMuted)
                .multilineTextAlignment(.center)
                .lineSpacing(4)
        }
        .padding(.top, 20)
    }

    // MARK: - Navigation Bar

    private var navigationBar: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Circle().fill(Color.black.opacity(0.3)))
            }

            Spacer()

            HStack(spacing: 16) {
                // Add to collection
                Button {
                    showCollectionPicker = true
                } label: {
                    Image(systemName: "folder.badge.plus")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(.white)
                        .padding(10)
                        .background(Circle().fill(Color.black.opacity(0.3)))
                }

                // Bookmark
                Button {
                    savedViewModel.toggleBookmark(article)
                    let impact = UIImpactFeedbackGenerator(style: .light)
                    impact.impactOccurred()
                } label: {
                    Image(systemName: savedViewModel.isBookmarked(article) ? "bookmark.fill" : "bookmark")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(savedViewModel.isBookmarked(article) ? OltreColors.warmTerracotta : .white)
                        .padding(10)
                        .background(Circle().fill(Color.black.opacity(0.3)))
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 50)
    }
}

// MARK: - Pull Quote View

struct PullQuoteView: View {
    let text: String

    var body: some View {
        HStack(spacing: 0) {
            Rectangle()
                .fill(OltreColors.deepBurgundy.opacity(0.6))
                .frame(width: 2)

            Text(text)
                .font(OltreFonts.body(19))
                .italic()
                .foregroundColor(OltreColors.deepBurgundy)
                .lineSpacing(8)
                .padding(.leading, 20)
                .padding(.vertical, 8)
        }
    }
}

// MARK: - Collection Picker Sheet

struct CollectionPickerSheet: View {
    let article: Article
    @EnvironmentObject var savedViewModel: SavedViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var newCollectionName = ""
    @State private var showNewCollection = false

    var body: some View {
        NavigationStack {
            List {
                if savedViewModel.collections.isEmpty && !showNewCollection {
                    VStack(spacing: 12) {
                        Text("No Collections Yet")
                            .font(OltreFonts.medium(16))
                            .foregroundColor(OltreColors.textDark)
                        Text("Create one to organize your saved articles.")
                            .font(OltreFonts.body(14))
                            .foregroundColor(OltreColors.textMuted)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 40)
                    .listRowBackground(Color.clear)
                }

                ForEach(savedViewModel.collections) { collection in
                    Button {
                        savedViewModel.addArticle(article, to: collection)
                        let impact = UIImpactFeedbackGenerator(style: .light)
                        impact.impactOccurred()
                        dismiss()
                    } label: {
                        HStack {
                            Text(collection.name)
                                .font(OltreFonts.medium(15))
                                .foregroundColor(OltreColors.textDark)
                            Spacer()
                            if collection.articleIDs.contains(article.id) {
                                Image(systemName: "checkmark")
                                    .foregroundColor(OltreColors.warmTerracotta)
                            }
                        }
                    }
                }

                if showNewCollection {
                    HStack {
                        TextField("Collection name", text: $newCollectionName)
                            .font(OltreFonts.regular(15))

                        Button("Create") {
                            guard !newCollectionName.isEmpty else { return }
                            savedViewModel.createCollection(name: newCollectionName)
                            if let collection = savedViewModel.collections.last {
                                savedViewModel.addArticle(article, to: collection)
                            }
                            let impact = UIImpactFeedbackGenerator(style: .medium)
                            impact.impactOccurred()
                            dismiss()
                        }
                        .font(OltreFonts.medium(14))
                        .foregroundColor(OltreColors.warmTerracotta)
                    }
                }
            }
            .navigationTitle("Add to Collection")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                        .foregroundColor(OltreColors.textMuted)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showNewCollection = true
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(OltreColors.warmTerracotta)
                    }
                }
            }
        }
        .presentationDetents([.medium])
    }
}

// MARK: - Preference Keys

struct ScrollOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct ContentHeightKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
