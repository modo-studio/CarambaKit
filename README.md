# CarambaKit

[![CI Status](http://img.shields.io/travis/carambalabs/CarambaKit.svg?style=flat)](https://travis-ci.org/carambalabs/CarambaKit)
[![codecov](https://codecov.io/gh/carambalabs/CarambaKit/branch/master/graph/badge.svg)](https://codecov.io/gh/carambalabs/CarambaKit)
[![Dependency Status](https://gemnasium.com/badges/github.com/carambalabs/CarambaKit.svg)](https://gemnasium.com/github.com/carambalabs/CarambaKit)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

To install it, simply add the following line to your Podfile:

```ruby
pod "CarambaKit"
```

## CarambaKit

### Networking

```swift
let request = RequestBuilder(baseUrl: "https://api.apps.com").get("/users").withParameters(["param": "value"]).build()
let client = JsonHttpClient()
client.request(request).subscribeNext { response in
  // :tada:
}
```

### SessionRepository

Fetch, store, and clear a session from the Keychain:

```swift
let repository = SessionRepository(name: "idonethis")
let session = repository.fetch()
```

## About

<img src="https://github.com/carambalabs/Foundation/blob/master/ASSETS/avatar_rounded.png?raw=true" width="70" />

This project is funded and maintained by [Caramba](http://caramba.io). We 💛 open source software!

Check out our other [open source projects](https://github.com/carambalabs/), read our [blog](http://blog.caramba.io) or say :wave: on twitter [@carambalabs](http://twitter.com/carambalabs).

## Contribute

Contributions are welcome :metal: We encourage developers like you to help us improve the projects we've shared with the community. Please see the [Contributing Guide](https://github.com/carambalabs/Foundation/blob/master/CONTRIBUTING.md) and the [Code of Conduct](https://github.com/carambalabs/Foundation/blob/master/CONDUCT.md).

## License

CarambaKit is available under the MIT license. See the LICENSE file for more info.
