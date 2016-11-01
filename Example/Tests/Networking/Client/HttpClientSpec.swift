import Foundation
import Quick
import Nimble
import Result

@testable import CarambaKit

class HttpClientSpec: QuickSpec {
    
    override func spec() {
        
        var authenticatedRequest: URLRequest!
        var sessionAdapter: SessionMockAdapter!
        var responseAdapter: ResponseMockAdapter!
        var dispatcher: MockDispatcher!
        var subject: HttpClient<String>!
        
        beforeEach {
            authenticatedRequest = URLRequest(url: URL(string: "https://authenticated")!)
            sessionAdapter = SessionMockAdapter(outputRequest: authenticatedRequest)
            responseAdapter = ResponseMockAdapter()
            dispatcher = MockDispatcher(response: (data: Data(), response: nil))
            subject = HttpClient(responseAdapter: responseAdapter, requestDispatcher: dispatcher)
        }
        
        describe("-request:") {
            it("should dispatch the authenticated request") {
                dispatcher.dispatchedRequest = authenticatedRequest
            }
            it("should adapt the response") {
                waitUntil(action: { (done) in
                    subject.request(request: authenticatedRequest, completion: { (result) in
                        expect(result.value) == "works"
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
    
    fileprivate override func dispatch(request: URLRequest, completion: @escaping (Result<Data, NSError>) -> Void) {
        self.dispatchedRequest = request
        completion(.success(self.response.data!))
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

private class ResponseMockAdapter: Adapter<Result<Data, NSError>, Result<String, NSError>> {
    fileprivate override func adapt(_ input: Result<Data, NSError>) -> Result<String, NSError>! {
        return .success("works")
    }
}
