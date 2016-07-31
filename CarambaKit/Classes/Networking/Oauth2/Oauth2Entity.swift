import Foundation
import SwiftyJSON

public protocol Oauth2Entity {

    func authorizationUrl() -> String
    func authenticationRequestFromUrl(url: String) -> NSURLRequest?
    func sessionFromJSON(response: JSON) throws -> Oauth2Session

}
