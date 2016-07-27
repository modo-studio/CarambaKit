import Foundation
import RxSwift
import SwiftyJSON

public class JsonHttpClient: HttpClient<JSON> {

    // MARK: - Init
    
    public init(requestDispatcher: UrlRequestDispatcher = UrlRequestDispatcher(), sessionAdapter: Adapter<NSURLRequest, NSURLRequest>? = nil) {
        super.init(responseAdapter: UrlJsonResponseAdapter.instance, requestDispatcher: requestDispatcher, sessionAdapter: sessionAdapter)
    }
    
    override public func request(request: NSURLRequest) -> Observable<(JSON, NSURLResponse?)> {
        return super.request(self.requestWithJSONHeaders(request))
    }
    
    
    // MARK: - Private
    
    private func requestWithJSONHeaders(request: NSURLRequest) -> NSURLRequest {
        let mutableRequest: NSMutableURLRequest = request.mutableCopy() as! NSMutableURLRequest
        var headers = mutableRequest.allHTTPHeaderFields ?? [:]
        headers["Accept"] = "application/json"
        mutableRequest.allHTTPHeaderFields = headers
        return mutableRequest.copy() as! NSURLRequest
    }
    
}
