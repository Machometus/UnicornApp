//
//  TextFieldStyle.swift
//  UnicornApp
//
//  Created by Mohamed Salem on 25.10.23.
//

import SwiftUI

// MARK: TextField Behaviour

/// An extension on the `TextField` view to provide consistent styling in accordance with the app's design theme.
extension TextField {
    
    /// Applies the subheadline text style to the TextField.
    ///
    /// - Returns: A TextField styled with the subheadline font size.
    func subheadlineStyle() -> some View {
        self
            .font( // Sets the font to the subheadline size.
                .subheadline
            )
    }
}
