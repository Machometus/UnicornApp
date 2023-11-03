//
//  UnicornDetailReducer.swift
//  UnicornApp
//
//  Created by Mohamed Salem on 18.10.23.
//

import Foundation
import ComposableArchitecture

/// Manages the state and actions for the detailed view of a specific unicorn.
struct UnicornDetailReducer: Reducer {
    
    // MARK: State
    
    /// Represents the state for the Unicorn Detail View.
    struct State: Equatable {
        
        /// The unicorn being displayed or edited.
        var unicorn: Unicorn
        
        /// The edited name of the unicorn.
        var name: String = ""
        
        /// The selected flavour for the unicorn from a predefined list of flavours.
        var flavour: Flavour = .red
        
        /// Indicates whether a network request is currently in progress.
        var isLoading: Bool = false
        
        /// An optional alert state that may contain an alert triggered by an error.
        @PresentationState var alert: AlertState<ErrorClient.Alert>?
    }
    
    // MARK: Action
    
    /// Actions that can be taken in the Unicorn Detail View.
    enum Action: Equatable {
        
        /// Triggered when the detail view is presented.
        case onAppear
        
        /// Represents a change in the unicorn's name from user input.
        case nameChanged(String)
        
        /// Represents a change in the unicorn's flavour from user selection.
        case flavourChanged(Flavour)
        
        /// Starts the process to save the current unicorn details.
        case save
        
        /// Handles the outcome of the save attempt.
        case saveResponse(TaskResult<Bool>)
        
        /// Starts the process to delete the current unicorn.
        case delete
        
        /// Handles the outcome of the delete attempt.
        case deleteResponse(TaskResult<Bool>)
        
        /// Used to manage alert presentations for errors.
        case alert(PresentationAction<ErrorClient.Alert>)
    }
    
    // MARK: Dependencies
    
    /// Dependency for making API calls related to unicorns.
    @Dependency(\.unicornClient) var unicornClient
    
    /// Dependency for error handling, particularly for creating alert states.
    @Dependency(\.errorClient) var errorClient
    
    // MARK: Reducers
    
    /// The body of the reducer, handling actions by modifying state or triggering side effects.
    var body: some ReducerOf<Self> {
        Reduce {
            state, action in
            switch action {
            /// View life cycle
            case .onAppear:
                state.name = state.unicorn.name
                state.flavour = state.unicorn.flavour
                return .none
                
            /// Unicorn
            /// Unicorn name change action
            case let .nameChanged(text):
                state.name = text
                return .none
            /// Unicorn flavour change action
            case let .flavourChanged(flavour):
                state.flavour = flavour
                return .none
                
            /// Save unicorn send & response
            case .save, .saveResponse:
                return handleSave(
                    for: action,
                    state: &state,
                    using: unicornClient
                )
                
            /// Delete unicorn send & response
            case .delete, .deleteResponse:
                return handleDelete(
                    for: action,
                    state: &state,
                    using: unicornClient
                )
            /// Save/Delete error alert action
            case .alert:
                return .none
            }
        }
        /// Unicorn save/delete error alert reducer
        .ifLet(
            \.$alert,
             action: /Action.alert
        )
    }
}

// MARK: - Reducer Extension

/// Extensions for `UnicornDetailReducer` handle saving unicorns
/// to an external service and processing the responses.
extension UnicornDetailReducer {
    
    /// Initiates the save process for a unicorn.
    ///
    /// - Parameters:
    ///   - action: The action that triggers the save process.
    ///   - state: A reference to the current state of the detail view.
    ///   - client: The unicorn client used for making the API call to update the unicorn.
    /// - Returns: An effect that will send a `saveResponse` action after attempting to save the unicorn.
    
    func handleSave(
        for action: Action,
        state: inout State,
        using client: UnicornClient
    ) -> Effect<Action> {
        
        switch action {
        /// Save unicorn action
        case .save:
            state.isLoading = true
            
            let unicorn = state.unicorn
            let name = state.name
            let flavour = state.flavour
            return .run { send in
                await send(
                    .saveResponse(
                        TaskResult {
                            try await client.update(
                                unicorn,
                                name,
                                flavour
                            )
                        }
                    )
                )
            }
        /// Save unicorn response (success & failure)
        case let .saveResponse(response):
            return handleSaveResponse(
                response,
                state: &state
            )
            
        default:
            return .none
        }
    }
    
    /// Processes the save response, updating state accordingly.
    ///
    /// - Parameters:
    ///   - response: The result of the save operation, indicating success or failure.
    ///   - state: A reference to the current state of the detail view.
    /// - Returns: An effect that could trigger additional actions based on the response.
    
    func handleSaveResponse(
        _ response: TaskResult<Bool>,
        state: inout State
    ) -> Effect<Action> {
        
        state.isLoading = false
        
        switch response {
        /// Success response
        case .success:
            return .none
         
        /// Failure response
        case .failure(let error):
            state.alert = errorClient.error( /// Edit error alert
                error
            )
        }
        
        return .none
    }
}

// MARK: - Reducer Extension

/// Extensions for `UnicornDetailReducer` handle deleting unicorns
/// to an external service and processing the responses.
extension UnicornDetailReducer {
    
    /// Initiates the deletion process for a unicorn.
    ///
    /// - Parameters:
    ///   - action: The action that triggers the deletion process.
    ///   - state: A reference to the current state of the detail view.
    ///   - client: The unicorn client used for making the API call to delete the unicorn.
    /// - Returns: An effect that will send a `deleteResponse` action after attempting to delete the unicorn.
    
    func handleDelete(
        for action: Action,
        state: inout State,
        using client: UnicornClient
    ) -> Effect<Action> {
        
        switch action {
        /// Delete unicorn action
        case .delete:
            state.isLoading = true
            
            let unicorn = state.unicorn
            return .run { send in
                await send(
                    .deleteResponse(
                        TaskResult {
                            try await unicornClient.delete(unicorn)
                        }
                    )
                )
            }
        /// Delete unicorn response (success & failure)
        case let .deleteResponse(response):
            return handleDeleteResponse(
                response,
                state: &state
            )
            
        default:
            return .none
        }
    }
    
    /// Processes the delete response, updating state accordingly.
    ///
    /// - Parameters:
    ///   - response: The result of the delete operation, indicating success or failure.
    ///   - state: A reference to the current state of the detail view.
    /// - Returns: An effect that could trigger additional actions based on the response.
    
    func handleDeleteResponse(
        _ response: TaskResult<Bool>,
        state: inout State
    ) -> Effect<Action> {
        
        state.isLoading = false
        
        switch response {
        /// Success response
        case .success:
            return .none
         
        /// Failure response
        case .failure(let error):
            state.alert = errorClient.error( /// Delete error alert
                error
            )
        }
        
        return .none
    }
}
