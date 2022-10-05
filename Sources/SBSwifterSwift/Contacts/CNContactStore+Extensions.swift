#if canImport(Contacts)
import Contacts

extension CNContactStore {
    
    public struct CNContainerPredicate {
        
        fileprivate let value: NSPredicate
        
        private init(_ predicate: NSPredicate) {
            value = predicate
        }
        
        public static func predicateForContainers(withIdentifiers identifiers: [String]) -> CNContainerPredicate {
            CNContainerPredicate(CNContainer.predicateForContainers(withIdentifiers: identifiers))
        }
        
        public static func predicateForContainerOfGroup(withIdentifier identifier: String) -> CNContainerPredicate {
            CNContainerPredicate(CNContainer.predicateForContainerOfGroup(withIdentifier: identifier))
        }
        
        public static func predicateForContainerOfContact(withIdentifier identifier: String) -> CNContainerPredicate {
            CNContainerPredicate(CNContainer.predicateForContainerOfContact(withIdentifier: identifier))
        }
    }
    
    public struct CNGroupPredicate {
        
        fileprivate let value: NSPredicate
        
        private init(_ predicate: NSPredicate) {
            value = predicate
        }
        
        public static func predicateForGroups(withIdentifiers identifiers: [String]) -> CNGroupPredicate {
            CNGroupPredicate(CNGroup.predicateForGroups(withIdentifiers: identifiers))
        }
        
        public static func predicateForGroupsInContainer(withIdentifier identifier: String) -> CNGroupPredicate {
            CNGroupPredicate(CNGroup.predicateForGroupsInContainer(withIdentifier: identifier))
        }
    }
    
    public struct CNContactPredicate {
        
        fileprivate let value: NSPredicate
        
        private init(_ predicate: NSPredicate) {
            value = predicate
        }
        
        public static func predicateForContacts(matching phoneNumber: CNPhoneNumber) -> CNContactPredicate {
            CNContactPredicate(CNContact.predicateForContacts(matching: phoneNumber))
        }
        
        public static func predicateForContacts(matchingName name: String) -> CNContactPredicate {
            CNContactPredicate(CNContact.predicateForContacts(matchingName: name))
        }
        
        public static func predicateForContacts(withIdentifiers identifiers: [String]) -> CNContactPredicate {
            CNContactPredicate(CNContact.predicateForContacts(withIdentifiers: identifiers))
        }
        
        public static func predicateForContacts(matchingEmailAddress emailAddress: String) -> CNContactPredicate {
            CNContactPredicate(CNContact.predicateForContacts(matchingEmailAddress: emailAddress))
        }
        
        public static func predicateForContactsInGroup(withIdentifier identifier: String) -> CNContactPredicate {
            CNContactPredicate(CNContact.predicateForContactsInGroup(withIdentifier: identifier))
        }
        
        public static func predicateForContactsInContainer(withIdentifier identifier: String) -> CNContactPredicate {
            CNContactPredicate(CNContact.predicateForContactsInContainer(withIdentifier: identifier))
        }
    }
    
    public func containers(matching predicate: CNContainerPredicate?) async throws -> [CNContainer] {
        try await withCheckedThrowingContinuation { continuation in
            DispatchQueue.global(qos: .userInitiated).async { [unowned self] in
                do {
                    let containers = try containers(matching: predicate?.value)
                    continuation.resume(returning: containers)
                }
                catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    public func groups(matching predicate: CNGroupPredicate?) async throws -> [CNGroup] {
        try await withCheckedThrowingContinuation { continuation in
            DispatchQueue.global(qos: .userInitiated).async { [unowned self] in
                do {
                    let groups = try groups(matching: predicate?.value)
                    continuation.resume(returning: groups)
                }
                catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    public func unifiedContacts(matching predicate: CNContactPredicate, keysToFetch keys: [CNKeyDescriptor]) async throws -> [CNContact] {
        try await withCheckedThrowingContinuation { continuation in
            DispatchQueue.global(qos: .userInitiated).async { [unowned self] in
                do {
                    let contacts = try unifiedContacts(matching: predicate.value, keysToFetch: keys)
                    continuation.resume(returning: contacts)
                }
                catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    public func execute(_ request: CNSaveRequest) async throws {
        try await withCheckedThrowingContinuation { continuation in
            DispatchQueue.global(qos: .userInitiated).async { [unowned self] in
                do {
                    try execute(request)
                    continuation.resume()
                }
                catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
#endif
