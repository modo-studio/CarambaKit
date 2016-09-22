import Foundation

public protocol Oauth2Delegate: class {

    func oauth2Open(url url: String)
    func oauth2DidFail(with error: Error)
    func oauth2DidComplete(with session: Oauth2Session)

}
