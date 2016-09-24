import Foundation
import Quick
import Nimble

@testable import CarambaKit

class SessionRepositorySpec: QuickSpec {
    override func spec() {
        
        var subject: SessionRepository!
        var session: Session!
        
        beforeEach {
            subject = SessionRepository(name: "test")
            session = Session(accessToken: "access", refreshToken: "refresh")
            subject.save(session: session)
        }

        //FIXME        
        // describe("-fetch") {
        //     it("should return the correct session") {
        //         let got = subject.fetch()!
        //         expect(got) == session
        //     }
        // }
        
        // describe("-clear") {
        //     it("should clear the session") {
        //         subject.clear()
        //         let got = subject.fetch()
        //         expect(got).to(beNil())
        //     }
        // }
        
        afterEach {
            subject.clear()
        }
        
        
    }
}