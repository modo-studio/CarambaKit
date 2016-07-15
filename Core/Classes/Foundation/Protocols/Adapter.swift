import Foundation

public class Adapter<I, O> {
    
    // MARK: - Public
    
    public func adapt(input: I) -> O! {
        assertionFailure("This method must be overriden")
        return nil
    }
    
}