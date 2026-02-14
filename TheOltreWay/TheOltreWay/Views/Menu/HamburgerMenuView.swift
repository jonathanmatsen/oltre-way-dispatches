import SwiftUI

/// Hamburger menu — content category filters and static pages
struct HamburgerMenuView: View {
    @Binding var isPresented: Bool
    @EnvironmentObject var articleViewModel: ArticleViewModel

    var body: some View {
        ZStack(alignment: .leading) {
            // Dimmed background
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        isPresented = false
                    }
                }

            // Menu panel
            VStack(alignment: .leading, spacing: 0) {
                // Header
                VStack(alignment: .leading, spacing: 8) {
                    Text("THE OLTRE WAY")
                        .font(OltreFonts.wordmark(16))
                        .tracking(4)
                        .foregroundColor(OltreColors.cream)

                    Rectangle()
                        .fill(OltreColors.goldAccent.opacity(0.4))
                        .frame(width: 30, height: 1)
                }
                .padding(.top, 60)
                .padding(.bottom, 40)
                .padding(.horizontal, 32)

                // Category filters
                VStack(alignment: .leading, spacing: 0) {
                    menuSectionLabel("CONTENT")

                    ForEach(ContentCategory.allCases) { category in
                        menuButton(category.rawValue) {
                            articleViewModel.selectedCategory = category
                            dismiss()
                        }
                    }

                    menuButton("All") {
                        articleViewModel.selectedCategory = nil
                        dismiss()
                    }
                }

                Divider()
                    .background(OltreColors.cream.opacity(0.15))
                    .padding(.horizontal, 32)
                    .padding(.vertical, 20)

                // Static pages
                VStack(alignment: .leading, spacing: 0) {
                    menuSectionLabel("THE BRAND")

                    menuButton("Our Philosophy") {
                        dismiss()
                    }

                    menuButton("Contact") {
                        dismiss()
                    }
                }

                Spacer()

                // Footer
                Text("Travel Beyond the Ordinary")
                    .font(OltreFonts.body(12))
                    .italic()
                    .foregroundColor(OltreColors.cream.opacity(0.3))
                    .padding(.horizontal, 32)
                    .padding(.bottom, 40)
            }
            .frame(width: 300)
            .background(OltreColors.charcoal)
            .ignoresSafeArea()
        }
    }

    // MARK: - Components

    private func menuSectionLabel(_ text: String) -> some View {
        Text(text)
            .font(OltreFonts.category(10))
            .tracking(3)
            .foregroundColor(OltreColors.goldAccent.opacity(0.6))
            .padding(.horizontal, 32)
            .padding(.bottom, 16)
    }

    private func menuButton(_ title: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .font(OltreFonts.medium(18))
                .foregroundColor(OltreColors.cream.opacity(0.85))
                .padding(.horizontal, 32)
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    private func dismiss() {
        withAnimation(.easeInOut(duration: 0.3)) {
            isPresented = false
        }
    }
}
