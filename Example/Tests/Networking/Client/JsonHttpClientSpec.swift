import Foundation
import Quick
import Nimble
import RxSwift

@testable import CarambaKit

class JsonHttpClientSpec: QuickSpec {
    override func spec() {
        
        var subject: JsonHttpClient!
        var dispatcher: MockUrlRequestDispatcher!
        
        beforeEach {
            dispatcher = MockUrlRequestDispatcher()
            subject = JsonHttpClient(requestDispatcher: dispatcher)
        }
        
        it("should add the Accept header for accepting json responses") {
            let request = URLRequest(url: URL(string: "https://test.com")!)
            _ = subject.request(request: request).subscribe(onCompleted: {
                // Do nothing
            })
            let headers = dispatcher.dispatchedRequest.allHTTPHeaderFields
            expect(headers!["Accept"]) == "application/json"
        }
        
    }
}


// MARK: - MockRequestDispatcher

private class MockUrlRequestDispatcher: UrlRequestDispatcher {
    
    var dispatchedRequest: URLRequest!
    
    fileprivate override func dispatch(request: URLRequest) -> Observable<(data: Data?, response: URLResponse?)> {
        self.dispatchedRequest = request
        return Observable.empty()
    }
    
}
