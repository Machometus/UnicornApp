//
//  BannerView.swift
//  UnicornApp
//
//  Created by Mohamed Salem on 24.10.23.
//

import SwiftUI

/// A view component that serves as a banner, including a contact's photo and details such as name and job title.
struct BannerView: View {
    
    // MARK: Body
    
    /// The content and layout of the view.
    var body: some View {
        /// Contact photo
        Image(
            .me
        )
        .profileStyle()
        /// Animate main image
        .snailAnimation(
            scale: 1.2,       /// Scaling factor for the animation.
            rotation: 360,    /// Rotation angle in degrees.
            power: .heavy,    /// The 'power' or intensity of the animation.
            forever: false    /// Whether the animation should repeat indefinitely.
        )
        VStack {
            /// Contact name
            Text(
                "Mohamed Salem"
            )
            .largeTitleStyle()
            /// Contact job
            Text(
                "iOS Developer"
            )
            .titleStyle()
        }
    }
}

// MARK: - Preview

/// A preview provider that allows you to see a representation of the BannerView's appearance in Xcode's canvas or SwiftUI Previews.
#Preview {
    /// A vertical stack for spacing and positioning the BannerView in the preview.
    VStack (
        spacing: 48,
        content: {
            BannerView()
        }
    )
}
