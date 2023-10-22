#if os(iOS) || os(macOS) || os(watchOS)
public extension DateComponentsFormatter {
    
    struct Configuration {
        
        private let value: (DateComponentsFormatter) -> Void
        
        /// Configures formatter to return a value like "1d 0h 12m"
        public static let dayHourMinute = Configuration {
            $0.allowedUnits = [.day, .hour, .minute]
            $0.unitsStyle = .abbreviated
            $0.zeroFormattingBehavior = .pad
        }
        
        public init(_ value: @escaping ((DateComponentsFormatter) -> Void)) {
            self.value = value
        }
        
        /// Apply this configuration to a given formatter.
        /// - Parameter formatter: The formatter to configure.
        public func apply(to formatter: DateComponentsFormatter) {
            value(formatter)
        }
    }
    
    /// Returns the local thread shared date components formatter configured as needed.
    /// - Parameter configuration: An optional configuration for the formatter.
    ///- Author: Scott Brenner | SBSwifterSwift
    static func sharedFormatter(
        withConfiguration configuration: Configuration? = nil
    ) -> DateComponentsFormatter {
        let name = "SBSwifterSwift.\(String(describing: DateComponentsFormatter.self))"
        let formatter: DateComponentsFormatter = threadSharedObject(
            key: name,
            create: { DateComponentsFormatter() }
        )
        configuration?.apply(to: formatter)
        return formatter
    }
    
    /// Returns the local thread shared date components formatter configured as needed.
    /// - Parameter configurator: A function that modifies the local thread shared date components formatter.
    ///- Author: Scott Brenner | SBSwifterSwift
    static func sharedFormatter(
        configurator: @escaping ((_ formatter: DateComponentsFormatter) -> Void)
    ) -> DateComponentsFormatter {
        sharedFormatter(withConfiguration: .init(configurator))
    }
}
#endif
