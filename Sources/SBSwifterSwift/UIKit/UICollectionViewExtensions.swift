#if canImport(UIKit)
import UIKit

@available(iOS 14.0, *)
public extension UICollectionView {
    
    enum SupplementaryViews { }
    
    enum Cells { }
    
    typealias ListHeaderFooterConfiguration = SupplementaryViews.ListHeaderFooterView.View.ContentConfiguration
    
    typealias ListHeaderFooterRegistration = SupplementaryRegistration<SupplementaryViews.ListHeaderFooterView>
    
    typealias ListCellRegistration<Item> = CellRegistration<UICollectionViewListCell, Item>
}


// MARK: - List Header / Footer

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
                label.text = configuration.textProperties.transform(text: configuration.text)
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

@available(iOS 14.0, *)
public extension UIListContentConfiguration.TextProperties {
    
    func transform(text: String?) -> String? {
        switch transform {
        case .none: return text
        case .capitalized: return text?.capitalized
        case .lowercase: return text?.lowercased()
        case .uppercase: return text?.uppercased()
        @unknown default: return text
        }
    }
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


// MARK: - Text Field Cell

@available(iOS 14.0, *)
public extension UICollectionView.Cells {
    
    class TextFieldCell<Item: Hashable>: UICollectionViewListCell {
        
        public typealias Registration = UICollectionView.CellRegistration<TextFieldCell<Item>, Item>
        
        private var text = ""
        
        private var textFieldProperties = UIListContentConfiguration.TextFieldProperties.default
        
        /// This value is necessary to access this cell's publishers.
        /// Use the item value in the diffable data source.
        private var item: Item!
        
        private var view: View!
        
        public func update(
            text: String,
            item: Item,
            textFieldProperties: UIListContentConfiguration.TextFieldProperties = .default) {
            
            self.text = text
            self.item = item
            self.textFieldProperties = textFieldProperties
            setNeedsUpdateConfiguration()
        }
        
        public override func updateConfiguration(using state: UICellConfigurationState) {
            let content =  configure(View.ContentConfiguration().updated(for: state)) {
                $0.text = text
                $0.textFieldProperties = textFieldProperties
                $0.item = item
            }
            if view == nil {
                view = View(configuration: content)
                let x = UILabel()
                contentView.addSubview(x)
                x.anchor(to: contentView.layoutMarginsGuide)
//                contentView.addSubview(view)
//                view.anchor(to: contentView.layoutMarginsGuide)
            }
            else {
                view.configuration = content
            }
        }
        
        @discardableResult
        public override func becomeFirstResponder() -> Bool {
            view.becomeFirstResponder()
        }
        
        @discardableResult
        public override func resignFirstResponder() -> Bool {
            view.resignFirstResponder()
        }
        
        private enum Notifications {
            
            static func name(_ name: String) -> Notification.Name {
                Notification.Name("UICollectionView.Cells.TextFieldCell." + name)
            }
            
            enum TextDidBeginEditing {
                static var name: Notification.Name { Notifications.name("textDidBeginEditing") }
                struct Object {
                    let item: Item
                    let text: String
                }
            }
            
            enum TextDidChange {
                static var name: Notification.Name { Notifications.name("textDidChange") }
                struct Object {
                    let item: Item
                    let text: String
                }
            }
            
            enum TextLimited {
                static var name: Notification.Name { Notifications.name("textLimited") }
                struct Object {
                    let item: Item
                    let limit: UIListContentConfiguration.TextFieldProperties.CharacterLimit
                }
            }
            
            enum TextDidEndEditing {
                static var name: Notification.Name { Notifications.name("textDidEndEditing") }
                struct Object {
                    let item: Item
                    let text: String
                    let reason: UITextField.DidEndEditingReason
                }
            }
        }
        
        public static func textDidBeginEditingPublisher(item: Item) -> AnyPublisher<String, Never> {
            NotificationCenter.default.publisher(for: Notifications.TextDidBeginEditing.name)
                .compactMap { $0.object as? Notifications.TextDidBeginEditing.Object }
                .compactMap { $0.item == item ? $0.text : nil }
                .eraseToAnyPublisher()
        }
        
