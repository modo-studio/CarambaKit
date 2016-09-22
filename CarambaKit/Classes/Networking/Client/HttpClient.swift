import Foundation
import RxSwift

public class HttpClient<T> {

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

    public func request(request: URLRequest) -> Observable<(T, URLResponse?)> {
        var authenticatedRequest = self.sessionAdapter?.adapt(input: request) ?? request
        return self.requestDispatcher.dispatch(request: authenticatedRequest)
            .map({self.responseAdapter.adapt(input: $0)!})
    }

}
