//
//  ErrorClient.swift
//  UnicornApp
//
//  Created by Mohamed Salem on 27.10.23.
//

import Foundation
import ComposableArchitecture

// MARK: Client

/// `ErrorClient` encapsulates the logic for creating an alert state from an `Error`.
/// It transforms various known errors into user-friendly error messages.
struct ErrorClient {
    /// Closure that takes an `Error` and returns an `AlertState` configured with an appropriate message.
    /// - Parameter error: The `Error` to be handled.
    /// - Returns: An `AlertState` that represents an alert configured for the error.
    var error: (
        Error
    ) -> AlertState<Alert>
    
    /// Enum `Alert` defines equatable cases for different alert actions that can be taken.
    /// This can be expanded with specific cases for error handling.
    enum Alert: Equatable { }
}

// MARK: Dependency values

extension DependencyValues {
    /// Provides access to the `ErrorClient` within the environment of the Composable Architecture.
    /// This allows for the handling of errors with user-facing alerts throughout the app.
    var errorClient: ErrorClient {
        get {
            self[
                ErrorClient.self
            ]
        }
        set {
            self[
                ErrorClient.self
            ] = newValue
        }
    }
}

// MARK: Implementation

extension ErrorClient: DependencyKey {
    /// The live implementation of `ErrorClient` that should be used in the production app.
    /// It translates different `UnicornError` cases into readable error messages for the user.
    static var liveValue = ErrorClient(
        error: {
            error in
            // Convert the error into a human-readable message.
            let message = switch error as? UnicornError {
                
            case .fetch:
                // Message for when fetching data fails.
                String(
                    localized:
                        "An error was encountered while attempting to load unicorns. Please retry at a later time."
                )
            case .add:
                // Message for when adding a new item fails.
                String(
                    localized:
                        "An error was encountered while attempting to add the unicorn. Please retry at a later time."
                    )
            case .edit:
                // Message for when editing an item fails.
                String(
                    localized:
                        "An error was encountered while attempting to edit the unicorn. Please retry at a later time."
                    )
            case .delete:
                // Message for when deleting an item fails.
                String(
                    localized:
                        "An error was encountered while attempting to delete the unicorn. Please retry at a later time."
                    )
            case .unknown, .none:
                // General message for an unknown error or any error not explicitly handled above.
                String(
                    localized:
                        "Oops! Something went wrong. We're sorry, but it looks like there was an error. Please try again later or contact support if the issue persists."
                    )
            }
            
            // Configure and return an alert state with the error message.
            return AlertState(
                title: TextState( // Title for the alert
                    "Error"
                ),
                message: TextState( // The error message to display
                    message
                ),
                buttons: [
                    .cancel(
                        TextState( // Text for the cancel button
                            "OK"
                        ),
                        action: .send( // No specific action on cancel, just close the alert
                            .none
                        )
                    )
                ]
            )
        }
    )
    
    /// The test implementation of `ErrorClient` can be used during unit tests.
    /// It provides a predictable `AlertState` regardless of the input error.
    static let testValue = ErrorClient(
        error: { _ in
            // Return a default alert state for any error when testing.
            AlertState(
                // Title for the test alert
                title:
                    TextState(
                        "Error"
                    ),
                // Test error message
                message: (
                    TextState(
                        "Oops! Something went wrong. We're sorry, but it looks like there was an error. Please try again later or contact support if the issue persists."
                    )
                )
            )
        }
    )
}

