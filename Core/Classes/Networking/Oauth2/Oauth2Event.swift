import Foundation

public protocol Oauth2Delegate: class {
    
    func oauth2OpenUrl(url: String)
    func oauth2DidFail(withError error: ErrorType)
    func oauth2DidComplete(withSession session: Oauth2Session)
    
}