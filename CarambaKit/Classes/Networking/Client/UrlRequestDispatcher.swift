import Foundation
import RxSwift

public class UrlRequestDispatcher {

    // MARK: - Attributes

    let configuration: URLSessionConfiguration

    // MARK: - Singleton

    public static var instance: UrlRequestDispatcher = UrlRequestDispatcher()

    // MARK: - Init

    public init(configuration: URLSessionConfiguration = URLSessionConfiguration.default) {
        self.configuration = configuration
    }

    // MARK: - Public

    public func dispatch(request request: URLRequest) -> Observable<(data: Data?, response: URLResponse?)> {
        let session = URLSession(configuration: self.configuration)
        return Observable.create { (observer) -> Disposable in
            let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) in
                if let error = error {
                    observer.onError(error)
                } else {
                    observer.onNext((data: data, response: response))
                    observer.onCompleted()
                }
            })
            dataTask.resume()
            return AnonymousDisposable {
                dataTask.cancel()
            }
        }
    }

}
