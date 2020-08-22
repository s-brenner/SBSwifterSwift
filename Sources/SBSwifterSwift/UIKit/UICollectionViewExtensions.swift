#if canImport(UIKit)
import UIKit

@available(iOS 14.0, *)
public extension UICollectionView {
    
    enum SupplementaryViews { }
    
    typealias ListHeaderFooterConfiguration = SupplementaryViews.ListHeaderFooterView.View.ContentConfiguration
    
    typealias ListHeaderFooterRegistration = SupplementaryRegistration<SupplementaryViews.ListHeaderFooterView>
    
    typealias ListCellRegistration<Item> = CellRegistration<UICollectionViewListCell, Item>
}


@available(iOS 14.0, *)
public extension UIListContentConfiguration.TextProperties.TextAlignment {
    
    var textAlignment: NSTextAlignment {
        switch self {
        case .center: return .center
        case .justified: return .justified
        case .natural: return .natural
        @unknown default: fatalError()
        }
    }
}


@available(iOS 14.0, *)
public extension UICollectionView.ListHeaderFooterRegistration {
    
    typealias Style = UICollectionView.SupplementaryViews.ListHeaderFooterView.View.ContentConfiguration.Style
    
    typealias ConfigurationHandler =
        (_ configuration: inout UICollectionView.ListHeaderFooterConfiguration, _ section: Int) -> Void
    
    /// Makes a supplementary registration for a list header or footer.
    /// - Parameters:
    ///   - style: The style of header or footer that you desire.
    ///   - elementKind: If set to `nil` the element kind will be either `UICollectionView.elementKindSectionHeader` or `UICollectionView.elementKindSectionFooter` as determined by the selected style.
    ///   - configurationHandler: A handler that enables you to adjust the default content configuration for a given section.
    init(style: Style, elementKind: String? = nil, configurationHandler: @escaping ConfigurationHandler) {
        self.init(elementKind: elementKind ?? style.elementKind) { view, _, indexPath in
            var contentConfiguration = UICollectionView.ListHeaderFooterConfiguration(style: style)
            configurationHandler(&contentConfiguration, indexPath.section)
            view.contentConfiguration = contentConfiguration
        }
    }
    
    typealias TextHandler = (_ section: Int) -> String?
    
    /// Makes a supplementary registration for a list header or footer.
    /// - Parameters:
    ///   - style: The style of header or footer that you desire.
    ///   - textHandler: A handler that asks for the text for a given section.
    init(style: Style, textHandler: @escaping TextHandler) {
        self.init(elementKind: style.elementKind) { view, _, indexPath in
            view.contentConfiguration = configure(UICollectionView.ListHeaderFooterConfiguration(style: style)) {
                $0.text = textHandler(indexPath.section)
            }
        }
    }
}


@available(iOS 14.0, *)
public extension UICollectionView.SupplementaryViews {
    
    class ListHeaderFooterView: UICollectionViewListCell {
        
        public class View: UIView, UIContentView {
            
            private lazy var label = UILabel()
            
            private var currentConfiguration: ContentConfiguration!
            
            public var configuration: UIContentConfiguration {
                get { currentConfiguration }
                set {
                    guard let newConfiguration = newValue as? ContentConfiguration else { return }
                    apply(configuration: newConfiguration)
                }
            }
            
            init(configuration: ContentConfiguration) {
                super.init(frame: .zero)
                setupViews()
                apply(configuration: configuration)
            }
            
            required init?(coder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
            }
            
            private func setupViews() {
                addSubview(label)
                label.anchor(to: layoutMarginsGuide)
            }
            
            private func apply(configuration: ContentConfiguration) {
                guard currentConfiguration != configuration else { return }
                currentConfiguration = configuration
                label.font = configuration.textProperties.font
                label.textColor = configuration.textProperties.resolvedColor()
                label.textAlignment = configuration.textProperties.alignment.textAlignment
                label.lineBreakMode = configuration.textProperties.lineBreakMode
                label.numberOfLines = configuration.textProperties.numberOfLines
                label.adjustsFontSizeToFitWidth = configuration.textProperties.adjustsFontSizeToFitWidth
                label.minimumScaleFactor = configuration.textProperties.minimumScaleFactor
                label.allowsDefaultTighteningForTruncation = configuration.textProperties.allowsDefaultTighteningForTruncation
                label.adjustsFontForContentSizeCategory = configuration.textProperties.adjustsFontForContentSizeCategory
                label.text = apply(transform: configuration.textProperties.transform, to: configuration.text)
            }
            
            private func apply(
                transform: UIListContentConfiguration.TextProperties.TextTransform,
                to text: String?) -> String? {
                
                switch transform {
                case .none: return text
                case .capitalized: return text?.capitalized
                case .lowercase: return text?.lowercased()
                case .uppercase: return text?.uppercased()
                @unknown default: return text
                }
            }
            
            public struct ContentConfiguration: UIContentConfiguration, Hashable {
                
                public enum Style {
                    case plainHeader, groupedHeader, plainFooter, groupedFooter
                    
                    var configuration: UIListContentConfiguration {
                        switch self {
                        case .plainHeader: return .plainHeader()
                        case .groupedHeader: return .groupedHeader()
                        case .plainFooter: return .plainFooter()
                        case .groupedFooter: return .groupedFooter()
                        }
                    }
                    
                    var elementKind: String {
                        switch self {
                        case .plainHeader, .groupedHeader: return UICollectionView.elementKindSectionHeader
                        case .plainFooter, .groupedFooter: return UICollectionView.elementKindSectionFooter
                        }
                    }
                }
                
                public let style: Style
                
                public var text: String?
                
                public var textProperties: UIListContentConfiguration.TextProperties
                
                public init(style: Style) {
                    self.style = style
                    textProperties = style.configuration.textProperties
                }
                
                public func makeContentView() -> UIView & UIContentView {
                    View(configuration: self)
                }
                
                public func updated(for state: UIConfigurationState) -> Self {
                    self
                }
            }
        }
    }
}
#endif
