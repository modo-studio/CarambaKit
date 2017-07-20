import Foundation

public struct UrlRequestBuilder {

    // MARK: - Attributes

    private let baseUrl: String
    private let path: String
    private let parameters: [String: AnyObject]
    private let body: [String: AnyObject]
    private let type: UrlRequestType!

    // MARK: - Init

    public init(baseUrl: String, type: UrlRequestType! = .GET, path: String = "", parameters: [String: AnyObject] = [:], body: [String: AnyObject] = [:]) {
        self.baseUrl = baseUrl
        self.path = path
        self.parameters = parameters
        self.body = body
        self.type = type
    }

    // MARK: - Public

    public func get(_ path: String) -> UrlRequestBuilder {
        return UrlRequestBuilder(baseUrl: self.baseUrl, type: .GET, path: path, parameters: self.parameters, body: self.body)
    }

    public func post(_ path: String) -> UrlRequestBuilder {
        return UrlRequestBuilder(baseUrl: self.baseUrl, type: .POST, path: path, parameters: self.parameters, body: self.body)
    }

    public func patch(_ path: String) -> UrlRequestBuilder {
        return UrlRequestBuilder(baseUrl: self.baseUrl, type: .PATCH, path: path, parameters: self.parameters, body: self.body)
    }

    public func delete(_ path: String) -> UrlRequestBuilder {
        return UrlRequestBuilder(baseUrl: self.baseUrl, type: .DELETE, path: path, parameters: self.parameters, body: self.body)
    }

    public func put(_ path: String) -> UrlRequestBuilder {
        return UrlRequestBuilder(baseUrl: self.baseUrl, type: .PUT, path: path, parameters: self.parameters, body: self.body)
    }

    public func with(parameters: [String: AnyObject]) -> UrlRequestBuilder {
        return UrlRequestBuilder(baseUrl: self.baseUrl, type: self.type, path: self.path, parameters: parameters, body: self.body)
    }

    public func with(body: [String: AnyObject]) -> UrlRequestBuilder {
        return UrlRequestBuilder(baseUrl: self.baseUrl, type: self.type, path: self.path, parameters: self.parameters, body: body)
    }

    public func build() -> NSURLRequest {
        let url = NSURL(string: self.baseUrl)!.appendingPathComponent(self.path)!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        components.queryItems = self.parameters.flatMap({ (value) -> URLQueryItem? in
            guard let stringValue = value.value as? CustomStringConvertible else { return nil }
            return URLQueryItem(name: value.key, value: stringValue.description)
        })
        let request = NSURLRequest(url: components.url!).mutableCopy() as! NSMutableURLRequest
        request.httpMethod = self.type.description
        request.httpBody = try? JSONSerialization.data(withJSONObject: self.body,
                                                       options: [])
        return request.copy() as! NSURLRequest
    }

}
