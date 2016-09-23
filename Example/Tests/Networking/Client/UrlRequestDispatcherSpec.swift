import Foundation
import Quick
import Nimble
import OHHTTPStubs

@testable import CarambaKit

class UrlRequestDispatcherSpec: QuickSpec {
    override func spec() {
        var subject: UrlRequestDispatcher!
        
        beforeEach {
            subject = UrlRequestDispatcher()
        }
        
        afterEach {
            
            OHHTTPStubs.removeAllStubs()
        }
        
        //FIXME
//        describe("-dispatch:") {
//            context("when there's an error") {
//                it("should send an error event to the observer") {
//                    let error = NSError(domain: "", code: -1, userInfo: nil)
//                    _ = stub(condition: isScheme("test"), response: { (request) -> OHHTTPStubsResponse in
//                        return OHHTTPStubsResponse(error: error)
//                    })
//                    let request = URLRequest(url: NSURL(string: "test://test")! as URL)
//                    waitUntil(action: { (done) in
//                        let disposable = subject.dispatch(request: request)
//                            .subscribe(onError: { (_error) in
//                                done()
//                            })
//                    })
//                }
//            }
//            context("when there's data") {
//                it("should send the next event with the data to the observer") {
//                    let data = Data()
//                    let request = URLRequest(url: URL(string: "test://test")!)
//                    _ = stub(condition: isScheme("test"), response: { (request) -> OHHTTPStubsResponse in
//                        return OHHTTPStubsResponse(data: data, statusCode: 200, headers: nil)
//                    })
//                    waitUntil(action: { (done) in
//                        let disposable = subject.dispatch(request: request)
//                            .do(onCompleted: { 
//                                done()
//                            })
//                            .subscribe(onNext: { (input) in
//                                expect(input.data) == data
//                            })
//                    })
//                }
//            }
//        }
    }
}
