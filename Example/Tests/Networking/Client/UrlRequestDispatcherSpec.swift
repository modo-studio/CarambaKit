import Foundation
import Quick
import Nimble
import Mockingjay

@testable import CarambaKit

class UrlRequestDispatcherSpec: QuickSpec {
    override func spec() {
        var subject: UrlRequestDispatcher!
        
        beforeEach {
            subject = UrlRequestDispatcher()
        }
        
        afterEach {
            self.removeAllStubs()
        }
        
        describe("-dispatch:") {
            context("when there's an error") {
                it("should send an error event to the observer") {
                    let error = NSError(domain: "", code: -1, userInfo: nil)
                    self.stub(uri("http://test"), builder: failure(error))
                    let request = NSURLRequest(URL: NSURL(string: "http://test")!)
                    waitUntil(action: { (done) in
                        _ = subject.dispatch(request)
                            .subscribeError({ (_error) in
                                expect(_error as NSError) == error
                                done()
                            })
                    })
                }
            }
            context("when there's data") {
                it("should send the next event with the data to the observer") {
                    let data = NSData()
                    self.stub(uri("http://test"), builder: http(200, headers: nil, data: data))
                    let request = NSURLRequest(URL: NSURL(string: "http://test")!)
                    waitUntil(action: { (done) in
                        _ = subject.dispatch(request)
                            .doOnCompleted({ 
                                done()
                            })
                            .subscribeNext({ (input) in
                                expect(input.data) == data
                            })
                    })
                }
            }
        }
    }
}