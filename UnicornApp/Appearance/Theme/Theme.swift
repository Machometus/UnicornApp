//
//  Theme.swift
//  UnicornApp
//
//  Created by Mohamed Salem on 25.10.23.
//

import SwiftUI

/// Enum Theme

/// Represents the visual theme of the app, providing a suite of UI colors that can be used to style the interface.
enum Theme {
    
    /// The Citrus Glow theme, characterized by warm, vibrant tones.
    case citrusGlow
    
    /// The Tropical Waters theme, characterized by cool, refreshing tones.
    case tropicalWaters
}

// MARK: - Theme Styling Properties

extension Theme {
    
    /// The primary color associated with the theme, often used for prominent interface elements.
    /// - Citrus Glow: burntSienna color.
    /// - Tropical Waters: cinnamonSpice color.
    var primaryColor: Color {
        switch self {
        case .citrusGlow:
            return .burntSienna
        case .tropicalWaters:
            return .cinnamonSpice
        }
    }
    
    /// The secondary color associated with the theme, used for secondary interface elements to complement the primary color.
    /// - Citrus Glow: peachSunrise color.
    /// - Tropical Waters: mistyLagoon color.
    var secondaryColor: Color {
        switch self {
        case .citrusGlow:
            return .peachSunrise
        case .tropicalWaters:
            return .mistyLagoon
        }
    }
    
    /// The accent color associated with the theme, used to highlight key interface elements and provide a visual pop.
    /// - Citrus Glow: vividTangerine color.
    /// - Tropical Waters: turquoiseWave color.
    var accentColor: Color {
        switch self {
        case .citrusGlow:
            return .vividTangerine
        case .tropicalWaters:
            return .turquoiseWave
        }
    }
    
    /// The background color associated with the theme, used as a base canvas for app content.
    /// - Citrus Glow: goldenApricot color.
    /// - Tropical Waters: arcticFrost color.
    var backgroundColor: Color {
        switch self {
        case .citrusGlow:
            return .goldenApricot
        case .tropicalWaters:
            return .arcticFrost
        }
    }

    /// The text color associated with the theme, chosen for legibility against the theme's background color.
    /// - Citrus Glow: earthyBrown color.
    /// - Tropical Waters: midnightNavy color.
    var textColor: Color {
        switch self {
        case .citrusGlow:
            return .earthyBrown
        case .tropicalWaters:
            return .midnightNavy
        }
    }
    
    /// The image used for loading animations or placeholders, selected to match the theme's aesthetic.
    /// - Citrus Glow: An orange-themed loading image.
    /// - Tropical Waters: A blue-themed loading image.
    var loadingImage: Image {
        switch self {
        case .citrusGlow:
            return Image(.loadingOrange)
        case .tropicalWaters:
            return Image(.loadingBlue)
        }
    }
}
