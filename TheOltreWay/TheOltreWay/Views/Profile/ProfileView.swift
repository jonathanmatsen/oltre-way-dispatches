import SwiftUI

/// Profile tab — minimal for MVP
struct ProfileView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var showSignOutConfirm = false

    var body: some View {
        NavigationStack {
            ZStack {
                OltreColors.cream.ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 0) {
                        // User info header
                        VStack(spacing: 12) {
                            // Avatar circle
                            Circle()
                                .fill(
                                    LinearGradient(
                                        colors: [OltreColors.deepBurgundy.opacity(0.6), OltreColors.navy.opacity(0.6)],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(width: 72, height: 72)
                                .overlay(
                                    Text(initials)
                                        .font(OltreFonts.medium(24))
                                        .foregroundColor(OltreColors.cream)
                                )

                            Text(authViewModel.userName)
                                .font(OltreFonts.medium(20))
                                .foregroundColor(OltreColors.textDark)

                            if !authViewModel.userEmail.isEmpty {
                                Text(authViewModel.userEmail)
                                    .font(OltreFonts.regular(13))
                                    .foregroundColor(OltreColors.textMuted)
                            }
                        }
                        .padding(.vertical, 32)

                        // Settings sections
                        VStack(spacing: 0) {
                            settingsSection("ABOUT") {
                                settingsRow(icon: "globe", title: "theoltreway.com") {
                                    if let url = URL(string: "https://theoltreway.com") {
                                        UIApplication.shared.open(url)
                                    }
                                }

                                settingsRow(icon: "info.circle", title: "App Version") {
                                    // No-op — just shows version
                                }
                                .overlay(alignment: .trailing) {
                                    Text("1.0.0")
                                        .font(OltreFonts.regular(13))
                                        .foregroundColor(OltreColors.textMuted)
                                        .padding(.trailing, 20)
                                }
                            }

                            settingsSection("ACCOUNT") {
                                Button {
                                    showSignOutConfirm = true
                                } label: {
                                    HStack(spacing: 12) {
                                        Image(systemName: "rectangle.portrait.and.arrow.right")
                                            .font(.system(size: 16))
                                            .foregroundColor(OltreColors.deepBurgundy)
                                            .frame(width: 28)

                                        Text("Sign Out")
                                            .font(OltreFonts.regular(15))
                                            .foregroundColor(OltreColors.deepBurgundy)

                                        Spacer()
                                    }
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 14)
                                }
                            }
                        }

                        // Brand footer
                        VStack(spacing: 8) {
                            Text("THE OLTRE WAY")
                                .font(OltreFonts.category(10))
                                .tracking(3)
                                .foregroundColor(OltreColors.deepBurgundy.opacity(0.5))

                            Text("Travel Beyond the Ordinary")
                                .font(OltreFonts.body(12))
                                .italic()
                                .foregroundColor(OltreColors.textMuted.opacity(0.4))
                        }
                        .padding(.top, 60)
                        .padding(.bottom, 120)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("PROFILE")
                        .font(OltreFonts.category(11))
                        .tracking(3)
                        .foregroundColor(OltreColors.deepBurgundy)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .alert("Sign Out", isPresented: $showSignOutConfirm) {
                Button("Sign Out", role: .destructive) {
                    authViewModel.signOut()
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("Are you sure you want to sign out? Your saved articles and collections will be preserved on this device.")
            }
        }
    }

    // MARK: - Helpers

    private var initials: String {
        let parts = authViewModel.userName.split(separator: " ")
        if parts.count >= 2 {
            return String(parts[0].prefix(1) + parts[1].prefix(1)).uppercased()
        }
        return String(authViewModel.userName.prefix(1)).uppercased()
    }

    // MARK: - Settings Components

    private func settingsSection(_ title: String, @ViewBuilder content: () -> some View) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(OltreFonts.category(10))
                .tracking(2)
                .foregroundColor(OltreColors.textMuted)
                .padding(.horizontal, 20)
                .padding(.top, 24)
                .padding(.bottom, 12)

            VStack(spacing: 0) {
                content()
            }
            .background(OltreColors.warmWhite)
        }
    }

    private func settingsRow(icon: String, title: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.system(size: 16))
                    .foregroundColor(OltreColors.warmTerracotta)
                    .frame(width: 28)

                Text(title)
                    .font(OltreFonts.regular(15))
                    .foregroundColor(OltreColors.textDark)

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 12))
                    .foregroundColor(OltreColors.textMuted.opacity(0.4))
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 14)
        }
    }
}
