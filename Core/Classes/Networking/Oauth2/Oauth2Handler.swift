import Foundation
import RxSwift

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
            throw Oauth2Error.AlreadyStarted
        }
        self.active = true
        self.delegate?.oauth2OpenUrl(self.entity.authorizationUrl())
    }
    
    public func shouldRedirectUrl(url: String) -> Bool {
        let request = self.entity.authenticationRequestFromUrl(url)
        if let request = request {
            self.performAuthentication(request)
        }
        return request == nil
    }
    
    
    // MARK: - Private
    
    private func performAuthentication(request: NSURLRequest) {
        self.client.request(request)
            .doOnNext { [weak self] (json, response) in
                do {
                    if let session = try self?.entity.sessionFromJSON(json) {
                        self?.delegate?.oauth2DidComplete(withSession: session)
                    }
                }
                catch {
                    self?.delegate?.oauth2DidFail(withError: error)
                }
                
                self?.active = false
            }
            .doOnError { [weak self] (error) in
                self?.delegate?.oauth2DidFail(withError: error)
                self?.active = false
            }
    }
    
}