import Foundation
import SwiftyJSON

open class UrlJsonResponseAdapter: Adapter<(data: Data?, response: URLResponse?), (JSON, URLResponse?)> {

    // MARK: - Singleton

    public static var instance: UrlJsonResponseAdapter = UrlJsonResponseAdapter()

    // MARK: - Public

    open override func adapt(_ input: (data: Data?, response: URLResponse?)) -> (JSON, URLResponse?)! {
        let json = JSON(data: input.data ?? Data())
        return (json: json, response: input.response)
    }

}
