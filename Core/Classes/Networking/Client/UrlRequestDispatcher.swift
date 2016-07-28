import Foundation
import RxSwift

public class UrlRequestDispatcher {

    // MARK: - Attributes

    let configuration: NSURLSessionConfiguration

    // MARK: - Singleton

    public static var instance: UrlRequestDispatcher = UrlRequestDispatcher()

    // MARK: - Init

    public init(configuration: NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()) {
        self.configuration = configuration
    }

    // MARK: - Public

    public func dispatch(request: NSURLRequest) -> Observable<(data: NSData?, response: NSURLResponse?)> {
        let session = NSURLSession(configuration: self.configuration)
        return Observable.create { (observer) -> Disposable in
            let dataTask = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) in
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
