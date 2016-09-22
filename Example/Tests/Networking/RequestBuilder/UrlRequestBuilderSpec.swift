import Foundation
import Quick
import Nimble
import SwiftyJSON

@testable import CarambaKit

class UrlRequestSharedExamplesConfiguration: QuickConfiguration {
    override class func configure(_ configuration: Configuration) {
        sharedExamples("built request") { (sharedExampleContext: @escaping SharedExampleContext) in
            var request: URLRequest!
            var expectedUrl: URL!
            var method: String!
            var body: [AnyHashable: Any]!
            
            beforeSuite {
                let context = sharedExampleContext()
                request = context["request"] as! URLRequest
                expectedUrl = URL(string: context["url"] as! String)!
                method = context["method"] as! String
                body = context["body"] as! [AnyHashable: Any]
            }
            
            it("should have the correct url") {
                expect(request.url) == expectedUrl
            }
            
            it("should have the correct type") {
                expect(request.httpMethod) == method
            }
            
            it("should have the correct body") {
                let got = try! JSONSerialization.jsonObject(with: request.httpBody!, options: JSONSerialization.ReadingOptions.allowFragments)
                let expected = JSON(body)
                expect(JSON(got)) == expected
            }
        }
    }
}

class UrlRequestBuilderSpec: QuickSpec {
    override func spec() {
        
        context("GET") {
            itBehavesLike("built request", sharedExampleContext: { () -> (NSDictionary) in
                let request = UrlRequestBuilder(baseUrl: "https://api.com")
                    .get("endpoint/v1")
                    .with(parameters: ["uu": "aa" as AnyObject])
                    .with(body: ["body2": "value1" as AnyObject])
                    .build()
                return ["request": request,
                    "url": "https://api.com/endpoint/v1?uu=aa",
                    "method": "GET",
                    "body": ["body2": "value1"]]
            })
        }
        
        context("POST") {
            itBehavesLike("built request", sharedExampleContext: { () -> (NSDictionary) in
                let request = UrlRequestBuilder(baseUrl: "https://api.com")
                    .post("endpoint/v1")
                    .with(parameters: ["param1": "value1" as AnyObject])
                    .with(body: ["body1": "value1" as AnyObject])
                    .build()
                return ["request": request,
                "url": "https://api.com/endpoint/v1?param1=value1",
                "method": "POST",
                "body": ["body1": "value1"]]
            })
        }
        
        context("DELETE") {
            itBehavesLike("built request", sharedExampleContext: { () -> (NSDictionary) in
                let request = UrlRequestBuilder(baseUrl: "https://api.com")
                    .delete("")
                    .with(parameters: ["param1": "value1" as AnyObject])
                    .with(body: ["body1": "value1" as AnyObject])
                    .build()
                return ["request": request,
                    "url": "https://api.com/?param1=value1",
                    "method": "DELETE",
                    "body": ["body1": "value1"]]
            })
        }
        
        context("PUT") {
            itBehavesLike("built request", sharedExampleContext: { () -> (NSDictionary) in
                let request = UrlRequestBuilder(baseUrl: "https://api.com")
                    .put("uu")
                    .with(parameters: ["param1": "value1" as AnyObject])
                    .with(body: ["body1": "value2" as AnyObject])
                    .build()
                return ["request": request,
                    "url": "https://api.com/uu?param1=value1",
                    "method": "PUT",
                    "body": ["body1": "value2"]]
            })
        }

        
        context("PATCH") {
            itBehavesLike("built request", sharedExampleContext: { () -> (NSDictionary) in
                let request = UrlRequestBuilder(baseUrl: "https://api.com")
                    .patch("uu")
                    .with(parameters: ["param1": "value1" as AnyObject])
                    .with(body: ["body1": "value2" as AnyObject])
                    .build()
                return ["request": request,
                    "url": "https://api.com/uu?param1=value1",
                    "method": "PATCH",
                    "body": ["body1": "value2"]]
            })
        }
    }
}
