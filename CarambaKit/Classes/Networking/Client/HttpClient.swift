import Foundation
import RxSwift

open class HttpClient<T> {

    // MARK: - Attributes

    private let requestDispatcher: UrlRequestDispatcher
    private let sessionAdapter: Adapter<URLRequest, URLRequest>?
    private let responseAdapter: Adapter<(data: Data?, response: URLResponse?), (T, URLResponse?)>

    // MARK: - Init

    public init(responseAdapter: Adapter<(data: Data?, response: URLResponse?), (T, URLResponse?)>,
                requestDispatcher: UrlRequestDispatcher = UrlRequestDispatcher(),
                sessionAdapter: Adapter<URLRequest, URLRequest>? = nil) {
        self.responseAdapter = responseAdapter
        self.requestDispatcher = requestDispatcher
        self.sessionAdapter = sessionAdapter
    }

    // MARK: - Init

    open func request(request: URLRequest) -> Observable<(T, URLResponse?)> {
        let authenticatedRequest = self.sessionAdapter?.adapt(request) ?? request
        return self.requestDispatcher.dispatch(request: authenticatedRequest)
            .map({self.responseAdapter.adapt($0)!})
    }

}
