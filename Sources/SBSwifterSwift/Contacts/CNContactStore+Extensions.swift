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
    
    public struct CNContactKey {
        
        fileprivate let value: CNKeyDescriptor
        
        private init(key: String) {
            value = key as CNKeyDescriptor
        }
        
        public static let namePrefix = CNContactKey(key: CNContactNamePrefixKey)
        
        public static let givenName = CNContactKey(key: CNContactGivenNameKey)
        
        public static let middleName = CNContactKey(key: CNContactMiddleNameKey)
        
        public static let familyName = CNContactKey(key: CNContactFamilyNameKey)
        
        public static let previousFamilyName = CNContactKey(key: CNContactPreviousFamilyNameKey)
        
        public static let nameSuffix = CNContactKey(key: CNContactNameSuffixKey)
        
        public static let nickname = CNContactKey(key: CNContactNicknameKey)
        
        public static let organizationName = CNContactKey(key: CNContactOrganizationNameKey)
        
        public static let departmentName = CNContactKey(key: CNContactDepartmentNameKey)
        
        public static let jobTitle = CNContactKey(key: CNContactJobTitleKey)
        
        public static let phoneticGivenName = CNContactKey(key: CNContactPhoneticGivenNameKey)
        
        public static let phoneticMiddleNameKey = CNContactKey(key: CNContactPhoneticMiddleNameKey)
        
        public static let phoneticFamilyName = CNContactKey(key: CNContactPhoneticFamilyNameKey)

        public static let phoneticOrganizationName = CNContactKey(key: CNContactPhoneticOrganizationNameKey)
        
        public static let birthday = CNContactKey(key: CNContactBirthdayKey)
        
        public static let nonGregorianBirthday = CNContactKey(key: CNContactNonGregorianBirthdayKey)
        
        public static let note = CNContactKey(key: CNContactNoteKey)
        
        public static let imageData = CNContactKey(key: CNContactImageDataKey)
        
        public static let thumbnailImageData = CNContactKey(key: CNContactThumbnailImageDataKey)
        
        public static let imageDataAvailable = CNContactKey(key: CNContactImageDataAvailableKey)

        public static let contactType = CNContactKey(key: CNContactTypeKey)
        
        public static let phoneNumbers = CNContactKey(key: CNContactPhoneNumbersKey)
        
        public static let emailAddresses = CNContactKey(key: CNContactEmailAddressesKey)
        
        public static let postalAddresses = CNContactKey(key: CNContactPostalAddressesKey)
        
        public static let dates = CNContactKey(key: CNContactDatesKey)

        public static let urlAddresses = CNContactKey(key: CNContactUrlAddressesKey)

        public static let relations = CNContactKey(key: CNContactRelationsKey)
        
        public static let socialProfiles = CNContactKey(key: CNContactSocialProfilesKey)
        
        public static let instantMessageAddresses = CNContactKey(key: CNContactInstantMessageAddressesKey)
    }
    
    public func containers(matching predicate: CNContainerPredicate?) throws -> [CNContainer] {
        try containers(matching: predicate?.value)
    }
    
    public func groups(matching predicate: CNGroupPredicate?) throws -> [CNGroup] {
        try groups(matching: predicate?.value)
    }
    
    public func unifiedContacts(matching predicate: CNContactPredicate, keysToFetch keys: [CNContactKey]) throws -> [CNContact] {
        try unifiedContacts(matching: predicate.value, keysToFetch: keys.map(\.value))
    }
}
#endif
