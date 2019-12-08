#if canImport(UIKit) && !os(watchOS)
import UIKit

extension UIView {
    
    // MARK: - Types
    
    /// Shake directions of a view.
    ///
    /// - horizontal: Shake left and right.
    /// - vertical: Shake up and down.
    public enum ShakeDirection {
        
        /// Shake left and right.
        case horizontal
        
        /// Shake up and down.
        case vertical
    }
    
    /// Angle units.
    ///
    /// - degrees: degrees.
    /// - radians: radians.
    public enum AngleUnit {
    
        case degrees
        case radians
    }
    
    /// Shake animations types.
    ///
    /// - linear: linear animation.
    /// - easeIn: easeIn animation.
    /// - easeOut: easeOut animation.
    /// - easeInOut: easeInOut animation.
    public enum ShakeAnimationType {
        
        /// linear animation.
        case linear
        
        /// easeIn animation.
        case easeIn
        
        /// easeOut animation.
        case easeOut
        
        /// easeInOut animation.
        case easeInOut
    }
    
    
    // MARK: - Properties
    
    /// Border color of view; also inspectable from Storyboard.
    @IBInspectable public var borderColor: UIColor? {
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            guard let color = newValue else {
                layer.borderColor = nil
                return
            }
            // Fix React-Native conflict issue
            guard String(describing: type(of: color)) != "__NSCFType" else { return }
            layer.borderColor = color.cgColor
        }
    }
    
    /// Border width of view; also inspectable from Storyboard.
    @IBInspectable public var borderWidth: CGFloat {
        get { layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    /// SwifterSwift: Corner radius of view; also inspectable from Storyboard.
    @IBInspectable public var cornerRadius: CGFloat {
        get { layer.cornerRadius }
        set {
            layer.masksToBounds = true
            layer.cornerRadius = ((newValue * 100).int.cgFloat / 100).abs
        }
    }
    
    /// Recursively find the first responder.
    public var firstResponder: UIView? {
        var views = [UIView](arrayLiteral: self)
        var index = 0
        repeat {
            let view = views[index]
            if view.isFirstResponder {
                return view
            }
            views.append(contentsOf: view.subviews)
            index += 1
        } while index < views.count
        return nil
    }
    
    /// Height of view.
    public var height: CGFloat {
        get { frame.size.height }
        set { frame.size.height = newValue }
    }
    
    /// Check if view is in Right-To-Left format.
    public var isRightToLeft: Bool {
        if #available(iOS 10.0, *, tvOS 10.0, *) {
            return effectiveUserInterfaceLayoutDirection == .rightToLeft
        }
        return false
    }
    
    /// Take a screenshot of view (if applicable).
    public var screenshot: UIImage? {
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, 0)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        layer.render(in: context)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    /// Shadow color of view; also inspectable from Storyboard.
    @IBInspectable public var shadowColor: UIColor? {
        get {
            guard let color = layer.shadowColor else { return nil }
            return UIColor(cgColor: color)
        }
        set { layer.shadowColor = newValue?.cgColor }
    }
    
    /// Shadow offset of view; also inspectable from Storyboard.
    @IBInspectable public var shadowOffset: CGSize {
        get { layer.shadowOffset }
        set { layer.shadowOffset = newValue }
    }
    
    /// Shadow opacity of view; also inspectable from Storyboard.
    @IBInspectable public var shadowOpacity: Float {
        get { layer.shadowOpacity }
        set { layer.shadowOpacity = newValue }
    }
    
    /// Shadow radius of view; also inspectable from Storyboard.
    @IBInspectable public var shadowRadius: CGFloat {
        get { layer.shadowRadius }
        set { layer.shadowRadius = newValue }
    }
    
    /// Size of view.
    public var size: CGSize {
        get { frame.size }
        set {
            width = newValue.width
            height = newValue.height
        }
    }
    
    /// Get view's parent view controller
    public var parentViewController: UIViewController? {
        weak var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
    /// Width of view.
    public var width: CGFloat {
        get { frame.size.width }
        set { frame.size.width = newValue }
    }
    
    /// x origin of view.
    public var x: CGFloat {
        get { frame.origin.x }
        set { frame.origin.x = newValue }
    }
    
    /// y origin of view.
    public var y: CGFloat {
        get { frame.origin.y }
        set { frame.origin.y = newValue }
    }


    // MARK: - Methods

    /// Set some or all corner radii of view.
    /// - Parameter corners: Array of corners to change (example: [.bottomLeft, .topRight]).
    /// - Parameter radius: Radius for selected corners.
    public func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius))
        
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
    
    /// Add shadow to view.
    /// - Parameter color: Shadow color (default is #137992).
    /// - Parameter radius: Shadow radius (default is 3).
    /// - Parameter offset: Shadow offset (default is .zero).
    /// - Parameter opacity: Shadow opacity (default is 0.5).
    public func addShadow(ofColor color: UIColor = UIColor(red: 0.07, green: 0.47, blue: 0.57, alpha: 1.0),
                          radius: CGFloat = 3,
                          offset: CGSize = .zero,
                          opacity: Float = 0.5) {
        
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.masksToBounds = false
    }
    
    /// Add array of subviews to view.
    /// - Parameter subviews: Array of subviews to add to self.
    public func addSubviews(_ subviews: [UIView]) {
        subviews.forEach { addSubview($0) }
    }
    
    /// Fade in view.
    /// - Parameter duration: Animation duration in seconds.
    /// - Parameter completion: Optional completion handler to run with animation finishes.
    public func fadeIn(duration: TimeInterval = 0.25, completion: ((Bool) -> Void)? = nil) {
        if isHidden { isHidden = false }
        let animations: () -> Void = { [weak self] in self?.alpha = 1 }
        UIView.animate(withDuration: duration, animations: animations, completion: completion)
    }
    
    /// Fade out view.
    /// - Parameter duration: Animation duration in seconds.
    /// - Parameter completion: Optional completion handler to run with animation finishes.
    public func fadeOut(duration: TimeInterval = 0.25, completion: ((Bool) -> Void)? = nil) {
        if isHidden { isHidden = false }
        let animations: () -> Void = { [weak self] in self?.alpha = 0 }
        UIView.animate(withDuration: duration, animations: animations, completion: completion)
    }
    
    /// Animate changes to a view using the specified duration.
    ///
    /// This method performs the specified animations immediately using a `fade` animation type with a `easeInEaseOut` timing function.
    /// - Parameter duration: The total duration of the animations, measured in seconds. Defaults to 0.25.
    /// ````
    /// var label = UILabel()
    /// label.text = "day"
    /// label.fadeTransition()
    /// label.text = "days"
    /// ````
    public func fadeTransition(duration: TimeInterval = 0.25) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.type = .fade
        animation.duration = duration
        layer.add(animation, forKey: animation.type.rawValue)
    }
    
    /// Set the `isHidden` parameter with an optional animation.
    /// - Parameter hidden: A Boolean value that determines whether the view is hidden.
    /// - Parameter animated: Whether or not to animate the transition.
    @objc open func setHidden(_ hidden: Bool, animated: Bool = false, duration: TimeInterval = 0.25) {
        fadeTransition(duration: animated ? duration : 0)
        isHidden = hidden
    }
    
    /// Remove all subviews in view.
    public func removeSubviews() {
        subviews.forEach({ $0.removeFromSuperview() })
    }
    
    /// Remove all gesture recognizers from view.
    public func removeGestureRecognizers() {
        gestureRecognizers?.forEach() { removeGestureRecognizer($0) }
    }
    
    /// Attaches gesture recognizers to the view.
    ///
    /// Attaching gesture recognizers to a view defines the scope of the represented
    /// gesture, causing it to receive touches hit-tested to that view and all of its
    /// subviews. The view establishes a strong reference to the gesture recognizers.
    ///
    /// - Parameter recognizers: The array of gesture recognizers to be added to the view.
    public func addGestureRecognizers(_ recognizers: [UIGestureRecognizer]) {
        recognizers.forEach() { addGestureRecognizer($0) }
    }
    
    /// Detaches gesture recognizers from the receiving view.
    ///
    /// This method releases gestureRecognizers in addition to detaching them from the view.
    ///
    /// - Parameter recognizers: The array of gesture recognizers to be removed from the view.
    public func removeGestureRecognizers(_ recognizers: [UIGestureRecognizer]) {
        recognizers.forEach() { removeGestureRecognizer($0) }
    }
    
    /// Rotate view by angle on relative axis.
    /// - Parameter angle: Angle by which to rotate the view.
    /// - Parameter type: Type of the rotation angle.
    /// - Parameter animated: Set `true` to animate rotation.
    /// - Parameter duration: Animation duration in seconds.
    /// - Parameter completion: Optional completion handler to run after the animation finishes.
    public func rotate(byAngle angle: CGFloat,
                       ofType type: AngleUnit,
                       animated: Bool = false,
                       duration: TimeInterval = 1,
                       completion: ((Bool) -> Void)? = nil) {
        
        let animations: () -> Void = { [weak self] in
            guard let strongSelf = self else { return }
            let angleWithType = (type == .degrees) ? angle.degreesToRadians : angle
            strongSelf.transform = strongSelf.transform.rotated(by: angleWithType)
        }
        UIView.animate(withDuration: animated ? duration : 0,
                       delay: 0,
                       options: .curveLinear,
                       animations: animations,
                       completion: completion)
    }
    
    /// Rotate view to angle on fixed axis.
    /// - Parameter angle: Angle by which to rotate the view.
    /// - Parameter type: Type of the rotation angle.
    /// - Parameter animated: Set `true` to animate rotation.
    /// - Parameter duration: Animation duration in seconds.
    /// - Parameter completion: Optional completion handler to run after the animation finishes.
    public func rotate(toAngle angle: CGFloat,
                       ofType type: AngleUnit,
                       animated: Bool = false,
                       duration: TimeInterval = 1,
                       completion: ((Bool) -> Void)? = nil) {
        
        let animations: () -> Void = { [weak self] in
            guard let strongSelf = self else { return }
            let angleWithType = (type == .degrees) ? angle.degreesToRadians : angle
            strongSelf.transform = strongSelf.transform.concatenating(CGAffineTransform(rotationAngle: angleWithType))
        }
        UIView.animate(withDuration: animated ? duration : 0,
                       animations: animations,
                       completion: completion)
    }
    
    /// Scale view by offset.
    /// - Parameter offset: Scale offset.
    /// - Parameter animated: Set `true` to animate scaling.
    /// - Parameter duration: Animation duration in seconds.
    /// - Parameter completion: Optional completion handler to run after the transition completes.
    public func scale(by offset: CGPoint,
                      animated: Bool = false,
                      duration: TimeInterval = 1,
                      completion: ((Bool) -> Void)? = nil) {
        
        let animations: () -> Void = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.transform = strongSelf.transform.scaledBy(x: offset.x, y: offset.y)
        }
        if animated {
            UIView.animate(withDuration: duration,
                           delay: 0,
                           options: .curveLinear,
                           animations: animations,
                           completion: completion)
        } else {
            animations()
            completion?(true)
        }
    }
    
    /// Shake view.
    /// - Parameter direction: Shake direction (horizontal or vertical).
    /// - Parameter duration: Animation duration in seconds.
    /// - Parameter animationType: Shake animation type.
    /// - Parameter completion: Optional completion handler to run after animation finishes.
    public func shake(direction: ShakeDirection = .horizontal,
                      duration: TimeInterval = 1,
                      animationType: ShakeAnimationType = .easeOut,
                      completion:(() -> Void)? = nil) {
        
        CATransaction.begin()
        let animation: CAKeyframeAnimation
        switch direction {
        case .horizontal: animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        case .vertical: animation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        }
        switch animationType {
        case .linear:
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        case .easeIn:
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        case .easeOut:
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        case .easeInOut:
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        }
        CATransaction.setCompletionBlock(completion)
        animation.duration = duration
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
        CATransaction.commit()
    }
    
    /// Anchor all sides of the view into it's superview.
    @available(iOS 9, *)
    public func fillToSuperview() {
        // https://videos.letsbuildthatapp.com/
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            let leading = leadingAnchor.constraint(equalTo: superview.leadingAnchor)
            let trailing = trailingAnchor.constraint(equalTo: superview.trailingAnchor)
            let top = topAnchor.constraint(equalTo: superview.topAnchor)
            let bottom = bottomAnchor.constraint(equalTo: superview.bottomAnchor)
            NSLayoutConstraint.activate([leading, trailing, top, bottom])
        }
    }
    
    /// Add anchors from any side of the current view into the specified anchors and return the newly added constraints.
    /// - Parameter top: Current view's top anchor will be anchored into the specified anchor.
    /// - Parameter leading: Current view's left anchor will be anchored into the specified anchor.
    /// - Parameter bottom: Current view's bottom anchor will be anchored into the specified anchor.
    /// - Parameter trailing: Current view's right anchor will be anchored into the specified anchor.
    /// - Parameter topConstant: Current view's top anchor margin.
    /// - Parameter leadingConstant: Current view's left anchor margin.
    /// - Parameter bottomConstant: Current view's bottom anchor margin.
    /// - Parameter trailingConstant: Current view's right anchor margin.
    /// - Parameter widthConstant: Current view's width.
    /// - Parameter heightConstant: Current view's height.
    /// - Returns: Array of newly added constraints (if applicable).
    @available(iOS 9, *)
    @discardableResult
    public func anchor(
        top: NSLayoutYAxisAnchor? = nil,
        leading: NSLayoutXAxisAnchor? = nil,
        bottom: NSLayoutYAxisAnchor? = nil,
        trailing: NSLayoutXAxisAnchor? = nil,
        firstBaseline: NSLayoutYAxisAnchor? = nil,
        topConstant: CGFloat = 0,
        leadingConstant: CGFloat = 0,
        bottomConstant: CGFloat = 0,
        trailingConstant: CGFloat = 0,
        firstBaselineConstant: CGFloat = 0,
        widthConstant: CGFloat = 0,
        heightConstant: CGFloat = 0) -> [NSLayoutConstraint] {
        
        // https://videos.letsbuildthatapp.com/
        
        translatesAutoresizingMaskIntoConstraints = false
        
        var anchors = [NSLayoutConstraint]()
        
        if let top = top {
            anchors.append(topAnchor.constraint(equalTo: top, constant: topConstant))
        }
        
        if let leading = leading {
            anchors.append(leadingAnchor.constraint(equalTo: leading, constant: leadingConstant))
        }
        
        if let bottom = bottom {
            anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant))
        }
        
        if let trailing = trailing {
            anchors.append(trailingAnchor.constraint(equalTo: trailing, constant: -trailingConstant))
        }
        
        if let firstBaseline = firstBaseline {
            anchors.append(firstBaselineAnchor.constraint(equalTo: firstBaseline, constant: firstBaselineConstant))
        }
        
        if widthConstant.isPositive {
            anchors.append(widthAnchor.constraint(equalToConstant: widthConstant))
        }
        
        if heightConstant.isPositive {
            anchors.append(heightAnchor.constraint(equalToConstant: heightConstant))
        }
        
        anchors.forEach() { $0.isActive = true }
        
        return anchors
    }
        
    /// Anchor center X into view with a constant margin value.
    /// - Parameter view: The view to which to anchor.
    /// - Parameter constant: Constant of the anchor constraint.
    @available(iOS 9, *)
    public func anchorCenterX(to view: UIView, constant: CGFloat = 0) {
        
        // https://videos.letsbuildthatapp.com/
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: constant).isActive = true
    }
    
    /// Anchor center Y into view with a constant margin value.
    /// - Parameter view: The view to which to anchor.
    /// - Parameter constant: Constant of the anchor constraint.
    @available(iOS 9, *)
    public func anchorCenterY(to view: UIView, constant: CGFloat = 0) {
        
        // https://videos.letsbuildthatapp.com/
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).isActive = true
    }
    
    /// Anchor center into view.
    /// - Parameter view: The view to which to anchor.
    @available(iOS 9, *)
    public func anchorCenter(to view: UIView) {
        
        anchorCenterX(to: view)
        anchorCenterY(to: view)
    }
    
    /// Anchor center X into current view's superview with a constant margin value.
    /// - Parameter constant: Constant of the anchor constraint.
    @available(iOS 9, *)
    public func anchorCenterXToSuperview(constant: CGFloat = 0) {
        
        if let view = superview {
            anchorCenterX(to: view, constant: constant)
        }
    }
    
    /// Anchor center Y into current view's superview with a constant margin value.
    /// - Parameter constant: Constant of the anchor constraint.
    @available(iOS 9, *)
    public func anchorCenterYToSuperview(constant: CGFloat = 0) {
        
        if let view = superview {
            anchorCenterY(to: view, constant: constant)
        }
    }
    
    /// Anchor center X and Y into current view's superview.
    @available(iOS 9, *)
    public func anchorCenterToSuperview() {
        
        if let view = superview {
            anchorCenter(to: view)
        }
    }
    
    /// Search all superviews until a view with the condition is found.
    /// - Parameter predicate: Predicate to evaluate on superviews.
    public func ancestorView(where predicate: (UIView?) -> Bool) -> UIView? {
        if predicate(superview) { return superview }
        return superview?.ancestorView(where: predicate)
    }
    
    /// Search all superviews until a view with this class is found.
    /// - Parameter name: Class of the view to search.
    public func ancestorView<T: UIView>(withClass name: T.Type) -> T? {
        ancestorView(where: { $0 is T }) as? T
    }
}

#endif
