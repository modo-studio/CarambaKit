import Foundation

@available(*, deprecated, message: "Use https://github.com/carambalabs/paparajote instead")
public protocol Oauth2Delegate: class {

    func oauth2Open(url: String)
    func oauth2DidFail(with error: Error)
    func oauth2DidComplete(with session: Oauth2Session)

}