        public static func textDidChangePublisher(item: Item) -> AnyPublisher<String, Never> {
            NotificationCenter.default.publisher(for: Notifications.TextDidChange.name)
                .compactMap { $0.object as? Notifications.TextDidChange.Object }
                .compactMap { $0.item == item ? $0.text : nil }
                .eraseToAnyPublisher()
        }
        
        public static func textLimitedPublisher(item: Item) -> AnyPublisher<UIListContentConfiguration.TextFieldProperties.CharacterLimit, Never> {
            NotificationCenter.default.publisher(for: Notifications.TextLimited.name)
                .compactMap { $0.object as? Notifications.TextLimited.Object }
                .compactMap { $0.item == item ? $0.limit : nil }
                .eraseToAnyPublisher()
        }
        
        public static func textDidEndEditingPublisher(item: Item) -> AnyPublisher<(text: String, reason: UITextField.DidEndEditingReason), Never> {
            NotificationCenter.default.publisher(for: Notifications.TextDidEndEditing.name)
                .compactMap { $0.object as? Notifications.TextDidEndEditing.Object }
                .compactMap { $0.item == item ? ($0.text, $0.reason) : nil }
                .eraseToAnyPublisher()
        }
    }
}

@available(iOS 14.0, *)
private extension UICollectionView.Cells.TextFieldCell {
    
    class View: UIView, UIContentView, UITextFieldDelegate {
        
        private lazy var storage = Set<AnyCancellable>()
        
        private var item: Item?
        
        private lazy var textField = configure(UITextField()) { [weak self] in
            $0.delegate = self
            $0.sizeToFit()
        }
        
        private var currentConfiguration: ContentConfiguration!
        
        var configuration: UIContentConfiguration {
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
            isOpaque = true
            addSubview(textField)
            textField.anchor(to: self)
        }
        
        private func apply(configuration: ContentConfiguration) {
            guard currentConfiguration != configuration else { return }
            currentConfiguration = configuration
            item = configuration.item
            textField.text = configuration.text
            textField.textColor  = configuration.textFieldProperties.textColor
            textField.font = configuration.textFieldProperties.font
            textField.textAlignment = configuration.textFieldProperties.textAlignment
            textField.placeholder = configuration.textFieldProperties.placeholder
            textField.borderStyle = configuration.textFieldProperties.borderStyle
            textField.clearButtonMode = configuration.textFieldProperties.clearButtonMode
            textField.minimumFontSize = configuration.textFieldProperties.minimumFontSize
            textField.autocapitalizationType = configuration.textFieldProperties.autocapitalizationType
            textField.autocorrectionType = configuration.textFieldProperties.autocorrectionType
            textField.spellCheckingType = configuration.textFieldProperties.spellCheckingType
            textField.keyboardType = configuration.textFieldProperties.keyboardType
            textField.keyboardAppearance = configuration.textFieldProperties.keyboardAppearance
            textField.returnKeyType = configuration.textFieldProperties.returnKeyType
            textField.adjustsFontSizeToFitWidth = configuration.textFieldProperties.adjustsFontSizeToFitWidth
            textField.adjustsFontForContentSizeCategory = configuration.textFieldProperties.adjustsFontForContentSizeCategory
            textField.clearsOnBeginEditing = configuration.textFieldProperties.clearsOnBeginEditing
            textField.clearsOnInsertion = configuration.textFieldProperties.clearsOnInsertion
        }
        
        override var isFirstResponder: Bool { textField.isFirstResponder }
        
        override func becomeFirstResponder() -> Bool {
            textField.becomeFirstResponder()
        }
        
        override func resignFirstResponder() -> Bool {
            textField.resignFirstResponder()
        }
        
        struct ContentConfiguration: UIContentConfiguration, Hashable {
            
            var text = ""
            
            var textFieldProperties = UIListContentConfiguration.TextFieldProperties.default
            
            var item: Item?
            
            func makeContentView() -> UIView & UIContentView {
                View(configuration: self)
            }
            
            func updated(for state: UIConfigurationState) -> Self {
                self
            }
        }
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            guard let item = item else { return }
            typealias TextDidBeginEditing = UICollectionView.Cells.TextFieldCell<Item>.Notifications.TextDidBeginEditing
            let object = TextDidBeginEditing.Object(item: item, text: textField.text ?? "")
            NotificationCenter.default.post(name: TextDidBeginEditing.name, object: object)
        }
        
