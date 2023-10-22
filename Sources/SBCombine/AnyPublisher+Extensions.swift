extension AnyPublisher {
    
    public static func just(_ output: Output) -> Self {
        Just(output)
            .setFailureType(to: Failure.self)
            .eraseToAnyPublisher()
    }
        
    public static func fail(with error: Failure) -> Self {
        Fail(error: error)
            .eraseToAnyPublisher()
    }
    
    public func async() async throws -> Output {
        try await withCheckedThrowingContinuation { continuation in
            var cancellable: AnyCancellable?
            cancellable = first().sink { result in
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
                cancellable?.cancel()
            } receiveValue: { value in
                continuation.resume(with: .success(value))
            }
        }
    }
}
