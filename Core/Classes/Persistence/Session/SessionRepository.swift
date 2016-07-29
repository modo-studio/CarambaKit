import Foundation
import KeychainSwift

public class SessionRepository {

    // MARK: - Attributes

    private let name: String
    private let keychain: KeychainSwift

    // MARK: - Init

    public init(name: String) {
        self.name = name
        self.keychain = KeychainSwift()
    }

    // MARK: - Public

    public func save(session session: Session) {
        let accessToken = session.accessToken
        let refreshToken = session.refreshToken
        self.keychain.set(accessToken, forKey: self.accessTokenKey())
        self.keychain.set(refreshToken, forKey: self.refreshTokenKey())
    }

    public func fetch() -> Session? {
        guard let accessToken = self.keychain.get(self.accessTokenKey()) else { return nil }
        guard let refreshToken = self.keychain.get(self.refreshTokenKey()) else { return nil }
        return Session(accessToken: accessToken, refreshToken: refreshToken)
    }

    public func clear() {
        self.keychain.delete(self.accessTokenKey())
        self.keychain.delete(self.refreshTokenKey())
    }

    // MARK: - Private

    private func accessTokenKey() -> String {
        return "\(self.name)_access_token"
    }

    private func refreshTokenKey() -> String {
        return "\(self.name)_refresh_token"
    }

}
