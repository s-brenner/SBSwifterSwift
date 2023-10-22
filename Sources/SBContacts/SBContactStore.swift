#if canImport(Contacts)
import Contacts

/// An asychronous version of CNContactStore.
/// - Author: Scott Brenner | SBSwifterSwift
public struct SBContactStore {
    
    private let store = CNContactStore()
    
    private let queue = OperationQueue.serialQueue(named: "SBContactStore_\(UUID().uuidString)")
    
    public init() { }
    
    public typealias ContactKey = CNContactStore.CNContactKey
    
    public typealias ContactPredicate = CNContactStore.CNContactPredicate
    
    public typealias GroupPredicate = CNContactStore.CNGroupPredicate
}

extension SBContactStore {
    
    public var defaultContainerIdentifier: String { store.defaultContainerIdentifier() }
    
    public var currentHistoryToken: Data? { store.currentHistoryToken }
    
    @discardableResult
    public func requestAccess(for entityType: CNEntityType = .contacts) async throws -> Bool {
        try await store.requestAccess(for: entityType)
    }
    
    public static func authorizationStatus(for entityType: CNEntityType = .contacts) -> CNAuthorizationStatus {
        CNContactStore.authorizationStatus(for: entityType)
    }
    
    public func execute(_ request: CNSaveRequest) async throws {
        try await withCheckedThrowingContinuation { continuation in
            queue.addOperation {
                do {
                    try store.execute(request)
                    continuation.resume()
                }
                catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    public func groups(matching predicate: GroupPredicate? = nil) async throws -> [CNGroup] {
        try await withCheckedThrowingContinuation { continuation in
            queue.addOperation {
                do {
                    let groups = try store.groups(matching: predicate)
                    continuation.resume(returning: groups)
                }
                catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    public func unifiedContact(withIdentifier identifier: String, keysToFetch keys: Set<ContactKey>) async throws -> CNContact {
        try await withCheckedThrowingContinuation { continuation in
            queue.addOperation {
                do {
                    let contact = try store.unifiedContact(withIdentifier: identifier, keysToFetch: keys)
                    continuation.resume(returning: contact)
                }
                catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    public func unifiedContacts(matching predicate: ContactPredicate, keysToFetch keys: Set<ContactKey>) async throws -> [CNContact] {
        try await withCheckedThrowingContinuation { continuation in
            queue.addOperation {
                do {
                    let contacts = try store.unifiedContacts(matching: predicate, keysToFetch: keys)
                    continuation.resume(returning: contacts)
                }
                catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
#endif
