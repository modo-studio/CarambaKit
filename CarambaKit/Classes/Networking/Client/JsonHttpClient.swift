import Foundation
import RxSwift
import SwiftyJSON

open class JsonHttpClient: HttpClient<JSON> {

    // MARK: - Init

    public init(requestDispatcher: UrlRequestDispatcher = UrlRequestDispatcher(), sessionAdapter: Adapter<URLRequest, URLRequest>? = nil) {
        super.init(responseAdapter: UrlJsonResponseAdapter.instance, requestDispatcher: requestDispatcher, sessionAdapter: sessionAdapter)
    }

    override open func request(request: URLRequest) -> Observable<(JSON, URLResponse?)> {
        return super.request(request: self.requestWithJSONHeaders(request: request))
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
