import Foundation
import SwiftyJSON

class JsonHttpClient: HttpClient<JSON> {

    
    // MARK: - Init
    
    public init(requestDispatcher: UrlRequestDispatcher = UrlRequestDispatcher(), sessionAdapter: Adapter<NSURLRequest, NSURLRequest>? = nil) {
        super.init(responseAdapter: UrlJsonResponseAdapter(), requestDispatcher: requestDispatcher, sessionAdapter: sessionAdapter)
    }
    
}