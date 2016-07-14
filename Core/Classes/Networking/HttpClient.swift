import Foundation
import RxSwift

public class HttpClient<T> {
    
    // MARK: - Attributes
    
    private let requestDispatcher: UrlRequestDispatcher
    private let sessionAdapter: Adapter<NSURLRequest, NSURLRequest>?
    private let responseAdapter: Adapter<(data: NSData?, response: NSURLResponse?), (T, NSURLResponse?)>
    
    
    // MARK: - Init
    
    public init(responseAdapter: Adapter<(data: NSData?, response: NSURLResponse?), (T, NSURLResponse?)>, requestDispatcher: UrlRequestDispatcher = UrlRequestDispatcher(), sessionAdapter: Adapter<NSURLRequest, NSURLRequest>? = nil) {
        self.responseAdapter = responseAdapter
        self.requestDispatcher = requestDispatcher
        self.sessionAdapter = sessionAdapter
    }
    
    
    // MARK: - Init
    
    public func request(request: NSURLRequest) -> Observable<(T, NSURLResponse?)> {
        var authenticatedRequest = self.sessionAdapter?.adapt(request) ?? request
        return self.requestDispatcher.dispatch(authenticatedRequest)
            .map({self.responseAdapter.adapt($0)!})
    }

}
