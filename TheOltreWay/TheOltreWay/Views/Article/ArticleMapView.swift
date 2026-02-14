import SwiftUI
import MapKit

/// Embedded map showing all locations mentioned in an article
/// with brand terracotta-colored pins.
struct ArticleMapView: View {
    let locations: [ArticleLocation]
    @State private var selectedLocation: ArticleLocation?
    @State private var cameraPosition: MapCameraPosition = .automatic

    var body: some View {
        Map(position: $cameraPosition, selection: $selectedLocation) {
            ForEach(locations) { location in
                Annotation(
                    location.name,
                    coordinate: CLLocationCoordinate2D(
                        latitude: location.latitude,
                        longitude: location.longitude
                    ),
                    anchor: .bottom
                ) {
                    VStack(spacing: 2) {
                        Image(systemName: "mappin.circle.fill")
                            .font(.system(size: 28))
                            .foregroundColor(OltreColors.warmTerracotta)
                            .background(
                                Circle()
                                    .fill(.white)
                                    .frame(width: 18, height: 18)
                            )

                        if selectedLocation?.id == location.id {
                            VStack(spacing: 4) {
                                Text(location.name)
                                    .font(OltreFonts.medium(12))
                                    .foregroundColor(OltreColors.textDark)

                                if let note = location.note {
                                    Text(note)
                                        .font(OltreFonts.body(10))
                                        .foregroundColor(OltreColors.textMuted)
                                        .multilineTextAlignment(.center)
                                }
                            }
                            .padding(8)
                            .background(
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(OltreColors.warmWhite)
                                    .shadow(color: .black.opacity(0.1), radius: 4, y: 2)
                            )
                            .frame(maxWidth: 180)
                            .transition(.scale.combined(with: .opacity))
                        }
                    }
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            if selectedLocation?.id == location.id {
                                selectedLocation = nil
                            } else {
                                selectedLocation = location
                            }
                        }
                    }
                }
                .tag(location)
            }
        }
        .mapStyle(.standard(elevation: .realistic))
        .onAppear {
            fitMapToLocations()
        }
    }

    private func fitMapToLocations() {
        guard !locations.isEmpty else { return }

        let coordinates = locations.map {
            CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude)
        }

        let minLat = coordinates.map(\.latitude).min()!
        let maxLat = coordinates.map(\.latitude).max()!
        let minLon = coordinates.map(\.longitude).min()!
        let maxLon = coordinates.map(\.longitude).max()!

        let center = CLLocationCoordinate2D(
            latitude: (minLat + maxLat) / 2,
            longitude: (minLon + maxLon) / 2
        )

        let span = MKCoordinateSpan(
            latitudeDelta: max(0.02, (maxLat - minLat) * 1.5),
            longitudeDelta: max(0.02, (maxLon - minLon) * 1.5)
        )

        cameraPosition = .region(MKCoordinateRegion(center: center, span: span))
    }
}