        func textField(
            _ textField: UITextField,
            shouldChangeCharactersIn range: NSRange,
            replacementString string: String) -> Bool {
            
            let characterLimit = currentConfiguration.textFieldProperties.characterLimit
            guard case .limitedTo(let limit) = characterLimit, limit.isPositive else { return true }
            let textCount = textField.text?.count ?? 0
            let newLength = textCount + string.count - range.length
            let shouldChangeCharacters = newLength <= limit
            if !shouldChangeCharacters, let item = item {
                typealias TextLimited = UICollectionView.Cells.TextFieldCell<Item>.Notifications.TextLimited
                let object = TextLimited.Object(item: item, limit: characterLimit)
                NotificationCenter.default.post(name: TextLimited.name, object: object)
            }
            return shouldChangeCharacters
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            guard let item = item else { return }
            typealias TextDidChange = UICollectionView.Cells.TextFieldCell<Item>.Notifications.TextDidChange
            let object = TextDidChange.Object(item: item, text: textField.text ?? "")
            NotificationCenter.default.post(name: TextDidChange.name, object: object)
        }
        
        func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
            guard let item = item else { return }
            typealias TextDidEndEditing = UICollectionView.Cells.TextFieldCell<Item>.Notifications.TextDidEndEditing
            let object = TextDidEndEditing.Object(item: item, text: textField.text ?? "", reason: reason)
            NotificationCenter.default.post(name: TextDidEndEditing.name, object: object)
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            guard let text = textField.text else { return false }
            let returnsWhenEmpty = currentConfiguration.textFieldProperties.returnsWhenEmpty
            return text.isEmpty && !returnsWhenEmpty ? false : resignFirstResponder()
        }
    }
}

@available(iOS 14.0, *)
public extension UIListContentConfiguration {
    
    struct TextFieldProperties: Hashable {
        public var textColor: UIColor
        public var font: UIFont
        public var textAlignment: NSTextAlignment
        public var placeholder: String?
        public var borderStyle: UITextField.BorderStyle
        public var clearButtonMode: UITextField.ViewMode
        public var minimumFontSize: CGFloat
        public var autocapitalizationType: UITextAutocapitalizationType
        public var autocorrectionType: UITextAutocorrectionType
        public var spellCheckingType: UITextSpellCheckingType
        public var keyboardType: UIKeyboardType
        public var keyboardAppearance: UIKeyboardAppearance
        public var returnKeyType: UIReturnKeyType
        public var adjustsFontSizeToFitWidth: Bool
        public var adjustsFontForContentSizeCategory: Bool
        public var clearsOnBeginEditing: Bool
        public var clearsOnInsertion: Bool
        public var returnsWhenEmpty: Bool
        public var characterLimit: CharacterLimit
        
        public enum CharacterLimit: Hashable {
            case unlimited
            case limitedTo(Int)
        }
        
        private init() {
            let textField = UITextField()
            textColor  = textField.textColor ?? .label
            font = textField.font ?? .preferredFont(forTextStyle: .body)
            textAlignment = textField.textAlignment
            placeholder = textField.placeholder
            borderStyle = textField.borderStyle
            clearButtonMode = textField.clearButtonMode
            minimumFontSize = textField.minimumFontSize
            autocapitalizationType = textField.autocapitalizationType
            autocorrectionType = textField.autocorrectionType
            spellCheckingType = textField.spellCheckingType
            keyboardType = textField.keyboardType
            keyboardAppearance = textField.keyboardAppearance
            returnKeyType = textField.returnKeyType
            adjustsFontSizeToFitWidth = textField.adjustsFontSizeToFitWidth
            adjustsFontForContentSizeCategory = textField.adjustsFontForContentSizeCategory
            clearsOnBeginEditing = textField.clearsOnBeginEditing
            clearsOnInsertion = textField.clearsOnInsertion
            returnsWhenEmpty = true
            characterLimit = .unlimited
        }
        
        public static let `default` = TextFieldProperties()
    }
}
#endif
