import Foundation
import SwiftyJSON
import Result

open class UrlJsonResponseAdapter: Adapter<Result<Data, NSError>, Result<JSON, NSError>> {

    // MARK: - Singleton

    public static var instance: UrlJsonResponseAdapter = UrlJsonResponseAdapter()

    // MARK: - Public

    open override func adapt(_ input: Result<Data, NSError>) -> Result<JSON, NSError>! {
        return input.map({JSON(data: $0)})
    }

}
