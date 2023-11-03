//
//  Appearance.swift
//  UnicornApp
//
//  Created by Mohamed Salem on 25.10.23.
//

import Foundation

/// Represents the overall appearance settings for the app, encapsulating theme-related configurations.
struct Appearance {
    
    // MARK: Theme
    
    /// The global theme of the app, which determines the color scheme and styling throughout the app's interface.
    /// Default value is set to `.citrusGlow`, which can be changed to apply a new theme.
    static var theme: Theme = .citrusGlow /// App global theme
}

/// An extension on `RootView` to configure its appearance based on the selected theme.
extension RootView {

    /// Applies the specified theme to the `RootView` and updates the global appearance settings.
    ///
    /// By setting `Appearance.theme`, all UI components of the app that rely on the global theme will update their appearance accordingly.
    ///
    /// - Parameter theme: The `Theme` that the app should use.
    /// - Returns: An updated instance of `RootView` with the new theme applied.
    func appearance(
        theme: Theme
    ) -> RootView {
        
        Appearance.theme = theme // Sets the selected theme as the app's global theme.
        
        return self
            .navigationBarStyle() // Applies a custom style to the navigation bar using UIKit appearance proxies.
            .tabBarStyle() // Applies a custom style to the tab bar using UIKit appearance proxies.
    }
}
