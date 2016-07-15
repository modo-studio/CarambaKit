import Foundation
import Quick
import Nimble

@testable import Core

class UserDefaultsObservableSpec: QuickSpec {
    override func spec() {
        
        var subject: UserDefaultsObservable<String>!
        var userDefaults: NSUserDefaults!
        
        beforeEach {
            userDefaults = NSUserDefaults.standardUserDefaults()
            subject = UserDefaultsObservable(key: "test", userDefaults: userDefaults)
        }
        
        describe("rx") {
            it("should notify when the element is updated") {
                waitUntil(action: { (done) in
                    var called: Bool = false
                    _ = subject.rx().subscribeNext({ (next) in
                        if !called {
                            expect(next) == "uuu"
                            done()
                            called = true
                        }
                    })
                    userDefaults.setObject("uuu", forKey: "test")
                    userDefaults.synchronize()
                })
            }
            
            it("should notify when the element is removed") {
                waitUntil(action: { (done) in
                    var called: Bool = false
                    _ = subject.rx().subscribeNext({ (next) in
                        if !called {
                            expect(next).to(beNil())
                            done()
                            called = true
                        }
                    })
                    userDefaults.removeObjectForKey("test")
                    userDefaults.synchronize()
                })
            }
        }
        
    }
}