import Foundation
import Quick
import Nimble

@testable import CarambaKit

class UserDefaultsObservableSpec: QuickSpec {
    override func spec() {
        
        var subject: UserDefaultsObservable<String>!
        var userDefaults: UserDefaults!
        
        beforeEach {
            userDefaults = UserDefaults.standard
            subject = UserDefaultsObservable(key: "test", userDefaults: userDefaults)
        }
        
        describe("rx") {
            it("should notify when the element is updated") {
                waitUntil(action: { (done) in
                    var called: Bool = false
                    _ = subject.rx().subscribe(onNext: { (next) in
                        if !called {
                            expect(next) == "uuu"
                            done()
                            called = true
                        }
                    })
                    userDefaults.set("uuu", forKey: "test")
                    userDefaults.synchronize()
                })
            }
            
            it("should notify when the element is removed") {
                waitUntil(action: { (done) in
                    var called: Bool = false
                    _ = subject.rx().subscribe(onNext: { (next) in
                        if !called {
                            expect(next).to(beNil())
                            done()
                            called = true
                        }
                    })
                    userDefaults.removeObject(forKey: "test")
                    userDefaults.synchronize()
                })
            }
        }
        
    }
}
