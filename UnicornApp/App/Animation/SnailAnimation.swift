//
//  SnailAnimation.swift
//  UnicornApp
//
//  Created by Mohamed Salem on 17.10.23.
//

import SwiftUI

/// `SnailAnimationPower` is an enumeration that defines the intensity of the spring animation.
enum SnailAnimationPower {
    /// A light spring animation with specified mass, stiffness, damping, and initial velocity.
    case light
    /// A heavy spring animation with more mass and stiffness, but less damping.
    case heavy
}

/// `SnailAnimationModifier` is a custom view modifier that applies an animated
/// transformation to the conforming view, causing it to scale and rotate in a manner
/// reminiscent of a snail's motion. This modifier leverages spring-based animations
/// to provide a realistic and physically-based movement.
struct SnailAnimationModifier: ViewModifier {
    
    // MARK: - States
    
    /// State to control the scale of the view.
    @State var scale: CGFloat = 1
    
    /// State to control the rotation of the view.
    @State var rotation: Double = 0
    
    // MARK: - Properties
    
    /// The final scale factor to which the view should animate.
    var scaleFactor: CGFloat
    
    /// The final rotation factor (in degrees) to which the view should animate.
    var rotationFactor: Double
    
    /// The power of the animation, which can be `light` or `heavy`.
    var power: SnailAnimationPower
    
    /// Determines whether the animation should repeat indefinitely.
    var forever: Bool
    
    // MARK: - Body
    
    /// Defines the body for the view modifier.
    func body(
        content: Content
    ) -> some View {
        content
            .scaleEffect(
                scale
            )
            .rotationEffect(
                .degrees(rotation)
            )
            .onAppear {
                // Create an interpolating spring animation with the specified power.
                var animation = Animation
                    .interpolatingSpring(
                        power: self.power
                    )
                
                if self.forever {
                    // If `forever` is true, repeat the animation indefinitely.
                    animation = animation.repeatForever()
                }
                
                // Perform the animation, updating the scale and rotation values.
                return withAnimation(animation) {
                    self.scale = self.scaleFactor
                    self.rotation = self.rotationFactor
                }
        }
    }
}

// MARK: - Animation Behaviour

extension Animation {
    /// Provides a spring animation based on the specified `SnailAnimationPower`.
    ///
    /// `power`: The intensity level of the animation, which can be `.light` or `.heavy`.
    ///
    /// - Returns: An `Animation` instance with spring-like motion properties.
    static func interpolatingSpring(
        power: SnailAnimationPower
    ) -> Animation {
        
        switch power {
        // A light spring animation with specified mass, stiffness, damping, and initial velocity.
        case .light:
            return Animation.interpolatingSpring(mass: 0.8,
                                                 stiffness: 70.0,
                                                 damping: 8,
                                                 initialVelocity: 0)
        // A heavy spring animation with more mass and stiffness, but less damping.
        case .heavy:
            return Animation.interpolatingSpring(mass: 2.0,
                                                 stiffness: 150.0,
                                                 damping: 5,
                                                 initialVelocity: 0)
        }
    }
}

// MARK: - View Behaviour

extension View {
    /// Applies a snail-like spring animation to the view with scaling and rotation.
    ///
    /// `scale`: The target scale factor for the animation.
    /// `rotation`: The target rotation angle for the animation, in degrees.
    /// `power`: The intensity of the spring animation.
    /// `forever`: Whether the animation should repeat indefinitely.
    ///
    /// - Returns: The view modified with the `SnailAnimationModifier`, causing it to animate.
    func snailAnimation(scale: CGFloat,
                        rotation: Double,
                        power: SnailAnimationPower,
                        forever: Bool) -> some View {
        self.modifier(
            SnailAnimationModifier(
                scaleFactor: scale,
                rotationFactor: rotation,
                power: power,
                forever: forever
            )
        )
    }
}

/// The `SnailAnimationModifier` allows views to be easily animated with a spring effect, simulating the movement of a snail.
/// By adjusting the `scaleFactor`, `rotationFactor`, and `power`, various animation styles can be achieved.
/// The modifier can be used on any SwiftUI view by calling the `snailAnimation` function with the desired parameters.
