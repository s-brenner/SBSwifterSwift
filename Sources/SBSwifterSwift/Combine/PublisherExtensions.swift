import Combine
import Foundation

public extension Publisher where Self.Failure == Never {
    
    func assignWithoutRetain<Root: AnyObject>(
        to keyPath: ReferenceWritableKeyPath<Root, Self.Output>,
        on object: Root
    ) -> AnyCancellable {
        
        sink { [weak object] value in
            object?[keyPath: keyPath] = value
        }
    }
}

public extension Publisher {
    
    func convertToResult() -> AnyPublisher<Result<Output, Failure>, Never> {
        self.map(Result.success)
            .catch { Just(.failure($0)) }
            .eraseToAnyPublisher()
    }
    
    func unwrap<T>(
        orThrow error: @escaping @autoclosure () -> Failure
    ) -> Publishers.TryMap<Self, T> where Output == Optional<T> {
        tryMap { output in
            switch output {
            case .some(let value):
                return value
            case nil:
                throw error()
            }
        }
    }
    
    func validate(
        using validator: @escaping (Output) throws -> Void
    ) -> Publishers.TryMap<Self, Output> {
        tryMap { output in
            try validator(output)
            return output
        }
    }
}

//public extension Publisher where Output == Data {
//
//    func decode<T: Decodable>(
//        as type: T.Type = T.self,
//        using decoder: JSONDecoder = .init()
//    ) -> Publishers.Decode<Self, T, JSONDecoder> {
//        decode(type: type, decoder: decoder)
//    }
//}
