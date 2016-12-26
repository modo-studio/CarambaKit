import Foundation
import Result

open class HttpClient<T> {

    // MARK: - Attributes

    private let requestDispatcher: UrlRequestDispatcher
    private let sessionAdapter: Adapter<URLRequest, URLRequest>?
    private let responseAdapter: Adapter<Result<(Data, URLResponse), NSError>, Result<(T, URLResponse), NSError>>

    // MARK: - Init

    public init(responseAdapter: Adapter<Result<(Data, URLResponse), NSError>, Result<(T, URLResponse), NSError>>,
                requestDispatcher: UrlRequestDispatcher = UrlRequestDispatcher(),
                sessionAdapter: Adapter<URLRequest, URLRequest>? = nil) {
        self.responseAdapter = responseAdapter
        self.requestDispatcher = requestDispatcher
        self.sessionAdapter = sessionAdapter
    }

    // MARK: - Init

    open func request(request: URLRequest,
                      completionQueue: DispatchQueue = DispatchQueue.main,
                      completion: @escaping (Result<(T, URLResponse), NSError>) -> ()) {
        let authenticatedRequest = self.sessionAdapter?.adapt(request) ?? request
        self.requestDispatcher.dispatch(request: authenticatedRequest,
                                        completionQueue: completionQueue) { (result) in
            completion(self.responseAdapter.adapt(result))
        }
    }

}
