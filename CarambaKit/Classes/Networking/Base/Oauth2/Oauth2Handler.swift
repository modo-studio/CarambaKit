import Foundation
import Result

@available(*, deprecated, message: "Use https://github.com/carambalabs/paparajote instead")
public class Oauth2Handler {
    
    // MARK: - Attributes
    
    private let entity: Oauth2Entity
    private let client: JsonHttpClient
    private weak var delegate: Oauth2Delegate?
    private var active: Bool = false
    
    // MARK: - Init
    
    public init(entity: Oauth2Entity, delegate: Oauth2Delegate, client: JsonHttpClient = JsonHttpClient()) {
        self.entity = entity
        self.delegate = delegate
        self.client = client
    }
    
    // MARK: - Public
    
    public func start() throws {
        if self.active {
            throw Oauth2Error.alreadyStarted
        }
        self.active = true
        self.delegate?.oauth2Open(url: self.entity.authorizationUrl())
    }
    
    public func shouldRedirectUrl(url: String) -> Bool {
        let request = self.entity.authenticationRequestFromUrl(url: url)
        if let request = request {
            self.performAuthentication(request: request)
        }
        return request == nil
    }
    
    // MARK: - Private
    
    private func performAuthentication(request: URLRequest) {
        self.client.request(request: request) { response in
            if let value = response.value {
                do {
                    try self.delegate?.oauth2DidComplete(with: self.entity.sessionFromJSON(response: value))
                } catch {
                    self.delegate?.oauth2DidFail(with: error)
                }
                
            } else if let error = response.error {
                self.delegate?.oauth2DidFail(with: error)
                self.active = false
            }
        }
    }
    
}
