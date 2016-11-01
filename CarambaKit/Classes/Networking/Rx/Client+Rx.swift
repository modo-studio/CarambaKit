import Foundation
import RxSwift

public extension HttpClient {
    
    public func rx_request(request: URLRequest) -> Observable<T> {
        return Observable.create({ (observer) -> Disposable in
            self.request(request: request) { (result) in
                if let value = result.value {
                    observer.onNext(value)
                    observer.onCompleted()
                } else if let error = result.error {
                    observer.onError(error)
                }
            }
            return Disposables.create()
        })
    }
    
}
