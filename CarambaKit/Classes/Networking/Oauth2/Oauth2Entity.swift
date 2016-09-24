import Foundation
import SwiftyJSON

@available(*, deprecated, message: "Use https://github.com/carambalabs/paparajote instead")
public protocol Oauth2Entity {

    func authorizationUrl() -> String
    func authenticationRequestFromUrl(url: String) -> URLRequest?
    func sessionFromJSON(response: JSON) throws -> Oauth2Session

}
