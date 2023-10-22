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
    
    public struct CNContactKey: Hashable, CaseIterable {
        
        private let key: String
        
        private init(_ key: String) {
            self.key = key
        }
        
        fileprivate var value: CNKeyDescriptor { key as CNKeyDescriptor }
        
        public static let namePrefix = CNContactKey(CNContactNamePrefixKey)
        
        public static let givenName = CNContactKey(CNContactGivenNameKey)
        
        public static let middleName = CNContactKey(CNContactMiddleNameKey)
        
        public static let familyName = CNContactKey(CNContactFamilyNameKey)
        
        public static let previousFamilyName = CNContactKey(CNContactPreviousFamilyNameKey)
        
        public static let nameSuffix = CNContactKey(CNContactNameSuffixKey)
        
        public static let nickname = CNContactKey(CNContactNicknameKey)
        
        public static let organizationName = CNContactKey(CNContactOrganizationNameKey)
        
        public static let departmentName = CNContactKey(CNContactDepartmentNameKey)
        
        public static let jobTitle = CNContactKey(CNContactJobTitleKey)
        
        public static let phoneticGivenName = CNContactKey(CNContactPhoneticGivenNameKey)
        
        public static let phoneticMiddleNameKey = CNContactKey(CNContactPhoneticMiddleNameKey)
        
        public static let phoneticFamilyName = CNContactKey(CNContactPhoneticFamilyNameKey)

        public static let phoneticOrganizationName = CNContactKey(CNContactPhoneticOrganizationNameKey)
        
        public static let birthday = CNContactKey(CNContactBirthdayKey)
        
        public static let nonGregorianBirthday = CNContactKey(CNContactNonGregorianBirthdayKey)
        
        public static let note = CNContactKey(CNContactNoteKey)
        
        public static let imageData = CNContactKey(CNContactImageDataKey)
        
        public static let thumbnailImageData = CNContactKey(CNContactThumbnailImageDataKey)
        
        public static let imageDataAvailable = CNContactKey(CNContactImageDataAvailableKey)

        public static let contactType = CNContactKey(CNContactTypeKey)
        
        public static let phoneNumbers = CNContactKey(CNContactPhoneNumbersKey)
        
        public static let emailAddresses = CNContactKey(CNContactEmailAddressesKey)
        
        public static let postalAddresses = CNContactKey(CNContactPostalAddressesKey)
        
        public static let dates = CNContactKey(CNContactDatesKey)

        public static let urlAddresses = CNContactKey(CNContactUrlAddressesKey)

        public static let relations = CNContactKey(CNContactRelationsKey)
        
        public static let socialProfiles = CNContactKey(CNContactSocialProfilesKey)
        
        public static let instantMessageAddresses = CNContactKey(CNContactInstantMessageAddressesKey)
        
        public static let allCases: [CNContactStore.CNContactKey] = [
            .namePrefix,
            .givenName,
            .middleName,
            .familyName,
            .previousFamilyName,
            .nameSuffix,
            .nickname,
            .organizationName,
            .departmentName,
            .jobTitle,
            .phoneticGivenName,
            .phoneticMiddleNameKey,
            .phoneticFamilyName,
            .phoneticOrganizationName,
            .birthday,
            .nonGregorianBirthday,
            .note,
            .imageData,
            .thumbnailImageData,
            .imageDataAvailable,
            .contactType,
            .phoneNumbers,
            .emailAddresses,
            .postalAddresses,
            .dates,
            .urlAddresses,
            .relations,
            .socialProfiles,
            .instantMessageAddresses,
        ]
    }
    
    public func containers(matching predicate: CNContainerPredicate?) throws -> [CNContainer] {
        try containers(matching: predicate?.value)
    }
    
    public func groups(matching predicate: CNGroupPredicate?) throws -> [CNGroup] {
        try groups(matching: predicate?.value)
    }
    
    public func unifiedContact(withIdentifier identifier: String, keysToFetch keys: Set<CNContactKey>) throws -> CNContact {
        try unifiedContact(withIdentifier: identifier, keysToFetch: keys.map(\.value))
    }
    
    public func unifiedContacts(matching predicate: CNContactPredicate, keysToFetch keys: Set<CNContactKey>) throws -> [CNContact] {
        try unifiedContacts(matching: predicate.value, keysToFetch: keys.map(\.value))
    }
}
#endif
