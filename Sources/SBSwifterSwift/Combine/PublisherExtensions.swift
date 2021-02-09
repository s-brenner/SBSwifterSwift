#if canImport(Combine)
import Combine

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
        map(Result.success)
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

public extension Publisher where Output: Collection {
    
    func mapEach<T>(
        _ transform: @escaping (Output.Element) -> T
    ) -> AnyPublisher<[T], Failure> {
        map { $0.map(transform) }
            .eraseToAnyPublisher()
    }
    
    func compactMapEach<T>(
        _ transform: @escaping (Output.Element) -> T?
    ) -> AnyPublisher<[T], Failure> {
        map { $0.compactMap(transform) }
            .eraseToAnyPublisher()
    }
    
    func sorted<V>(
        by keyPath: KeyPath<Output.Element, V>,
        ascending: Bool = true
    ) -> AnyPublisher<[Output.Element], Failure>
    where V: Comparable {
        map { $0.sorted(by: keyPath, ascending: ascending) }
            .eraseToAnyPublisher()
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
#endif
