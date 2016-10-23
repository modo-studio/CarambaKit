import Foundation

open class Adapter<I, O> {

    // MARK: - Public

    public init() {}

    open func adapt(_ input: I) -> O! {
        assertionFailure("This method must be overriden")
        return nil
    }

}
