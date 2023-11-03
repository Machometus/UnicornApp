//
//  ViewStyle.swift
//  UnicornApp
//
//  Created by Mohamed Salem on 25.10.23.
//

import SwiftUI

// MARK: View Behaviour

/// An extension of `View` to add custom background style behavior.
extension View {
    /// Applies a custom background color to the view based on the app's global theme.
    ///
    /// This function retrieves the background color associated with the current theme and
    /// applies it as the background of the view. The `Appearance` struct holds the global theme setting,
    /// which determines the color scheme of the application.
    ///
    /// - Returns: A modified view with the theme-specific background color applied.
    func backgroundStyle() -> some View {
        // Apply the background color from the global theme.
        // The Appearance.theme provides the current theme of the application.
        // The backgroundColor property of the theme is then used as the view's background.
        self
            .background(
                Appearance.theme.backgroundColor
            )
    }
}
