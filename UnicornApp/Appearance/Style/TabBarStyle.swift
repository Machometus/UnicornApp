//
//  TabBarStyle.swift
//  UnicornApp
//
//  Created by Mohamed Salem on 25.10.23.
//

import Foundation
import UIKit
import SwiftUI

// MARK: TabBar Behaviour

/// An extension of `RootView` to modify the global tab bar style within the app.
extension RootView {
    /// Applies a custom style to the tab bar.
    ///
    /// This method customizes the appearance of tab bar items by setting the font attributes
    /// for their titles using custom fonts defined elsewhere in the app.
    ///
    /// The font attributes are applied to the `normal` state of tab bar items, affecting
    /// all instances of `UITabBarItem` throughout the app.
    ///
    /// - Returns: An instance of `RootView` with the modified tab bar style applied.
    func tabBarStyle() -> RootView {
        
        // Set the font for the title text attributes of UITabBarItem using scaledFont to support Dynamic Type.
        UITabBarItem.appearance().setTitleTextAttributes(
            [
                .font:
                    UIFontMetrics.default.scaledFont(
                        for: .caption2
                    )
            ],
            for: .normal
        )
        
        // Return the RootView instance to support method chaining.
        return self
    }
}

