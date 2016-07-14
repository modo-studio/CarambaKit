import Foundation
import Quick
import Nimble
import SwiftyJSON

@testable import Core

class UrlRequestSharedExamplesConfiguration: QuickConfiguration {
    override class func configure(configuration: Configuration) {
        sharedExamples("built request") { (sharedExampleContext: SharedExampleContext) in
            var request: NSURLRequest!
            var expectedUrl: NSURL!
            var method: String!
            var body: [NSObject: AnyObject]!
            
            beforeSuite {
                let context = sharedExampleContext()
                request = context["request"] as! NSURLRequest
                expectedUrl = NSURL(string: context["url"] as! String)!
                method = context["method"] as! String
                body = context["body"] as! [NSObject: AnyObject]
            }
            
            it("should have the correct url") {
                expect(request.URL) == expectedUrl
            }
            
            it("should have the correct type") {
                expect(request.HTTPMethod) == method
            }
            
            it("should have the correct body") {
                let got = try! NSJSONSerialization.JSONObjectWithData(request.HTTPBody!, options: NSJSONReadingOptions.AllowFragments)
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
                    .get(path: "endpoint/v1")
                    .withParameters(["uu": "aa"])
                    .withBody(["body2": "value1"])
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
                    .post(path: "endpoint/v1")
                    .withParameters(["param1": "value1"])
                    .withBody(["body1": "value1"])
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
                    .delete(path: "")
                    .withParameters(["param1": "value1"])
                    .withBody(["body1": "value1"])
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
                    .put(path: "uu")
                    .withParameters(["param1": "value1"])
                    .withBody(["body1": "value2"])
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
                    .patch(path: "uu")
                    .withParameters(["param1": "value1"])
                    .withBody(["body1": "value2"])
                    .build()
                return ["request": request,
                    "url": "https://api.com/uu?param1=value1",
                    "method": "PATCH",
                    "body": ["body1": "value2"]]
            })
        }
    }
}