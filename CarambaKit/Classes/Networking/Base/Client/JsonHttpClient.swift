import Foundation
import SwiftyJSON
import Result

open class JsonHttpClient: HttpClient<JSON> {

    // MARK: - Init

    public init(requestDispatcher: UrlRequestDispatcher = UrlRequestDispatcher(),
                sessionAdapter: Adapter<URLRequest, URLRequest>? = nil) {
        super.init(responseAdapter: UrlJsonResponseAdapter.instance, requestDispatcher: requestDispatcher, sessionAdapter: sessionAdapter)
    }
    
    open override func request(request: URLRequest, completion: @escaping (Result<JSON, NSError>) -> ()) {
        return super.request(request: self.requestWithJSONHeaders(request: request),
                             completion: completion)
    }

    // MARK: - Private

    private func requestWithJSONHeaders(request: URLRequest) -> URLRequest {
        var mutableRequest: URLRequest = request
        var headers = mutableRequest.allHTTPHeaderFields ?? [:]
        headers["Accept"] = "application/json"
        mutableRequest.allHTTPHeaderFields = headers
        return mutableRequest
    }

}
