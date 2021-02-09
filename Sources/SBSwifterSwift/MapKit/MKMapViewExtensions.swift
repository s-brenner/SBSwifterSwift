#if canImport(MapKit)
import protocol MapKit.MKAnnotation
import class    MapKit.MKAnnotationView
import class    MapKit.MKMapView

extension MKMapView {
    
    /// Dequeue reusable MKAnnotationView using class type.
    /// - Parameter name: MKAnnotationView type.
    /// - Returns: Optional MKAnnotationView object.
    public func dequeueReusableAnnotationView<T: MKAnnotationView>(withClass name: T.Type) -> T? {
        
        dequeueReusableAnnotationView(withIdentifier: String(describing: name)) as? T
    }
    
    /// Register MKAnnotationView using class type.
    /// - Parameter name: MKAnnotationView type.
    public func register<T: MKAnnotationView>(annotationViewWithClass name: T.Type) {
        
        register(T.self, forAnnotationViewWithReuseIdentifier: String(describing: name))
    }
    
    /// Dequeue reusable MKAnnotationView using class type.
    /// - Parameter name: MKAnnotationView type.
    /// - Parameter annotation: Annotation of the mapView.
    /// - Returns: A MKAnnotationView object.
    public func dequeueReusableAnnotationView<T: MKAnnotationView>(withClass name: T.Type, for annotation: MKAnnotation) -> T {
        
        let identifier = String(describing: name)
        guard let annotationView = dequeueReusableAnnotationView(withIdentifier: identifier, for: annotation) as? T else {
            fatalError("Couldn't find MKAnnotationView for \(identifier)")
        }
        return annotationView
    }
}
#endif
