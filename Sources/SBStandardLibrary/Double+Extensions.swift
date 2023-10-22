public extension Double {
    
    /// Float.
    var float: Float { Float(self) }
    
    /// CGFloat.
    var cgFloat: CGFloat { CGFloat(self) }
    
    /// Int. Rounded to nearest or away from zero.
    var int: Int { Int(self.rounded(.toNearestOrAwayFromZero)) }
}
