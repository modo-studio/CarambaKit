# Core

[![CI Status](http://img.shields.io/travis/tulapps/Core.svg?style=flat)](https://travis-ci.org/tulapps/Core)

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

Core is available under the MIT license. See the LICENSE file for more info.
