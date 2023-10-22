#if canImport(AuthenticationServices)
import AuthenticationServices

extension ASAuthorizationAppleIDCredential {
    
    private struct Printable: Encodable, CustomStringConvertible {
        
        let identityToken: String
        
        let authorizationCode: String
        
        let user: String
        
        let name: String?
        
        let email: String?
        
        init?(credential: ASAuthorizationAppleIDCredential) {
            guard let identityToken = credential.identityToken?.string(),
                let authorizationCode = credential.authorizationCode?.string() else {
                    return nil
            }
            self.identityToken = identityToken
            self.authorizationCode = authorizationCode
            user = credential.user
            name = [credential.fullName?.givenName, credential.fullName?.familyName]
                .compactMap { $0 }
                .joined(separator: " ")
            email = credential.email
        }
    }
    
    open override var description: String {
        Printable(credential: self)!.description
    }
}
#endif
