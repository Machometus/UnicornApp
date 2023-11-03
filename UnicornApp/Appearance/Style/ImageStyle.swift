//
//  ImageStyle.swift
//  MyUnicorn
//
//  Created by Mohamed Salem on 29.12.19.
//  Copyright © 2020 Mohamed Salem. All rights reserved.
//

import SwiftUI

// MARK: Image Behaviour

/// An extension on the `Image` structure to provide consistent styling presets for images used throughout the app.
extension Image {
    
    /// Applies a thumbnail style to the image with predefined dimensions.
    ///
    /// - Returns: A view that scales this image to fit within a frame with a width and height of 44 points.
    func thumbStyle() -> some View {
        self
            .resizable() // Makes the image resizable.
            .frame(
                width: 44,
                height: 44
            ) // Sets the frame to 44x44 points.
    }

    /// Applies a small style to the image with predefined dimensions.
    ///
    /// - Returns: A view that scales this image to fit within a frame with a width and height of 72 points.
    func smallStyle() -> some View {
        self
            .resizable() // Makes the image resizable.
            .frame(
                width: 72,
                height: 72
            ) // Sets the frame to 72x72 points.
    }

    /// Applies a medium style to the image with predefined dimensions.
    ///
    /// - Returns: A view that scales this image to fit within a frame with a width and height of 80 points.
    func mediumStyle() -> some View {
        self
            .resizable() // Makes the image resizable.
            .frame(
                width: 80,
                height: 80
            ) // Sets the frame to 80x80 points.
    }

    /// Applies a large style to the image with predefined dimensions.
    ///
    /// - Returns: A view that scales this image to fit within a frame with a width and height of 160 points.
    func largeStyle() -> some View {
        self
            .resizable() // Makes the image resizable.
            .frame(
                width: 160,
                height: 160
            ) // Sets the frame to 160x160 points.
    }

    /// Applies a profile style to the image suitable for user profile pictures.
    ///
    /// This style sets the image size to a width and height of 200 points, applies a corner radius to make it circular,
    /// clips the view to its bounding frame, and adds an accent color border.
    ///
    /// - Returns: A circularly cropped image scaled to fit a 200x200 point frame with a border in the theme's accent color.
    func profileStyle() -> some View {
        self
            .resizable() // Makes the image resizable.
            .frame( // Sets the frame to 200x200 points.
                width: 200,
                height: 200
            )
            .cornerRadius( // Applies a corner radius to make it circular.
                100
            )
            .clipped() // Clips the image to the bounding frame.
            .overlay(
                RoundedRectangle( // Creates a rounded rectangle overlay.
                    cornerRadius: 100
                )
                .stroke( // Uses the accent color from the current theme.
                    Appearance.theme.accentColor
                    ,
                    lineWidth: 6 // Sets the line width of the stroke.
                )
        )
    }
}
