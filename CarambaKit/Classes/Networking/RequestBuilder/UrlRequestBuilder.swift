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

    public func get(path path: String) -> UrlRequestBuilder {
        return UrlRequestBuilder(baseUrl: self.baseUrl, type: .GET, path: path, parameters: self.parameters, body: self.body)
    }

    public func post(path path: String) -> UrlRequestBuilder {
        return UrlRequestBuilder(baseUrl: self.baseUrl, type: .POST, path: path, parameters: self.parameters, body: self.body)
    }

    public func patch(path path: String) -> UrlRequestBuilder {
        return UrlRequestBuilder(baseUrl: self.baseUrl, type: .PATCH, path: path, parameters: self.parameters, body: self.body)
    }

    public func delete(path path: String) -> UrlRequestBuilder {
        return UrlRequestBuilder(baseUrl: self.baseUrl, type: .DELETE, path: path, parameters: self.parameters, body: self.body)
    }

    public func put(path path: String) -> UrlRequestBuilder {
        return UrlRequestBuilder(baseUrl: self.baseUrl, type: .PUT, path: path, parameters: self.parameters, body: self.body)
    }

    public func withParameters(parameters: [String: AnyObject]) -> UrlRequestBuilder {
        return UrlRequestBuilder(baseUrl: self.baseUrl, type: self.type, path: self.path, parameters: parameters, body: self.body)
    }

    public func withBody(body: [String: AnyObject]) -> UrlRequestBuilder {
        return UrlRequestBuilder(baseUrl: self.baseUrl, type: self.type, path: self.path, parameters: self.parameters, body: body)
    }

    public func build(parameterEncoding parameterEncoding: UrlParameterEncoding = UrlParameterEncoding.URLEncodedInURL,
                      bodyEncoding: UrlParameterEncoding = UrlParameterEncoding.JSON) -> NSURLRequest {
        let url = NSURL(string: self.baseUrl)!.URLByAppendingPathComponent(self.path)
        let request = NSURLRequest(URL: url).mutableCopy() as! NSMutableURLRequest
        request.HTTPMethod = self.type.description
        let requestWithParameters = parameterEncoding.encode(request, parameters: self.parameters).0
        let requestWithParametersAndBody = bodyEncoding.encode(requestWithParameters, parameters: self.body).0
        return requestWithParametersAndBody
    }

}
