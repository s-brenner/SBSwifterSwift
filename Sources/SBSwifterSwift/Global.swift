import Foundation

/// Replace a property in a class with a parameter in another object only if needed.
///
/// A use case for this method is to simplify the process of efficiently updating properties in a NSManagedObject.
/// - Parameters:
///   - this: A tuple containing a class and keyPath for that class.
///   - that: A tupe containing an object and a keyPath for that object.
/// - Returns: A Boolean that indicates whether the given property was replaced.
/// ````
/// class Person {
///     var name = ""
/// }
///
/// struct PersonJSON {
///     let name: String
/// }
///
/// let michelle = Person()
/// let json = PersonJSON(name: "Michelle")
///
/// // This line:
/// setIfNeeded((michelle, \.name), to: (json, \.name))
///
/// // has the same function as this line:
/// if michelle.name != json.name { michelle.name = json.name }
/// ````
@discardableResult
public func setIfNeeded<R1, R2, V: Equatable>(
    _ this: (source: R1, keyPath: ReferenceWritableKeyPath<R1, V>),
    to that: (source: R2, keyPath: KeyPath<R2, V>)
) -> Bool {
    if this.source[keyPath: this.keyPath] != that.source[keyPath: that.keyPath] {
        this.source[keyPath: this.keyPath] = that.source[keyPath: that.keyPath]
        return true
    }
    return false
}

/// Generic utility function that configures an object.
public func configure<T>(
    _ value: T,
    using closure: (inout T) throws -> Void) rethrows -> T {
        
        var value = value
        try closure(&value)
        return value
}
