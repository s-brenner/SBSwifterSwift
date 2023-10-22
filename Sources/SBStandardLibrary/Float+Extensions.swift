public extension Float {
    
    /// Double.
    var double: Double { Double(self) }
    
    /// CGFloat.
    var cgFloat: CGFloat { CGFloat(self) }
    
    /// Int. Rounded to nearest or away from zero.
    var int: Int { Int(self.rounded(.toNearestOrAwayFromZero)) }
}
