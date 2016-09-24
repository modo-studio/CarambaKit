import Foundation
import Quick
import Nimble
import SwiftyJSON
import RxSwift

@testable import CarambaKit

class Oauth2HandlerSpec: QuickSpec {
    override func spec() {
        
        var subject: Oauth2Handler!
        var oauth2Entity: MockOauth2Entity!
        var delegate: MockOauth2Delegate!
        var jsonClient: MockJsonHttpClient!
        
        beforeEach {
            oauth2Entity = MockOauth2Entity()
            delegate = MockOauth2Delegate()
            jsonClient = MockJsonHttpClient(response: JSON([:]))
            subject = Oauth2Handler(entity: oauth2Entity, delegate: delegate, client: jsonClient)
        }
        
        describe("-start") {
            
            it("should throw an error if it's started once it's active") {
                try! subject.start()
                expect { try subject.start() }.to(throwError())
            }
            it("should ask to open the authentication URL") {
                try! subject.start()
                expect(delegate.openedUrl) == "http://authentication"
            }
            
            it("should notify about the session") {
                try! subject.start()
                _ = subject.shouldRedirectUrl(url: "url")
                expect(delegate.session) == Oauth2Session(accessToken: "access", refreshToken: "refresh")
            }
            
            context("if the client throws an error") {
                it("should notify about the error") {
                    let error = NSError(domain: "test", code: -1, userInfo: nil)
                    jsonClient = MockJsonHttpClient(error: error)
                    subject = Oauth2Handler(entity: oauth2Entity, delegate: delegate, client: jsonClient)
                    try! subject.start()
                    _ = subject.shouldRedirectUrl(url: "url")
                    expect(delegate.error as NSError) == error
                }
            }
        }
        
    }
}


// MARK: - Mock

private class MockOauth2Entity: Oauth2Entity {
    
    func authorizationUrl() -> String {
        return "http://authentication"
    }
    
    func authenticationRequestFromUrl(url: String) -> URLRequest? {
        return URLRequest(url: URL(string: url)!)
    }
    
    func sessionFromJSON(response: JSON) throws -> Oauth2Session {
        return Oauth2Session(accessToken: "access", refreshToken: "refresh")
    }
}

private class MockOauth2Delegate: Oauth2Delegate {
    
    var openedUrl: String!
    var error: Error!
    var session: Oauth2Session!
    
    func oauth2Open(url: String) {
        self.openedUrl = url
    }
    
    func oauth2DidFail(with error: Error) {
        self.error = error
    }
    
    func oauth2DidComplete(with session: Oauth2Session) {
        self.session = session
    }
    
}

private class MockJsonHttpClient: JsonHttpClient {
    
    var response: JSON!
    var error: Error!
    
    init(response: JSON) {
        self.response = response
    }
    
    init(error: Error) {
        self.error = error
    }
    
    fileprivate override func request(request: URLRequest) -> Observable<(JSON, URLResponse?)> {
        if let error = error {
            return Observable.error(error)
        }
        else {
            return Observable.just((self.response, nil))
        }
    }
}
