import Foundation
import AuthenticationServices
import SwiftUI

// MARK: - Auth View Model
final class AuthViewModel: ObservableObject {
    @Published var isAuthenticated = false
    @Published var userName: String = ""
    @Published var userEmail: String = ""

    private let userDefaultsKey = "oltreWayUserID"

    init() {
        // Check if user was previously signed in
        if let _ = UserDefaults.standard.string(forKey: userDefaultsKey) {
            isAuthenticated = true
            userName = UserDefaults.standard.string(forKey: "oltreWayUserName") ?? "Traveler"
            userEmail = UserDefaults.standard.string(forKey: "oltreWayUserEmail") ?? ""
        }
    }

    func handleSignInResult(_ result: Result<ASAuthorization, Error>) {
        switch result {
        case .success(let authorization):
            if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
                let userID = appleIDCredential.user

                // Only available on first sign-in
                if let fullName = appleIDCredential.fullName {
                    let name = [fullName.givenName, fullName.familyName]
                        .compactMap { $0 }
                        .joined(separator: " ")
                    if !name.isEmpty {
                        userName = name
                        UserDefaults.standard.set(name, forKey: "oltreWayUserName")
                    }
                }

                if let email = appleIDCredential.email {
                    userEmail = email
                    UserDefaults.standard.set(email, forKey: "oltreWayUserEmail")
                }

                UserDefaults.standard.set(userID, forKey: userDefaultsKey)
                isAuthenticated = true
            }
        case .failure:
            // Allow guest access on sign-in failure
            break
        }
    }

    func skipSignIn() {
        isAuthenticated = true
        userName = "Guest"
        UserDefaults.standard.set("guest", forKey: userDefaultsKey)
        UserDefaults.standard.set("Guest", forKey: "oltreWayUserName")
    }

    func signOut() {
        isAuthenticated = false
        userName = ""
        userEmail = ""
        UserDefaults.standard.removeObject(forKey: userDefaultsKey)
        UserDefaults.standard.removeObject(forKey: "oltreWayUserName")
        UserDefaults.standard.removeObject(forKey: "oltreWayUserEmail")
    }
}
