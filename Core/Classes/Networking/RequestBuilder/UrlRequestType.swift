import Foundation

public enum UrlRequestType: CustomStringConvertible {
    
    case POST, GET, PUT, PATCH, DELETE
    
    public var description: String {
        switch self {
        case .POST: return "POST"
        case .GET: return "GET"
        case .PUT: return "PUT"
        case .PATCH: return "PATCH"
        case .DELETE: return "DELETE"
        }
    }
    
}
    