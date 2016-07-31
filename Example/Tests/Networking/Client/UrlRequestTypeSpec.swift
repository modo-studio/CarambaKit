import Foundation
import Quick
import Nimble

@testable import CarambaKit

class UrlRequestTypeSpec: QuickSpec {
    override func spec() {
        describe("-description") {
            context("POST") {
                it("should return the correct value") {
                    expect(UrlRequestType.POST.description) == "POST"
                }
            }
            context("PUT") {
                it("should return the correct value") {
                    expect(UrlRequestType.PUT.description) == "PUT"
                }
            }
            context("GET") {
                it("should return the correct value") {
                    expect(UrlRequestType.GET.description) == "GET"
                }
            }
            context("PATCH") {
                it("should return the correct value") {
                    expect(UrlRequestType.PATCH.description) == "PATCH"
                }
            }
            context("DELETE") {
                it("should return the correct value") {
                    expect(UrlRequestType.DELETE.description) == "DELETE"
                }
            }
        }
    }
}