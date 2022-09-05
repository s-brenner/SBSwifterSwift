#if canImport(StoreKit)
import StoreKit

@available(iOS 15, tvOS 15, macOS 12, watchOS 8, *)
extension Product {
    
    public var latestVerifiedTransaction: Transaction? {
        get async { await .latestVerified(for: id) }
    }
    
    public var displaySubscriptionPrice: AttributedString {
        let price = AttributedString(displayPrice)
        guard let subscription = subscription else { return price }
        let period: AttributedString
        if subscription.subscriptionPeriod.value == 1 {
            period = AttributedString(localized: subscription.subscriptionPeriod.unit.localizedStringKey)
        } else {
            period = subscription.subscriptionPeriod.displaySubscriptionPeriod
        }
        return price + .slash + period
    }
    
    public var displaySubscriptionPeriod: AttributedString? {
        subscription?.subscriptionPeriod.displaySubscriptionPeriod
    }
    
    public static func product(for identifier: String) async throws -> Product? {
        try await products(for: [identifier]).first
    }
}

@available(iOS 15, tvOS 15, macOS 12, watchOS 8, *)
extension Product.SubscriptionPeriod {
    
    public var displaySubscriptionPeriod: AttributedString {
        var unit = AttributedString(localized: unit.localizedStringKey)
        var morphology = Morphology()
        morphology.number = value == 1 ? .singular : .plural
        unit.inflect = InflectionRule(morphology: morphology)
        let unitString = unit.inflected()
        let valueString = AttributedString(value.formatted())
        return value == 1 ? unitString : valueString + .space + unitString
    }
}

@available(iOS 15, tvOS 15, macOS 12, watchOS 8, *)
extension Product.SubscriptionPeriod.Unit {
    
    public var localizedStringKey: String.LocalizationValue {
        switch self {
        case .year: return "year"
        case .month: return "month"
        case .week: return "week"
        case .day: return "day"
        @unknown default: return ""
        }
    }
}

@available(iOS 15, tvOS 15, macOS 12, watchOS 8, *)
extension AttributedString {
    
    fileprivate static let space = AttributedString(" ")
    
    fileprivate static let slash = AttributedString("/")
}
#endif
