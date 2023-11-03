//
//  AddUnicornReducer.swift
//  UnicornApp
//
//  Created by Mohamed Salem on 20.10.23.
//

import Foundation
import ComposableArchitecture

/// `AddUnicornReducer` is responsible for handling the logic to add a new unicorn.
/// It manages the state of the unicorn creation form, processes the save action, and handles any resulting alerts.
struct AddUnicornReducer: Reducer {
    
    // MARK: State
    
    /// `State` represents the state required for the Add Unicorn view.
    struct State: Equatable {
        
        /// The name of the unicorn being added.
        var name: String = ""
        
        /// The flavour of the unicorn being added, defaulted to `.red`.
        var flavour: Flavour = .red
        
        /// Boolean indicating if the unicorn addition is in progress.
        var isLoading: Bool = false
        
        /// An optional alert state for presenting errors during unicorn addition.
        @PresentationState var alert: AlertState<ErrorClient.Alert>?
    }
    
    // MARK: Action
    
    /// `Action` enumerates the actions that the `AddUnicornReducer` can process.
    enum Action: Equatable {
        
        /// Updates the name of the unicorn in the state.
        case nameChanged(String)
        
        /// Updates the flavour of the unicorn in the state.
        case flavourChanged(Flavour)
        
        /// Initiates the save unicorn process.
        case save
        
        /// Handles the response from the save unicorn process.
        case saveResponse(TaskResult<Bool>)
        
        /// Action to close the add unicorn view.
        case close
        
        /// Actions related to error alert presentation.
        case alert(PresentationAction<ErrorClient.Alert>)
    }
    
    // MARK: Dependencies
    
    /// Dependency for making API calls related to unicorns.
    @Dependency(\.unicornClient) var unicornClient
    
    /// Dependency for error handling, particularly for creating alert states.
    @Dependency(\.errorClient) var errorClient
    
    // MARK: Reducers
    
    /// The `body` is a reducer builder that defines how the state changes in response to actions.
    var body: some ReducerOf<Self> {
        Reduce {
            state, action in
            
            switch action {
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
                
            /// Close add unicorn action
            case .close:
                return .none
                
            /// Add error alert action
            case .alert:
                return .none
            }
        }
        /// Add unicorn error alert reducer
        .ifLet(
            \.$alert,
             action: /Action.alert
        )
    }
}

// MARK: - Reducer Extension

/// Extensions for `AddUnicornReducer` handle saving unicorns
/// to an external service and processing the responses.
extension AddUnicornReducer {
    
    /// Initiates the process of saving a unicorn and handles the response.
    /// - Parameters:
    ///   - action: The action to be handled, expected to be either `.save` or `.saveResponse`.
    ///   - state: A reference to the current state, which will be mutated according to the action's effect.
    ///   - client: The `UnicornClient` used to interact with the API to save the unicorn.
    /// - Returns: An `Effect` that may dispatch a `.saveResponse` action depending on the outcome of the API call.
    
    func handleSave(
        for action: Action,
        state: inout State,
        using client: UnicornClient
    ) -> Effect<Action> {
        
        switch action {
        /// Save unicorn action
        case .save:
            state.isLoading = true
            
            let unicorn = Unicorn(
                name: state.name, 
                flavour: state.flavour
            )
            return .run { send in
                await send(
                    .saveResponse(
                        TaskResult {
                            try await client.add(unicorn)
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
    
    /// Processes the result of the unicorn save operation.
    /// - Parameters:
    ///   - response: The result of the unicorn saving task, either success or failure.
    ///   - state: A reference to the current state, which will be mutated based on the response.
    /// - Returns: An `Effect` that triggers state updates and UI responses such as presenting an alert.
    
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
            state.alert = errorClient.error( /// Add error alert
                error
            )
        }
        
        return .none
    }
}
