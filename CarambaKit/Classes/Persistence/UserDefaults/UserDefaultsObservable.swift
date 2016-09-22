import Foundation
import RxSwift

public class UserDefaultsObservable<T>: NSObject {

    // MARK: - Attributes

    private let userDefaults: UserDefaults
    private let subject: PublishSubject<T?>
    private let key: String

    // MARK: - Init

    public init(key: String, userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
        self.subject = PublishSubject()
        self.key = key
        super.init()
        self.userDefaults.addObserver(self, forKeyPath: key, options: NSKeyValueObservingOptions.new, context: nil)
    }

    // MARK: - Public

    public func rx() -> Observable<T?> {
        return self.subject
    }

    // MARK: - KVO

    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        self.subject.onNext(self.userDefaults.object(forKey: self.key) as? T)
    }

    deinit {
        self.userDefaults.removeObserver(self, forKeyPath: self.key)
    }

}
