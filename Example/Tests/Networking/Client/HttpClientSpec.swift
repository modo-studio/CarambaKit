import Foundation
import Quick
import Nimble
import RxSwift

@testable import CarambaKit

class HttpClientSpec: QuickSpec {
    
    override func spec() {
        
        var authenticatedRequest: NSURLRequest!
        var sessionAdapter: SessionMockAdapter!
        var responseAdapter: ResponseMockAdapter!
        var dispatcher: MockDispatcher!
        var subject: HttpClient<String>!
        var observable: Observable<(String, NSURLResponse?)>!
        
        beforeEach {
            authenticatedRequest = NSURLRequest(URL: NSURL(string: "https://authenticated")!)
            sessionAdapter = SessionMockAdapter(outputRequest: authenticatedRequest)
            responseAdapter = ResponseMockAdapter()
            dispatcher = MockDispatcher(response: (data: NSData(), response: nil))
            subject = HttpClient(responseAdapter: responseAdapter, requestDispatcher: dispatcher, sessionAdapter: sessionAdapter)
            observable = subject.request(NSURLRequest())
        }
        
        describe("-request:") {
            it("should dispatch the authenticated request") {
                dispatcher.dispatchedRequest = authenticatedRequest
            }
            it("should adapt the response") {
                waitUntil(action: { (done) in
                    _ = observable.subscribeNext({ (input) in
                        expect(input.0) == "works"
                        done()
                    })
                })
            }
        }
        
    }
    
}


// MARK: - Mocks


private class MockDispatcher: UrlRequestDispatcher {
    
    var dispatchedRequest: NSURLRequest!
    var response: (data: NSData?, response: NSURLResponse?)
    
    
    init(response: (data: NSData?, response: NSURLResponse?)) {
        self.response = response
    }
    
    private override func dispatch(request: NSURLRequest) -> Observable<(data: NSData?, response: NSURLResponse?)> {
        self.dispatchedRequest = request
        return Observable.just(self.response)
    }
    
}

private class SessionMockAdapter: Adapter<NSURLRequest, NSURLRequest> {
    
    var outputRequest: NSURLRequest!
    
    init(outputRequest: NSURLRequest) {
        self.outputRequest = outputRequest
    }
    
    private override func adapt(input: NSURLRequest) -> NSURLRequest! {
        return outputRequest
    }
    
}

private class ResponseMockAdapter: Adapter<(data: NSData?, response: NSURLResponse?), (String, NSURLResponse?)> {
    private override func adapt(input: (data: NSData?, response: NSURLResponse?)) -> (String, NSURLResponse?)! {
        return ("works", input.response)
    }
}