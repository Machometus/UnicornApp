//
//  TextStyle.swift
//  MyUnicorn
//
//  Created by Mohamed Salem on 29.12.19.
//  Copyright © 2020 Mohamed Salem. All rights reserved.
//

import SwiftUI

// MARK: Text Behaviour

/// An extension on the `Text` view to provide various text styles consistent with the app's design theme.
extension Text {

    /// Applies the large title text style with a custom color.
    ///
    /// - Parameter color: The color to apply to the text.
    /// - Returns: A text view styled as a large title with the specified color and padding.
    func largeTitleStyle(
        _ color: Color
    ) -> some View {
        self
            .font( // Sets the font to the large title size.
                .largeTitle
            )
            .foregroundStyle( // Applies the specified color to the text.
                color
            )
            .padding( // Adds padding around the text.
                10
            )
    }

    /// Applies the large title text style with a gradient foreground.
    ///
    /// - Returns: A text view styled as a bold large title with a linear gradient foreground using the theme's primary and accent colors.
    func largeTitleStyle() -> some View {
        self
            .font( // Sets the font to the large title size.
                .largeTitle
            )
            .fontWeight( // Makes the font weight bold.
                .bold
            )
            .foregroundStyle( // Applies a linear gradient as the foreground.
                LinearGradient(
                        colors: [
                            Appearance.theme.primaryColor,
                            Appearance.theme.accentColor
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
            )
    }

    /// Applies the title text style.
    ///
    /// - Returns: A text view styled as a title with the theme's secondary color.
    func titleStyle() -> some View {
        self
            .font( // Sets the font to the title size.
                .title
            )
            .foregroundStyle( // Applies the theme's secondary color to the text.
                Appearance.theme.secondaryColor
            )
    }

    /// Applies the headline text style.
    ///
    /// - Returns: A text view styled as a headline with the theme's primary color.
    func headlineStyle() -> some View {
        self
            .font( // Sets the font to the headline size.
                .headline
            )
            .foregroundStyle( // Applies the theme's primary color to the text.
                Appearance.theme.primaryColor
            )
    }

    /// Applies the subheadline text style.
    ///
    /// - Returns: A text view styled as a subheadline.
    func subheadlineStyle() -> some View {
        self
            .font( // Sets the font to the subheadline size.
                .subheadline
            )
    }

    /// Applies the footnote text style.
    ///
    /// - Returns: A text view styled as a footnote.
    func footnoteStyle() -> some View {
        self
            .font( // Sets the font to the footnote size.
                .footnote
            )
    }
}
