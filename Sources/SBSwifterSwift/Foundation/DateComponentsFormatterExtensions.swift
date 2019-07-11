import Foundation

extension DateComponentsFormatter {
    
    // MARK: - Types
    
    public struct Configuration {

        // MARK: - Properties

        private let value: (DateComponentsFormatter) -> Void

        /// Configures formatter to return a value like "1d 0h 12m"
        public static let dayHourMinute = Configuration({
            $0.allowedUnits = [.day, .hour, .minute]
            $0.unitsStyle = .abbreviated
            $0.zeroFormattingBehavior = .pad
        })


        // MARK: - Initializers

        public init(_ value: @escaping ((DateComponentsFormatter) -> Void)) {
            self.value = value
        }


        // MARK: - Methods

        /// Apply this configuration to a given formatter.
        /// - Parameter formatter: The formatter to configure.
        public func apply(to formatter: DateComponentsFormatter) {
            value(formatter)
        }
    }
    
    
    // MARK: - Methods
    
    /// Returns the local thread shared date components formatter configured as needed.
    /// - Parameter configuration: An optional configuration for the formatter.
    public static func sharedFormatter(withConfiguration configuration: Configuration? = nil) -> DateComponentsFormatter {
        let name = "SBSwifterSwift.\(String(describing: DateComponentsFormatter.self))"
        let formatter: DateComponentsFormatter = threadSharedObject(key: name, create: { return DateComponentsFormatter() })
        configuration?.apply(to: formatter)
        return formatter
    }
}
