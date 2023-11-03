//
//  UnicornApp.swift
//  UnicornApp
//
//  Created by Mohamed Salem on 16.10.23.
//

import SwiftUI
import ComposableArchitecture
import SwiftData

/// `UnicornApp` is the main application structure for an iOS app that uses SwiftUI.
@main
struct UnicornApp: App {
    
    // MARK: - Body

    /// The body of the `UnicornApp`. It contains a scene that provides the content for one instance of the app.
    var body: some Scene {
        // A window group that manages a collection of scenes with shared state.
        WindowGroup {
            // The root view of the app, with its associated store and state.
            RootView(
                store: Store(
                    initialState: 
                        RootReducer.State(), // Initializes the root reducer state.
                    reducer: {
                        RootReducer() // Creates the root reducer.
                    }
                )
            )
            // Apply the custom appearance to the root view.
            .appearance(
                theme: .citrusGlow // Sets the theme to 'citrusGlow'.
            )
            // NOTE: To set the global accent color, specify it in the project settings.
            // Navigate to Project -> Build Settings -> Global Accent Color Name.
        }
        // SwiftData specific code to manage the data model container.
        // This section of code is conditionally compiled if the SWIFTDATA compilation flag is set.
#if SWIFTDATA
        .modelContainer(
            for: [
                Unicorn.self // Includes the Unicorn data model for the SwiftData container.
            ]
        )
#endif
    }
}

/// The `UnicornApp` is a struct conforming to the `App` protocol, which is the entry point to a SwiftUI application.
/// The `body` property defines the content of the app using a `Scene` which, in this case, is a `WindowGroup`.
/// Inside the `WindowGroup`, the `RootView` is specified as the initial view that users see when they open the app.
///
/// The `store` property of the `RootView` is initialized with a new `Store` that holds the `RootReducer.State`.
/// This store drives the state management for the app, using the Composable Architecture principles.
///
/// The `.appearance(theme: .citrusGlow)` modifier is a custom modifier to set a theme across the app.
/// The global accent color note suggests configuring a project-wide accent color through the Xcode build settings, which will apply to all UI elements.
///
/// The conditional compilation section (`#if SWIFTDATA`) includes data model container configuration specifically for the SwiftData framework,
/// which will only compile and run if the `SWIFTDATA` compilation flag is set. This is useful for separating core app functionality from code that manages data.
///
/// This configuration indicates that the app uses a data model container for the `Unicorn` data model, allowing for operations like saving, fetching, and observing data changes.
