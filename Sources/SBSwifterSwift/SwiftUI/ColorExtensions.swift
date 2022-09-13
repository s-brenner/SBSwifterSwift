#if canImport(SwiftUI) && os(iOS)
import SwiftUI

extension Color {
    
    /// A second-level shade of gray that adapts to the environment.
    ///
    /// This color adapts to the current environment.
    /// In light environments, this gray is slightly lighter than `systemGray`.
    /// In dark environments, this gray is slightly darker than `systemGray`.
    @available(iOS 15.0, *)
    public static var systemGray2: Color {
        Color(uiColor: .systemGray2)
    }
    
    /// A third-level shade of gray that adapts to the environment.
    ///
    /// This color adapts to the current environment.
    /// In light environments, this gray is slightly lighter than `systemGray2`.
    /// In dark environments, this gray is slightly darker than `systemGray2`.
    @available(iOS 15.0, *)
    public static var systemGray3: Color {
        Color(uiColor: .systemGray3)
    }
    
    /// A fourth-level shade of gray that adapts to the environment.
    ///
    /// This color adapts to the current environment.
    /// In light environments, this gray is slightly lighter than `systemGray3`.
    /// In dark environments, this gray is slightly darker than `systemGray3`.
    @available(iOS 15.0, *)
    public static var systemGray4: Color {
        Color(uiColor: .systemGray4)
    }
    
    /// A fifth-level shade of gray that adapts to the environment.
    ///
    /// This color adapts to the current environment.
    /// In light environments, this gray is slightly lighter than `systemGray4`.
    /// In dark environments, this gray is slightly darker than `systemGray4`.
    @available(iOS 15.0, *)
    public static var systemGray5: Color {
        Color(uiColor: .systemGray5)
    }
    
    /// A sixth-level shade of gray that adapts to the environment.
    ///
    /// This color adapts to the current environment, and is close in color to `systemBackground`.
    /// In light environments, this gray is slightly lighter than `systemGray5`.
    /// In dark environments, this gray is slightly darker than `systemGray5`.
    @available(iOS 15.0, *)
    public static var systemGray6: Color {
        Color(uiColor: .systemGray6)
    }
    
    /// The color for the main background of your interface.
    ///
    /// Use this color for standard table views and designs that have a white primary background in a light environment.
    @available(iOS 15.0, *)
    public static var systemBackground: Color {
        Color(uiColor: .systemBackground)
    }
    
    /// The color for content layered on top of the main background.
    ///
    /// Use this color for standard table views and designs that have a white primary background in a light environment.
    @available(iOS 15.0, *)
    public static var secondarySystemBackground: Color {
        Color(uiColor: .secondarySystemBackground)
    }
    
    /// The color for content layered on top of secondary backgrounds.
    ///
    /// Use this color for standard table views and designs that have a white primary background in a light environment.
    @available(iOS 15.0, *)
    public static var tertiarySystemBackground: Color {
        Color(uiColor: .tertiarySystemBackground)
    }
    
    /// The color for the main background of your grouped interface.
    ///
    /// Use this color for grouped content, including table views and platter-based designs.
    @available(iOS 15.0, *)
    public static var systemGroupedBackground: Color {
        Color(uiColor: .systemGroupedBackground)
    }
    
    /// The color for content layered on top of the main background of your grouped interface.
    ///
    /// Use this color for grouped content, including table views and platter-based designs.
    @available(iOS 15.0, *)
    public static var secondarySystemGroupedBackground: Color {
        Color(uiColor: .secondarySystemGroupedBackground)
    }
    
    /// The color for content layered on top of secondary backgrounds of your grouped interface.
    ///
    /// Use this color for grouped content, including table views and platter-based designs.
    @available(iOS 15.0, *)
    public static var tertiarySystemGroupedBackground: Color {
        Color(uiColor: .tertiarySystemGroupedBackground)
    }
}
#endif
