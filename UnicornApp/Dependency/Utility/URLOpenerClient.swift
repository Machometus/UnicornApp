//
//  URLOpenerClient.swift
//  UnicornApp
//
//  Created by Mohamed Salem on 22.10.23.
//

import SwiftUI
import ComposableArchitecture

// MARK: Client

/// `URLOpenerClient` provides functionality to open URLs.
/// It contains a closure that can be set to handle opening URL strings.
struct URLOpenerClient {
    /// Closure that takes a URL string and attempts to open it.
    /// - Parameter urlString: A `String` that represents a URL to be opened.
    var open: (
        String
    ) -> Void
}

// MARK: Dependency values

extension DependencyValues {
    /// Provides access to the `URLOpenerClient` within the environment of the Composable Architecture.
    /// This allows opening URLs from anywhere within the app that has access to the environment.
    var urlOpenerClient: URLOpenerClient {
        get {
            self[
                URLOpenerClient.self
            ]
        }
        set {
            self[
                URLOpenerClient.self
            ] = newValue
        }
    }
}

// MARK: Implementation

extension URLOpenerClient: DependencyKey {
    /// The live implementation of `URLOpenerClient` for use in the production environment.
    /// It opens the given URL using the shared application instance.
    static var liveValue = URLOpenerClient(
        open: { 
            link in
            // Attempt to convert the string to a URL object.
            if let url = URL(
                string: link
            ) {
                // Use the shared application to open the URL.
                UIApplication.shared.open(
                    url
                )
                // If the URL conversion fails, the link will not be opened. Handling of invalid URLs should be implemented as needed.
            }
        }
    )
    
    /// The test implementation of `URLOpenerClient`.
    /// It provides a no-op implementation for tests, where opening URLs is unnecessary and should be avoided.
    static let testValue: URLOpenerClient = Self(
        open: { _ in
            // No-op for test environment. No URLs will be opened.
        }
    )
}
