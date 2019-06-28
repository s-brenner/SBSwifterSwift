import MapKit

extension MKMapView {
    
    /// Dequeue reusable MKAnnotationView using class type.
    /// - Parameter name: MKAnnotationView type.
    /// - Returns: Optional MKAnnotationView object.
    public func dequeueReusableAnnotationView<T: MKAnnotationView>(withClass name: T.Type) -> T? {
        return dequeueReusableAnnotationView(withIdentifier: String(describing: name)) as? T
    }
    
    /// Register MKAnnotationView using class type.
    /// - Parameter name: MKAnnotationView type.
    @available(iOS 11.0, tvOS 11.0, macOS 10.13, *)
    public func register<T: MKAnnotationView>(annotationViewWithClass name: T.Type) {
        register(T.self, forAnnotationViewWithReuseIdentifier: String(describing: name))
    }
    
    /// Dequeue reusable MKAnnotationView using class type.
    /// - Parameter name: MKAnnotationView type.
    /// - Parameter annotation: Annotation of the mapView.
    /// - Returns: A MKAnnotationView object.
    @available(iOS 11.0, tvOS 11.0, macOS 10.13, *)
    public func dequeueReusableAnnotationView<T: MKAnnotationView>(withClass name: T.Type, for annotation: MKAnnotation) -> T {
        let identifier = String(describing: name)
        guard let annotationView = dequeueReusableAnnotationView(withIdentifier: identifier, for: annotation) as? T else {
            fatalError("Couldn't find MKAnnotationView for \(identifier)")
        }
        
        return annotationView
    }
    
}
