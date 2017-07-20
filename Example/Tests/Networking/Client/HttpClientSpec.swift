import Foundation
import Quick
import Nimble
import Result

@testable import CarambaKit

class HttpClientSpec: QuickSpec {
    
    override func spec() {
        
        var authenticatedRequest: URLRequest!
        var responseAdapter: ResponseMockAdapter!
        var dispatcher: MockDispatcher!
        var subject: HttpClient<String>!
        
        beforeEach {
            authenticatedRequest = URLRequest(url: URL(string: "https://authenticated")!)
            responseAdapter = ResponseMockAdapter()
            dispatcher = MockDispatcher(response: (Data(), URLResponse(url: URL(string: "aga")!, mimeType: "", expectedContentLength: 3, textEncodingName: "33")))
            subject = HttpClient(responseAdapter: responseAdapter, requestDispatcher: dispatcher)
        }
        
        describe("-request:") {
            it("should dispatch the authenticated request") {
                dispatcher.dispatchedRequest = authenticatedRequest
            }
            it("should adapt the response") {
                waitUntil(action: { (done) in
                    subject.request(request: authenticatedRequest, completion: { (result) in
                        expect(result.value?.0) == "works"
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
    var response: (Data, URLResponse)
    
    
    init(response: (Data, URLResponse)) {
        self.response = response
    }
    
    fileprivate override func dispatch(request: URLRequest,
                                        completionQueue: DispatchQueue = DispatchQueue.main,
                                        completion: @escaping (Result<(Data, URLResponse), NSError>) -> Void) {
        self.dispatchedRequest = request
        let result: Result<(Data, URLResponse), NSError> = Result(self.response)
        completion(result)
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

private class ResponseMockAdapter: Adapter<Result<(Data, URLResponse), NSError>, Result<(String, URLResponse), NSError>> {
    fileprivate override func adapt(_ input: Result<(Data, URLResponse), NSError>) -> Result<(String, URLResponse), NSError>! {
        let result: Result<(String, URLResponse), NSError> = Result(("works", input.value!.1))
        return result
    }
}
