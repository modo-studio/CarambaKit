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
                    self.stub(uri("http://test"), failure(error))
                    let request = URLRequest(url: NSURL(string: "http://test")! as URL)
                    waitUntil(action: { (done) in
                        _ = subject.dispatch(request: request)
                            .subscribe(onError: { (_error) in
                                expect(_error as NSError) == error
                                done()
                            })
                    })
                }
            }
            context("when there's data") {
                it("should send the next event with the data to the observer") {
                    let data = Data()
                    self.stub(uri("http://test"), http(200, headers: nil, download: .content(data)))
                    let request = URLRequest(url: NSURL(string: "http://test")! as URL)
                    waitUntil(action: { (done) in
                        _ = subject.dispatch(request: request)
                            .do(onCompleted: { 
                                done()
                            })
                            .subscribe(onNext: { (input) in
                                expect(input.data) == data
                            })
                    })
                }
            }
        }
    }
}
