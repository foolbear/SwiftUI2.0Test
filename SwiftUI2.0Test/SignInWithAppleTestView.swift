//
//  SignInWithAppleTestView.swift
//  SwiftUI2.0Test
//
//  Created by foolbear on 2021/2/9.
//

import SwiftUI
import Combine
import AuthenticationServices

struct SignInWithAppleTestView: View {
    @State private var subscriptions: Set<AnyCancellable> = []
    
    var body: some View {
        VStack {
            Spacer()
            SignInWithAppleButton(
                onRequest: { request in
                    request.requestedScopes = [.fullName, .email]
                },
                onCompletion: { result in
                    switch result {
                    case .success(let authResults):
                        switch authResults.credential {
                        case let appleIDCredential as ASAuthorizationAppleIDCredential:
                            //fullName=Optional(givenName: 震 familyName: 张 ), email=ibmw9zp2pp@privaterelay.appleid.com, user=002024.f281803c85f647348e9731a600bfb373.1455
                            //fullName=Optional(), email=-, user=002024.f281803c85f647348e9731a600bfb373.1455
                            print("fullName=\(String(describing: appleIDCredential.fullName)), email=\(appleIDCredential.email ?? "-"), user=\(appleIDCredential.user)")
                        case let passwordCredential as ASPasswordCredential:
                            let username = passwordCredential.user
                            let password = passwordCredential.password
                            print("username=\(username), password=\(password)")
                        default:
                            break
                        }
                    case .failure(let error):
                        print("failure", error)
                    }
                }
            )
            .signInWithAppleButtonStyle(.whiteOutline)
            .frame(width: 200, height: 50)
            Spacer(); Spacer()
        }
        .onAppear(perform: onAppear)
        .navigationTitle("Sign In With Apple")
    }
}

extension SignInWithAppleTestView {
    func onAppear() {
        checkStatus()
        NotificationCenter.default
            .publisher(for: ASAuthorizationAppleIDProvider.credentialRevokedNotification)
            .sink { notification in
                self.appleIDCredentialRevoked(notification)
            }
            .store(in: &subscriptions)
    }
    
    func checkStatus() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        appleIDProvider.getCredentialState(forUserID: "002024.f281803c85f647348e9731a600bfb373.1455") { (credentialState, error) in
            switch credentialState {
            case .authorized:
                print("The Apple ID credential is valid.")
                break
            case .revoked:
                print("The Apple ID credential is revoked. Sign out.")
                break
            case .notFound:
                print("No credential was found. Show login UI.")
                break
            case .transferred:
                print("The application was transferred from one development team to another. You can use the same code used to authenticate the user adding the locally saved user identifier in the request.")
            default:
                break
            }
        }
    }
    
    func appleIDCredentialRevoked(_ notification: Notification) {
        checkStatus()
    }
}

struct SignInWithAppleTestView_Previews: PreviewProvider {
    static var previews: some View {
        SignInWithAppleTestView()
    }
}
