import Foundation

public struct Session: Equatable {

    // MARK: Attributes

    public let accessToken: String
    public let refreshToken: String

    // MARK: Init

    public init(accessToken: String, refreshToken: String) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }

}

public func == (lhs: Session, rhs: Session) -> Bool {
    return lhs.accessToken == rhs.accessToken &&
    lhs.refreshToken == rhs.refreshToken
}
