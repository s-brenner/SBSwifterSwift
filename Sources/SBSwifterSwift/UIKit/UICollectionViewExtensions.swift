#if canImport(UIKit) && os(iOS)
import UIKit

extension UICollectionView {
    
    @available(iOS 14.0, *)
    public enum SupplementaryViews { }
    
    @available(iOS 14.0, *)
    public enum Cells { }
    
    @available(iOS 14.0, *)
    public typealias ListHeaderFooterConfiguration = SupplementaryViews.ListHeaderFooterView.View.ContentConfiguration
    
    @available(iOS 14.0, *)
    public typealias ListHeaderFooterRegistration = SupplementaryRegistration<SupplementaryViews.ListHeaderFooterView>
    
    @available(iOS 14.0, *)
    public typealias ListCellRegistration<Item> = CellRegistration<UICollectionViewListCell, Item>
    
    @available(iOS 14.0, *)
    public typealias TextFieldCellRegistration<Item> = CellRegistration<Cells.TextFieldCell, Item>
}


// MARK: - List Header / Footer

@available(iOS 14.0, *)
extension UICollectionView.ListHeaderFooterRegistration {
    
    
    public typealias Style = UICollectionView.SupplementaryViews.ListHeaderFooterView.View.ContentConfiguration.Style
    
    public typealias ConfigurationHandler =
        (_ configuration: inout UICollectionView.ListHeaderFooterConfiguration, _ section: Int) -> Void
    
    /// Makes a supplementary registration for a list header or footer.
    /// - Parameters:
    ///   - style: The style of header or footer that you desire.
    ///   - elementKind: If set to `nil` the element kind will be either `UICollectionView.elementKindSectionHeader` or `UICollectionView.elementKindSectionFooter` as determined by the selected style.
    ///   - configurationHandler: A handler that enables you to adjust the default content configuration for a given section.
    public init(style: Style, elementKind: String? = nil, configurationHandler: @escaping ConfigurationHandler) {
        self.init(elementKind: elementKind ?? style.elementKind) { view, _, indexPath in
            var contentConfiguration = UICollectionView.ListHeaderFooterConfiguration(style: style)
            configurationHandler(&contentConfiguration, indexPath.section)
            view.contentConfiguration = contentConfiguration
        }
    }
    
    public typealias TextHandler = (_ section: Int) -> String?
    
    /// Makes a supplementary registration for a list header or footer.
    /// - Parameters:
    ///   - style: The style of header or footer that you desire.
    ///   - textHandler: A handler that asks for the text for a given section.
    public init(style: Style, textHandler: @escaping TextHandler) {
        self.init(elementKind: style.elementKind) { view, _, indexPath in
            view.contentConfiguration = configure(UICollectionView.ListHeaderFooterConfiguration(style: style)) {
                $0.text = textHandler(indexPath.section)
            }
        }
    }
}

@available(iOS 14.0, *)
extension UICollectionView.SupplementaryViews {
    
    public class ListHeaderFooterView: UICollectionViewListCell {
        
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
extension UIListContentConfiguration.TextProperties {
    
    public func transform(text: String?) -> String? {
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
extension UIListContentConfiguration.TextProperties.TextAlignment {
    
    public var textAlignment: NSTextAlignment {
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
private typealias TextFieldCell = UICollectionView.Cells.TextFieldCell

@available(iOS 14.0, *)
extension UICollectionView.Cells {
    
    public class TextFieldCell: UICollectionViewListCell {
        
        private var text = ""
        
        private var textFieldProperties = UIListContentConfiguration.TextFieldProperties.default
        
        private var view = View(configuration: .init())
        
        public typealias TextFieldPropertiesConfiguration =
            (inout UIListContentConfiguration.TextFieldProperties) -> Void
        
        public func update(text: String, handler: TextFieldPropertiesConfiguration? = nil) {
            self.text = text
            textFieldProperties = configure(.default) { handler?(&$0) }
            setNeedsUpdateConfiguration()
        }
        
        public override func updateConfiguration(using state: UICellConfigurationState) {
            setupViewIfNeeded()
            view.configuration = configure(View.ContentConfiguration().updated(for: state)) {
                $0.text = text
                $0.textFieldProperties = textFieldProperties
            }
        }
        
        private func setupViewIfNeeded() {
            guard !contentView.subviews.contains(view) else { return }
            contentView.addSubview(view)
            view.anchor(to: contentView.layoutMarginsGuide, topConstant: 3, bottomConstant: 3)
        }
        
        @discardableResult
        public override func becomeFirstResponder() -> Bool {
            view.becomeFirstResponder()
        }
        
        @discardableResult
        public override func resignFirstResponder() -> Bool {
            view.resignFirstResponder()
        }
        
        public var textDidBeginEditingPublisher: AnyPublisher<String, Never> {
            view.textFieldDidBeginEditingSubject.eraseToAnyPublisher()
        }
        
        public var textDidChangePublisher: AnyPublisher<String, Never> {
            view.textFieldDidChangeSelectionSubject.eraseToAnyPublisher()
        }
        
        public typealias CharacterLimit = UIListContentConfiguration.TextFieldProperties.CharacterLimit
        public var textLimitedPublisher: AnyPublisher<CharacterLimit, Never> {
            view.textLimitedSubject.eraseToAnyPublisher()
        }
        
        public typealias DidEndEditing = (text: String, reason: UITextField.DidEndEditingReason)
        public var textDidEndEditingPublisher: AnyPublisher<DidEndEditing, Never> {
            view.textFieldDidEndEditingSubject.eraseToAnyPublisher()
        }
    }
}

@available(iOS 14.0, *)
private extension TextFieldCell {
    
    class View: UIView, UIContentView, UITextFieldDelegate {
        
        private lazy var storage = Set<AnyCancellable>()
        
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

        @available(*, unavailable)
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
            
            func makeContentView() -> UIView & UIContentView {
                View(configuration: self)
            }
            
            func updated(for state: UIConfigurationState) -> Self {
                self
            }
        }
        
        let textFieldDidBeginEditingSubject = PassthroughSubject<String, Never>()
        
        let textLimitedSubject = PassthroughSubject<TextFieldCell.CharacterLimit, Never>()
        
        let textFieldDidChangeSelectionSubject = PassthroughSubject<String, Never>()
        
        let textFieldDidEndEditingSubject = PassthroughSubject<TextFieldCell.DidEndEditing, Never>()
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            textFieldDidBeginEditingSubject.send(textField.text ?? "")
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
            if !shouldChangeCharacters {
                textLimitedSubject.send(characterLimit)
            }
            return shouldChangeCharacters
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            textFieldDidChangeSelectionSubject.send(textField.text ?? "")
        }
        
        func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
            textFieldDidEndEditingSubject.send((textField.text ?? "", reason))
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            guard let text = textField.text else { return false }
            let returnsWhenEmpty = currentConfiguration.textFieldProperties.returnsWhenEmpty
            return text.isEmpty && !returnsWhenEmpty ? false : resignFirstResponder()
        }
    }
}

@available(iOS 14.0, *)
extension UIListContentConfiguration {
    
    public struct TextFieldProperties: Hashable {
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
