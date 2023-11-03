//
//  NavigationBarStyle.swift
//  UnicornApp
//
//  Created by Mohamed Salem on 25.10.23.
//

import Foundation
import UIKit
import SwiftUI

// MARK: NavigationBar Behaviour

/// An extension of `RootView` to modify the global navigation bar style within the app.
extension RootView {
    /// Applies a custom style to the navigation bar.
    ///
    /// This method configures the appearance of the navigation bar by setting the font attributes
    /// for large titles and regular titles using custom fonts defined elsewhere in the app.
    ///
    /// The appearance settings are applied to the standard appearance of the navigation bar, which
    /// affects all instances of `UINavigationBar` in the app.
    ///
    /// - Returns: An instance of `RootView` with the modified navigation bar style applied.
    func navigationBarStyle() -> RootView {
        
        // Initialize a UINavigationBarAppearance object to customize navigation bar appearance.
        let appearance = UINavigationBarAppearance()
        
        // Set the font for the large title text attributes using the scaledFont to support Dynamic Type.
        appearance.largeTitleTextAttributes = [
            .font: 
                UIFontMetrics.default.scaledFont(
                    for: .largeTitle
                )
        ]
        
        // Set the font for the regular title text attributes using the scaledFont to support Dynamic Type.
        appearance.titleTextAttributes = [
            .font:
                UIFontMetrics.default.scaledFont(
                    for: .title3
                )
        ]
        
        // Apply the custom appearance settings to the standardAppearance of UINavigationBar.
        UINavigationBar.appearance().standardAppearance = appearance
        
        // Return the RootView instance to support method chaining.
        return self
    }
}
