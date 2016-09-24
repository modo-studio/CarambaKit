import Foundation
import Quick
import Nimble
import RxSwift

@testable import CarambaKit

class HttpClientSpec: QuickSpec {
    
    override func spec() {
        
        var authenticatedRequest: URLRequest!
        var sessionAdapter: SessionMockAdapter!
        var responseAdapter: ResponseMockAdapter!
        var dispatcher: MockDispatcher!
        var subject: HttpClient<String>!
        var observable: Observable<(String, URLResponse?)>!
        
        beforeEach {
            authenticatedRequest = URLRequest(url: URL(string: "https://authenticated")!)
            sessionAdapter = SessionMockAdapter(outputRequest: authenticatedRequest)
            responseAdapter = ResponseMockAdapter()
            dispatcher = MockDispatcher(response: (data: Data(), response: nil))
            subject = HttpClient(responseAdapter: responseAdapter, requestDispatcher: dispatcher, sessionAdapter: sessionAdapter)
            observable = subject.request(request: URLRequest(url: URL(string: "test://test")!))
        }
        
        describe("-request:") {
            it("should dispatch the authenticated request") {
                dispatcher.dispatchedRequest = authenticatedRequest
            }
            it("should adapt the response") {
                waitUntil(action: { (done) in
                    _ = observable.subscribe(onNext: { (input) in
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
    
    var dispatchedRequest: URLRequest!
    var response: (data: Data?, response: URLResponse?)
    
    
    init(response: (data: Data?, response: URLResponse?)) {
        self.response = response
    }
    
    fileprivate override func dispatch(request: URLRequest) -> Observable<(data: Data?, response: URLResponse?)> {
        self.dispatchedRequest = request
        return Observable.just(self.response)
    }
    
}

private class SessionMockAdapter: Adapter<URLRequest, URLRequest> {
    
    var outputRequest: URLRequest!
    
    init(outputRequest: URLRequest) {
        self.outputRequest = outputRequest
    }
    
    fileprivate override func adapt(_ input: URLRequest) -> URLRequest! {
        return outputRequest
    }
    
}

private class ResponseMockAdapter: Adapter<(data: Data?, response: URLResponse?), (String, URLResponse?)> {
    fileprivate override func adapt(_ input: (data: Data?, response: URLResponse?)) -> (String, URLResponse?)! {
        return ("works", input.response)
    }
}
