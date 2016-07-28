import Foundation
import SwiftyJSON

public class UrlJsonResponseAdapter: Adapter<(data: NSData?, response: NSURLResponse?), (JSON, NSURLResponse?)> {

    // MARK: - Singleton

    public static var instance: UrlJsonResponseAdapter = UrlJsonResponseAdapter()

    // MARK: - Public

    public override func adapt(input: (data: NSData?, response: NSURLResponse?)) -> (JSON, NSURLResponse?)! {
        let json = JSON(input.data ?? NSData())
        return (json: json, response: input.response)
    }

}
