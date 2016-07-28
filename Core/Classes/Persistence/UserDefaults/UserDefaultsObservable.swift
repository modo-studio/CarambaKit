import Foundation
import RxSwift

public class UserDefaultsObservable<T>: NSObject {

    // MARK: - Attributes

    private let userDefaults: NSUserDefaults
    private let subject: PublishSubject<T?>
    private let key: String

    // MARK: - Init

    public init(key: String, userDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()) {
        self.userDefaults = userDefaults
        self.subject = PublishSubject()
        self.key = key
        super.init()
        self.userDefaults.addObserver(self, forKeyPath: key, options: NSKeyValueObservingOptions.New, context: nil)
    }

    // MARK: - Public

    public func rx() -> Observable<T?> {
        return self.subject
    }

    // MARK: - KVO

    override public func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        self.subject.onNext(self.userDefaults.objectForKey(self.key) as? T)
    }

    deinit {
        self.userDefaults.removeObserver(self, forKeyPath: self.key)
    }

}
