import Foundation
import Result

open class UrlRequestDispatcher {

    // MARK: - Attributes

    let configuration: URLSessionConfiguration

    // MARK: - Singleton

    public static var instance: UrlRequestDispatcher = UrlRequestDispatcher()

    // MARK: - Init

    public init(configuration: URLSessionConfiguration = URLSessionConfiguration.default) {
        self.configuration = configuration
    }

    // MARK: - Public

    public func dispatch(request: URLRequest, completion: @escaping (Result<Data, NSError>) -> Void) {
        let session = URLSession(configuration: self.configuration)
        let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) in
            if let error = error {
                completion(.failure(error as NSError))
            } else if let data = data {
                completion(.success(data))
            }
        })
        dataTask.resume()
    }

}
