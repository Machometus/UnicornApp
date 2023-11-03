//
//  SwiftDataClient.swift
//  UnicornApp
//
//  Created by Mohamed Salem on 29.10.23.
//

#if SWIFTDATA
import Foundation
import ComposableArchitecture
import SwiftData

// MARK: Client

/// A client to manage the SwiftData model context used within the Composable Architecture.
struct SwiftDataClient {
    /// A closure that provides the `ModelContext` for SwiftData operations.
    var context: () throws -> ModelContext
}

// MARK: Dependency values

extension DependencyValues {
    /// A property to access the `SwiftDataClient`, allowing dependency injection for data handling within the Composable Architecture.
    var swiftDataClient: SwiftDataClient {
        get {
            self[
                SwiftDataClient.self
            ]
        }
        set {
            self[
                SwiftDataClient.self
            ] = newValue
        }
    }
}

// MARK: Implementation

extension SwiftDataClient: DependencyKey {
    /// The live implementation of `SwiftDataClient` providing the actual `ModelContext` for the app's data operations.
    static var liveValue = SwiftDataClient(
        /// SwiftData unicorn app context
        context: {
            guard let context = appContext
            else {
                throw UnicornError.unknown
            }
            return context
        }
    )
    
    /// A test implementation of `SwiftDataClient` that provides a `ModelContext` suitable for unit tests.
    static let testValue = Self(
        context: {
            guard let context = testContext
            else {
                throw UnicornError.unknown
            }
            return context
        }
    )
}

// MARK: Model Context

/// The production `ModelContext` configured for the Unicorn application.
fileprivate let appContext: ModelContext? = {
    guard let container = try? ModelContainer(
        for: Unicorn.self
    ) else {
        return nil
    }
    return ModelContext(
        container
    )
}()

/// The test `ModelContext` configured to use in-memory storage for unit testing purposes.
fileprivate let testContext: ModelContext? = {
    let configuration = ModelConfiguration(
        isStoredInMemoryOnly: true
    )
    guard let container = try? ModelContainer(
        for: Unicorn.self,
        configurations: configuration
    ) else {
        return nil
    }
    return ModelContext(
        container
    )
}()
#endif
