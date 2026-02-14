import SwiftUI
import AuthenticationServices

/// Full-screen branded entry point with animated gradient and Apple Sign-In
struct SplashView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var gradientStart = UnitPoint(x: 0, y: 0)
    @State private var gradientEnd = UnitPoint(x: 1, y: 1)
    @State private var showContent = false
    @State private var showSignIn = false

    var body: some View {
        ZStack {
            // Animated gradient background
            LinearGradient(
                colors: [
                    OltreColors.charcoal,
                    OltreColors.deepBurgundy,
                    OltreColors.navy,
                    OltreColors.forestGreen,
                    OltreColors.deepBurgundy,
                    OltreColors.charcoal
                ],
                startPoint: gradientStart,
                endPoint: gradientEnd
            )
            .ignoresSafeArea()
            .onAppear {
                withAnimation(.easeInOut(duration: 6).repeatForever(autoreverses: true)) {
                    gradientStart = UnitPoint(x: 1, y: 0)
                    gradientEnd = UnitPoint(x: 0, y: 1)
                }
            }

            // Content overlay
            VStack(spacing: 0) {
                Spacer()

                // Wordmark — placeholder for future logo asset
                VStack(spacing: 8) {
                    Text("THE OLTRE WAY")
                        .font(OltreFonts.wordmark(28))
                        .tracking(8)
                        .foregroundColor(OltreColors.cream)

                    Rectangle()
                        .fill(OltreColors.goldAccent.opacity(0.5))
                        .frame(width: 40, height: 1)
                }
                .opacity(showContent ? 1 : 0)
                .offset(y: showContent ? 0 : 20)

                Spacer()

                // Bottom section: Enter / Sign-In
                VStack(spacing: 24) {
                    if showSignIn {
                        // Apple Sign-In button
                        SignInWithAppleButton(.signIn) { request in
                            request.requestedScopes = [.fullName, .email]
                        } onCompletion: { result in
                            authViewModel.handleSignInResult(result)
                            hapticEnter()
                        }
                        .signInWithAppleButtonStyle(.white)
                        .frame(height: 50)
                        .frame(maxWidth: 280)
                        .cornerRadius(25)
                        .transition(.opacity.combined(with: .move(edge: .bottom)))

                        // Skip option
                        Button {
                            authViewModel.skipSignIn()
                            hapticEnter()
                        } label: {
                            Text("Continue as Guest")
                                .font(OltreFonts.regular(13))
                                .foregroundColor(OltreColors.cream.opacity(0.5))
                                .tracking(1)
                        }
                        .transition(.opacity)
                    } else {
                        // Enter button
                        Button {
                            hapticEnter()
                            withAnimation(.easeInOut(duration: 0.5)) {
                                showSignIn = true
                            }
                        } label: {
                            Text("ENTER")
                                .font(OltreFonts.medium(13))
                                .tracking(4)
                                .foregroundColor(OltreColors.cream.opacity(0.8))
                                .padding(.horizontal, 40)
                                .padding(.vertical, 16)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 2)
                                        .stroke(OltreColors.cream.opacity(0.3), lineWidth: 0.5)
                                )
                        }
                        .transition(.opacity)
                    }
                }
                .opacity(showContent ? 1 : 0)
                .padding(.bottom, 80)
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: 1.2).delay(0.3)) {
                showContent = true
            }
        }
    }

    private func hapticEnter() {
        let impact = UIImpactFeedbackGenerator(style: .medium)
        impact.impactOccurred()
    }
}
