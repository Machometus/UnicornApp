//
//  Font.swift
//  UnicornApp
//
//  Created by Mohamed Salem on 24.10.23.
//

import SwiftUI

/// Enum for managing custom fonts specific to the 'Unicorn' theme within the app.

// MARK: - Unicorn font

/// A fileprivate enumeration that encapsulates custom font information for the Unicorn-themed interface.

fileprivate
enum UnicornFont: String {
    
    // MARK: Cases
    
    /// Represents the custom Arabic font used throughout the app.
    case arabic = "18KhebratMusamim"
    
    /// Represents the custom Latin font used throughout the app.
    case latin = "CaviarDreams"
    
    /// Represents the custom Arabic bold font used throughout the app.
    case arabicBold = "18KhebratMusamimBold"
    
    /// Represents the custom Latin bold font used throughout the app.
    case latinBold = "CaviarDreams-Bold"
    
    // MARK: Getters
    
    /// Retrieves the name of the font in accordance with the current locale.
    static var name: String {
        (
            Locale.isArabic ?
            arabic : latin
        )
        .rawValue
    }
    
    /// Retrieves the font name with the appropriate weight based on the current locale and specified weight.
    /// - Parameter weight: The weight of the font to be used.
    /// - Returns: A string representing the font name for the given weight.
    static func description(
        _ weight: UIFont.Weight
    ) -> String {
        if Locale.isArabic {
            return (weight == .bold ? arabicBold : arabic).rawValue
        } else {
            return (weight == .bold ? latinBold : latin).rawValue
        }
    }
    
    /// Creates a `Font` instance with a custom size.
    /// - Parameter size: The size of the font.
    /// - Returns: A `Font` instance with the specified size.
    static func font(
        size: CGFloat
    ) -> Font {
        Font.custom(
            name,
            size: size
        )
    }
    
    /// Creates a `UIFont` instance with a custom size and weight.
    /// - Parameters:
    ///   - size: The size of the font.
    ///   - weight: The weight of the font. Defaults to `.regular` if not specified.
    /// - Returns: A `UIFont` instance with the specified size and weight, or the system font if the custom font cannot be found.
    static func uifont(
        size: CGFloat,
        weight: UIFont.Weight = .regular
    ) -> UIFont {
        UIFont(
            name: description(weight),
            size: size
        ) ??
        UIFont.systemFont(
            ofSize: size,
            weight: weight
        )
    }
}

/// Locale helper

/// An extension on `Locale` to provide additional functionality specific to the app's requirements.
extension Locale {
    /// Checks if the current language setting of the device is Arabic.
    static var isArabic: Bool {
        return Locale.current.language.languageCode?.identifier == "ar"
    }
}

// MARK: App fonts

/// An extension on `Font` to provide custom fonts for the 'Unicorn' theme within the SwiftUI framework.
extension Font {
    
    /// A font with the large title text style.
    public static let largeTitle: Font = UnicornFont.font(size: 34)
    
    /// A font with the title text style.
    public static let title: Font = UnicornFont.font(size: 28)
    
    /// Create a font for second level hierarchical headings.
    public static let title2: Font = UnicornFont.font(size: 24)
    
    /// Create a font for third level hierarchical headings.
    public static let title3: Font = UnicornFont.font(size: 20)
    
    /// A font with the headline text style.
    public static let headline: Font = UnicornFont.font(size: 19)
    
    /// A font with the subheadline text style.
    public static let subheadline: Font = UnicornFont.font(size: 17)
    
    /// A font with the body text style.
    public static let body: Font = UnicornFont.font(size: 16)
    
    /// A font with the callout text style.
    public static let callout: Font = UnicornFont.font(size: 15)
    
    /// A font with the footnote text style.
    public static let footnote: Font = UnicornFont.font(size: 13)
    
    /// A font with the caption text style.
    public static let caption: Font = UnicornFont.font(size: 12)
    
    /// Create a font with the alternate caption text style.
    public static let caption2: Font = UnicornFont.font(size: 11)
}

/// An extension on `UIFont` to provide custom fonts for the 'Unicorn' theme within UIKit.
extension UIFont {
    
    /// A font with the large title text style.
    public static let largeTitle: UIFont = UnicornFont.uifont(size: 34, weight: .bold)
    
    /// A font with the title text style.
    public static let title3: UIFont = UnicornFont.uifont(size: 20, weight: .bold)
    
    /// Create a font with the alternate caption text style.
    public static let caption2: UIFont = UnicornFont.uifont(size: 11, weight: .bold)
}
