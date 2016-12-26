import Foundation
import SwiftyJSON
import Result

open class JsonHttpClient: HttpClient<JSON> {

    // MARK: - Init

    public init(requestDispatcher: UrlRequestDispatcher = UrlRequestDispatcher(),
                sessionAdapter: Adapter<URLRequest, URLRequest>? = nil) {
        super.init(responseAdapter: UrlJsonResponseAdapter.instance, requestDispatcher: requestDispatcher, sessionAdapter: sessionAdapter)
    }
    
    open override func request(request: URLRequest,
                               completionQueue: DispatchQueue = DispatchQueue.main,
                               completion: @escaping (Result<(JSON, URLResponse), NSError>) -> ()) {
        return super.request(request: self.requestWithJSONHeaders(request: request),
                             completionQueue: completionQueue,
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
