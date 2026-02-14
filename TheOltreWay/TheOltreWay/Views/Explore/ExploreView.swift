import SwiftUI
import MapKit

/// Explore tab — map-first view with destination pins
struct ExploreView: View {
    @EnvironmentObject var articleViewModel: ArticleViewModel
    @State private var cameraPosition: MapCameraPosition = .camera(
        MapCamera(centerCoordinate: CLLocationCoordinate2D(latitude: 35, longitude: -95), distance: 15000000)
    )
    @State private var selectedDestination: Destination?
    @State private var selectedArticle: Article?
    @State private var showGlobeTransition = false

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                // Full-screen map
                Map(position: $cameraPosition) {
                    ForEach(articleViewModel.destinations) { destination in
                        Annotation(
                            destination.name,
                            coordinate: CLLocationCoordinate2D(
                                latitude: destination.latitude,
                                longitude: destination.longitude
                            ),
                            anchor: .bottom
                        ) {
                            Button {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    selectedDestination = destination
                                }
                                // Animate camera to destination
                                withAnimation(.easeInOut(duration: 0.8)) {
                                    cameraPosition = .camera(
                                        MapCamera(
                                            centerCoordinate: CLLocationCoordinate2D(
                                                latitude: destination.latitude,
                                                longitude: destination.longitude
                                            ),
                                            distance: 500000
                                        )
                                    )
                                }
                            } label: {
                                VStack(spacing: 4) {
                                    Image(systemName: "mappin.circle.fill")
                                        .font(.system(size: 32))
                                        .foregroundColor(OltreColors.warmTerracotta)
                                        .background(
                                            Circle()
                                                .fill(.white)
                                                .frame(width: 20, height: 20)
                                        )
                                        .shadow(color: .black.opacity(0.2), radius: 4, y: 2)

                                    Text(destination.name)
                                        .font(OltreFonts.medium(11))
                                        .foregroundColor(OltreColors.textDark)
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 4)
                                        .background(
                                            Capsule()
                                                .fill(OltreColors.warmWhite)
                                                .shadow(color: .black.opacity(0.1), radius: 2)
                                        )
                                }
                            }
                        }
                    }
                }
                .mapStyle(.standard(elevation: .realistic))
                .ignoresSafeArea(edges: .top)

                // Destination detail card (bottom sheet)
                if let destination = selectedDestination {
                    destinationCard(destination)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("EXPLORE")
                        .font(OltreFonts.category(11))
                        .tracking(3)
                        .foregroundColor(OltreColors.deepBurgundy)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .fullScreenCover(isPresented: $showGlobeTransition) {
                if let article = selectedArticle {
                    GlobeTransitionView(article: article)
                }
            }
        }
    }

    // MARK: - Destination Card

    private func destinationCard(_ destination: Destination) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            // Handle bar
            HStack {
                Spacer()
                RoundedRectangle(cornerRadius: 3)
                    .fill(OltreColors.textMuted.opacity(0.3))
                    .frame(width: 40, height: 4)
                Spacer()
            }
            .padding(.top, 12)
            .padding(.bottom, 16)

            // Cover image placeholder
            Rectangle()
                .fill(
                    LinearGradient(
                        colors: [OltreColors.navy, OltreColors.forestGreen],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .frame(height: 140)
                .overlay(
                    Image(destination.coverImageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipped()
                )
                .clipped()
                .cornerRadius(8)
                .padding(.horizontal, 20)

            VStack(alignment: .leading, spacing: 8) {
                Text(destination.region.uppercased())
                    .font(OltreFonts.category(10))
                    .tracking(2)
                    .foregroundColor(OltreColors.warmTerracotta)

                Text(destination.name)
                    .font(OltreFonts.bold(22))
                    .foregroundColor(OltreColors.textDark)

                Text(destination.description)
                    .font(OltreFonts.body(14))
                    .foregroundColor(OltreColors.textMuted)
                    .lineSpacing(4)
                    .lineLimit(3)
            }
            .padding(20)

            // Related articles
            VStack(alignment: .leading, spacing: 8) {
                Text("DISPATCHES")
                    .font(OltreFonts.category(9))
                    .tracking(2)
                    .foregroundColor(OltreColors.textMuted)
                    .padding(.horizontal, 20)

                ForEach(articleViewModel.articles(for: destination)) { article in
                    Button {
                        selectedArticle = article
                        showGlobeTransition = true
                    } label: {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(article.title)
                                    .font(OltreFonts.medium(14))
                                    .foregroundColor(OltreColors.textDark)
                                    .lineLimit(1)

                                Text("\(article.estimatedReadTime) min read")
                                    .font(OltreFonts.regular(11))
                                    .foregroundColor(OltreColors.textMuted)
                            }

                            Spacer()

                            Image(systemName: "chevron.right")
                                .font(.system(size: 12))
                                .foregroundColor(OltreColors.textMuted)
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 8)
                    }
                }
            }
            .padding(.bottom, 20)

            // Close button
            Button {
                withAnimation(.easeInOut(duration: 0.3)) {
                    selectedDestination = nil
                }
            } label: {
                Text("Close")
                    .font(OltreFonts.regular(14))
                    .foregroundColor(OltreColors.textMuted)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
            }
            .padding(.bottom, 8)
        }
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(OltreColors.warmWhite)
                .shadow(color: .black.opacity(0.1), radius: 16, y: -4)
        )
        .padding(.horizontal, 8)
        .padding(.bottom, 80)
    }
}
