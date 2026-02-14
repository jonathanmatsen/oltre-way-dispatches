import SwiftUI
import MapKit

/// Signature globe-spin transition animation when opening an article.
/// A spinning globe pinpoints the article's location then dissolves into the article view.
struct GlobeTransitionView: View {
    let article: Article
    @Environment(\.dismiss) private var dismiss
    @State private var showArticle = false
    @State private var globeRotation: Double = 0
    @State private var globeScale: CGFloat = 0.8
    @State private var globeOpacity: Double = 1
    @State private var pinOpacity: Double = 0
    @State private var zoomScale: CGFloat = 1

    private var primaryLocation: ArticleLocation? {
        article.locations.first
    }

    var body: some View {
        ZStack {
            OltreColors.charcoal.ignoresSafeArea()

            if showArticle {
                ArticleView(article: article)
                    .transition(.opacity)
            } else {
                // Globe animation
                VStack(spacing: 0) {
                    Spacer()

                    ZStack {
                        // Stylized globe
                        globeView
                            .scaleEffect(globeScale * zoomScale)
                            .opacity(globeOpacity)

                        // Pin indicator
                        if let location = primaryLocation {
                            VStack(spacing: 4) {
                                Image(systemName: "mappin.circle.fill")
                                    .font(.system(size: 24))
                                    .foregroundColor(OltreColors.warmTerracotta)

                                Text(location.name)
                                    .font(OltreFonts.category(10))
                                    .tracking(1.5)
                                    .foregroundColor(OltreColors.cream.opacity(0.8))
                            }
                            .opacity(pinOpacity)
                            .scaleEffect(pinOpacity)
                        }
                    }

                    Spacer()

                    // Article title preview
                    VStack(spacing: 8) {
                        Text(article.category.rawValue.uppercased())
                            .font(OltreFonts.category(10))
                            .tracking(2)
                            .foregroundColor(OltreColors.goldAccent.opacity(globeOpacity))

                        Text(article.title)
                            .font(OltreFonts.bold(22))
                            .foregroundColor(OltreColors.cream.opacity(globeOpacity))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)
                    }
                    .padding(.bottom, 80)
                }
            }
        }
        .onAppear {
            runTransition()
        }
    }

    // MARK: - Globe View

    private var globeView: some View {
        ZStack {
            // Globe circle
            Circle()
                .fill(
                    RadialGradient(
                        colors: [
                            OltreColors.navy.opacity(0.8),
                            OltreColors.forestGreen.opacity(0.6),
                            OltreColors.deepBurgundy.opacity(0.4)
                        ],
                        center: .center,
                        startRadius: 20,
                        endRadius: 120
                    )
                )
                .frame(width: 200, height: 200)
                .overlay(
                    Circle()
                        .stroke(OltreColors.goldAccent.opacity(0.3), lineWidth: 1)
                )

            // Longitude lines
            ForEach(0..<6) { i in
                Ellipse()
                    .stroke(OltreColors.cream.opacity(0.15), lineWidth: 0.5)
                    .frame(width: CGFloat(40 + i * 30), height: 180)
                    .rotation3DEffect(
                        .degrees(globeRotation + Double(i * 30)),
                        axis: (x: 0, y: 1, z: 0)
                    )
            }

            // Latitude lines
            ForEach(0..<5) { i in
                Circle()
                    .stroke(OltreColors.cream.opacity(0.1), lineWidth: 0.5)
                    .frame(width: CGFloat(60 + i * 35), height: CGFloat(60 + i * 35))
                    .offset(y: CGFloat(i - 2) * 15)
                    .opacity(0.8)
            }

            // Glow effect
            Circle()
                .fill(
                    RadialGradient(
                        colors: [OltreColors.warmTerracotta.opacity(0.2), .clear],
                        center: .center,
                        startRadius: 0,
                        endRadius: 100
                    )
                )
                .frame(width: 200, height: 200)
                .scaleEffect(pinOpacity * 0.5 + 0.5)
        }
    }

    // MARK: - Animation Sequence

    private func runTransition() {
        // Phase 1: Globe appears and spins
        withAnimation(.easeOut(duration: 0.4)) {
            globeScale = 1.0
        }

        withAnimation(.linear(duration: 1.8)) {
            globeRotation = 360
        }

        // Phase 2: Zoom in and show pin
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            withAnimation(.easeInOut(duration: 0.8)) {
                zoomScale = 2.5
                pinOpacity = 1.0
            }
        }

        // Phase 3: Dissolve into article
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation(.easeInOut(duration: 0.5)) {
                globeOpacity = 0
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.easeInOut(duration: 0.4)) {
                    showArticle = true
                }
            }
        }
    }
}
