import Foundation

extension Result {
    
    public func replaceError(with replacement: Success) -> Success {
        replaceError { _ in replacement }
    }
    
    public func replaceError(_ transform: (Failure) -> Success) -> Success {
        switch self {
        case .success(let success): return success
        case .failure(let error): return transform(error)
        }
    }
    
    public func fatalError(_ transform: (Failure) -> String) -> Success {
        switch self {
        case .success(let success): return success
        case .failure(let error): Swift.fatalError(transform(error))
        }
    }
    
    public func replaceNil<NewSuccess>(with replacement: NewSuccess) -> Result<NewSuccess, Failure> {
        replaceNil { _ in replacement }
    }
    
    public func replaceNil<NewSuccess>(_ transform: (Success?) -> NewSuccess) -> Result<NewSuccess, Failure> {
        map(transform)
    }
}
