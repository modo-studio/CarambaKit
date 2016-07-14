# Core

[![CI Status](http://img.shields.io/travis/tulapps/Core.svg?style=flat)](https://travis-ci.org/tulapps/Core)
[![Version](https://img.shields.io/cocoapods/v/Core.svg?style=flat)](http://cocoapods.org/pods/Core)
[![License](https://img.shields.io/cocoapods/l/Core.svg?style=flat)](http://cocoapods.org/pods/Core)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

Core podspec is part of the [Specs]() repository. In order to be recognized by CocoaPods you have to add that repository to your CocoaPods setup:

```
pod repo add tulapps https://github.com/tulapps/Specs
```

To install it, simply add the following line to your Podfile:

```ruby
pod "Core"
pod "Core/Networking"
pod "Core/Persistence"
```

## Core

### Networking

```swift
let request = RequestBuilder(baseUrl: "https://api.apps.com").get("/users").withParameters(["param": "value"]).build()
let client = JsonHttpClient()
client.request(request).subscribeNext { response in
  // :tada:
}
```

## Author

Pedro Piñera Buendía, pepibumur@gmail.com
Sergi Gracia, sergigram@gmail.com
Isaac Roldán, isaac.roldan@gmail.com

## License

Core is available under the MIT license. See the LICENSE file for more info.
