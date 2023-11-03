//
//  URLClient.swift
//  UnicornApp
//
//  Created by Mohamed Salem on 30.10.23.
//

import Foundation
import ComposableArchitecture

// MARK: Base

/// Provides the base URL string for HTTP requests, incorporating a secret key for authentication.
fileprivate var base: String {
    "https://crudcrud.com/api/\(secret)/"
}

/// The secret key appended to the base URL for secure HTTP requests.
fileprivate var secret: String {
    "f5a3a303926149d9a6aa57538cc5d3bc" // Replace with your actual secret key
}

// MARK: Client

/// A client to manage URLs for Unicorn-related HTTP requests.
struct URLClient {
    /// A closure that returns the URL for unicorn resources.
    var unicorns: () -> URL?
    
    /// A closure that takes a unique identifier and returns the URL for a specific unicorn resource.
    var unicorn: (String) -> URL?
}

// MARK: Dependency values

extension DependencyValues {
    /// Provides access to the URL client within the dependency injection system of `ComposableArchitecture`.
    var urlClient: URLClient {
        get {
            self[
                URLClient.self
            ]
        }
        set {
            self[
                URLClient.self
            ] = newValue
        }
    }
}

// MARK: Implementation

extension URLClient: DependencyKey {
    /// The live implementation of `URLClient` providing the actual URLs for the Unicorn resources.
    static var liveValue = URLClient(
        unicorns: {
            URL(
                string: base + "unicorns"
            )
        },
        unicorn: {
            id in
            
            URL(
                string: base + "unicorns/" + id
            )
        }
    )
    
    /// A test implementation of `URLClient` that can be used for unit testing, returning nil for all URLs.
    static let testValue = Self(
        unicorns: {
            .none
        },
        unicorn: { _ in
            .none
        }
    )
}

// MARK: - Security Notice

/*
  IMPORTANT: The `secret` variable contains sensitive information that should be kept secure and not hard-coded into
  the application. It should be loaded from a secure source at runtime, such as environment variables, a secure vault,
  or via secure fetching from a remote configuration service.
  
  For the purposes of this documentation, the `secret` key is visible. However, in a production environment, ensure that
  this key is protected and not exposed in your codebase or version control system.
*/
