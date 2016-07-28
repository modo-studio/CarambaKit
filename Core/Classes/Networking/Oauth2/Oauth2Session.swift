import Foundation

public struct Oauth2Session: Equatable {
    public let accessToken: String
    public let refreshToken: String

    public init(accessToken: String, refreshToken: String) {
      self.accessToken = accessToken
      self.refreshToken = refreshToken
    }
}

public func == (lhs: Oauth2Session, rhs: Oauth2Session) -> Bool {
    return lhs.accessToken == rhs.accessToken &&
    lhs.refreshToken == rhs.refreshToken
}
