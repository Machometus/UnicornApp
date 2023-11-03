//
//  LoadingView.swift
//  UnicornApp
//
//  Created by Mohamed Salem on 21.10.23.
//

import SwiftUI

// MARK: - LoadingView

/// `LoadingView` is a SwiftUI view component that represents a loading indicator.
/// It animates a predefined image by scaling and rotating to indicate an ongoing process.
struct LoadingView: View {
    
    // MARK: States
    
    /// State variables to control the animation of the loading image. They are used to
    /// animate the scaling and rotation of the loading image.
    @State var scale: CGFloat = 1
    @State var rotation: Double = 0
    
    // MARK: Body
    
    /// The body of the `LoadingView`, describing the view's layout and behavior.
    var body: some View {
        Appearance.theme.loadingImage
            .largeStyle()
            .snailAnimation(
                scale: 1.2,     // End scale of the animation.
                rotation: 360,  // End rotation of the animation, in degrees.
                power: .light,  // The intensity of the animation; here, it's light.
                forever: true   // The animation will repeat indefinitely.
            )
    }
}

// MARK: - View Modifiers

/// `LoadingModifier` is a custom view modifier that overlays a loading indicator
/// on top of the content when `isLoading` is `true`.
struct LoadingModifier: ViewModifier {
    
    /// A Boolean value that determines whether the loading view should be visible.
    var isLoading: Bool
    
    /// The body of the `LoadingModifier`, overlaying the `LoadingView` on the content
    func body(
        content: Content
    ) -> some View {
        
        ZStack {
            content
            LoadingView()
                .opacity(
                    isLoading ? 1 : 0
                )
        }
    }
}

// MARK: - Behaviour

extension View {
    
    /// Adds a loading overlay to the view when `isLoading` is `true`.
    ///
    /// `isLoading`: A Boolean value that triggers the loading overlay when `true`.
    ///
    /// - Returns: A modified view that includes a loading indicator when `isLoading` is `true`.
    func loading(
        _ isLoading: Bool
    ) -> some View {
        self.modifier(
            LoadingModifier(
                isLoading: isLoading
            )
        )
    }
}

// MARK: - Preview

#Preview {
    LoadingView()
}
