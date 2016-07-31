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
            let request = NSURLRequest(URL: NSURL(string: "https://test.com")!)
            _ = subject.request(request).subscribeCompleted({
                // Do nothing
            })
            let headers = dispatcher.dispatchedRequest.allHTTPHeaderFields
            expect(headers!["Accept"]) == "application/json"
        }
        
    }
}


// MARK: - MockRequestDispatcher

private class MockUrlRequestDispatcher: UrlRequestDispatcher {
    
    var dispatchedRequest: NSURLRequest!
    
    private override func dispatch(request: NSURLRequest) -> Observable<(data: NSData?, response: NSURLResponse?)> {
        self.dispatchedRequest = request
        return Observable.empty()
    }
    
}