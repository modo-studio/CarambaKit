import Foundation
import Result

open class HttpClient<T> {

    // MARK: - Attributes

    private let requestDispatcher: UrlRequestDispatcher
    private let sessionAdapter: Adapter<URLRequest, URLRequest>?
    private let responseAdapter: Adapter<Result<Data, NSError>, Result<T, NSError>>

    // MARK: - Init

    public init(responseAdapter: Adapter<Result<Data, NSError>, Result<T, NSError>>,
                requestDispatcher: UrlRequestDispatcher = UrlRequestDispatcher(),
                sessionAdapter: Adapter<URLRequest, URLRequest>? = nil) {
        self.responseAdapter = responseAdapter
        self.requestDispatcher = requestDispatcher
        self.sessionAdapter = sessionAdapter
    }

    // MARK: - Init

    open func request(request: URLRequest, completion: @escaping (Result<T, NSError>) -> ()) {
        let authenticatedRequest = self.sessionAdapter?.adapt(request) ?? request
        self.requestDispatcher.dispatch(request: authenticatedRequest) { (result) in
            completion(self.responseAdapter.adapt(result))
        }
    }

}
