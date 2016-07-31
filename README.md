# Core

[![CI Status](http://img.shields.io/travis/carambastudio/CarambaKit.svg?style=flat)](https://travis-ci.org/carambastudio/CarambaKit)
[![codecov](https://codecov.io/gh/carambastudio/CarambaKit/branch/master/graph/badge.svg)](https://codecov.io/gh/carambastudio/CarambaKit)


## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

CarambaKit podspec is part of the [Specs]() repository. In order to be recognized by CocoaPods you have to add that repository to your CocoaPods setup:

```
pod repo add carambastudio https://github.com/carambastudio/Specs
```

To install it, simply add the following line to your Podfile:

```ruby
pod "CarambaKit"
pod "CarambaKit/Networking"
pod "CarambaKit/Persistence"
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

### Oauth2

1. Create an entity that conforms the protocol `Oauth2Entity` implementing the required methods.
2. Create an instance of the handler passing the defined entity and the delegate of the handler.
3. Connect the `Webview` delegate with the handler using the method `shouldRedirectUrl`.
4. Call `start` on the handler to start the Oauth2 flow.
5. :tada:

### SessionRepository

Fetch, store, and clear a session from the Keychain:

```swift
let repository = SessionRepository(name: "idonethis")
let session = repository.fetch()
```

### Persistence

#### UserDefaultsObservable

`UserDefaultsObservable` allows you to observe changes in the user defauls under a given key.

1. Create an instance of the observable passing the key you're insterented in.
2. Hold a reference to that observable, otherwise the subscription will be removed.
3. Get the Rx observable and subscribe to it.

```swift
self.observable = UserDefaultsObservable(key: "user")
self.observable.rx().subscribeNext { newValue in
  print("New value: \(newValue)")
}
```


## Author

- Pedro Piñera Buendía, pepibumur@gmail.com
- Sergi Gracia, sergigram@gmail.com
- Isaac Roldán, isaac.roldan@gmail.com

## License

CarambaKit is available under the MIT license. See the LICENSE file for more info.
