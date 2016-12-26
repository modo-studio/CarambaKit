import Foundation
import SwiftyJSON
import Result

open class UrlJsonResponseAdapter: Adapter<Result<(Data, URLResponse), NSError>, Result<(JSON, URLResponse), NSError>> {

    // MARK: - Singleton

    public static var instance: UrlJsonResponseAdapter = UrlJsonResponseAdapter()

    // MARK: - Public

    open override func adapt(_ input: Result<(Data, URLResponse), NSError>) -> Result<(JSON, URLResponse), NSError>! {
        return input.map({(JSON(data: $0.0), $0.1)})
    }

}
