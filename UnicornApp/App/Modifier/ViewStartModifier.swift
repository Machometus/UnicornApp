//
//  ViewStartModifier.swift
//  UnicornApp
//
//  Created by Mohamed Salem on 22.10.23.
//

import SwiftUI

// MARK: - ViewStartModifier

/// `ViewStartModifier` is a custom view modifier that triggers an asynchronous action when the view appears.
/// This modifier is designed to perform a task once when the view is first rendered.
public struct ViewStartModifier: ViewModifier {

    // MARK: State
    
    /// A private state to track if the view has already started, to prevent the action from running multiple times.
    @State private var hasStarted = false
    
    // MARK: Action
    
    /// The asynchronous action to be performed when the view appears for the first time.
    private let action: () async -> Void
    
    // MARK: Initializer
    
    /// Initializes the modifier with an action to be executed asynchronously.
    ///
    /// - Parameter action: An async closure that encapsulates the work to be done when the view appears.
    public init(
        _ action: @escaping () async -> Void
    ) {
        self.action = action
    }
    
    // MARK: Body
    
    /// The body of the `ViewStartModifier` that defines how the view behaves and appears.
    public func body(
        content: Content
    ) -> some View {
        
        content
            .task {
                // Check if the action has already been started to avoid repetition.
                guard !hasStarted else {
                    return
                }
                
                // Set the flag to indicate the action has started.
                hasStarted = true
                
                // Execute the given asynchronous action.
                await action()
            }
    }
}

// MARK: - View Extension for onStart

public extension View {
    
    /// Calls an asynchronous action when the view appears for the first time.
    /// This is a convenience method to apply the `ViewStartModifier` to the view.
    ///
    /// - Parameter action: An async closure to be executed when the view appears.
    /// - Returns: A view modified to perform the action asynchronously on appearance.
    func onStart(
        _ action: @escaping () async -> Void
    ) -> some View {
        modifier(ViewStartModifier(action))
    }
}

