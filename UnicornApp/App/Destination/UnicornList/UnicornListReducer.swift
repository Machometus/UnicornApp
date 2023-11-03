//
//  UnicornListReducer.swift
//  UnicornApp
//
//  Created by Mohamed Salem on 17.10.23.
//

import Foundation
import ComposableArchitecture

/// Manages the state and actions of a list of unicorns in a composable and scalable manner.
struct UnicornListReducer: Reducer {
    
    // MARK: State
    
    /// Represents the current state of the unicorn list in the application.
    struct State: Equatable {

        /// Represents the current state of the unicorn list in the application.
        var items: IdentifiedArrayOf<UnicornReducer.State> = []
        
        /// Indicates whether the UI for adding a new unicorn is being presented.
        var isAddUnicornPresented: Bool = false
        
        /// Holds the state for adding a new unicorn when the view is presented.
        var addUnicorn: AddUnicornReducer.State?
        
        /// Controls the selection of a unicorn, possibly triggering navigation to a detailed view.
        var selection: Identified<UnicornReducer.State.ID, UnicornDetailReducer.State?>?
        
        /// Tracks whether a loading process is ongoing, such as fetching or saving unicorns.
        var isLoading: Bool = false
        
        /// Holds the state for an alert, generally used for displaying errors.
        @PresentationState var alert: AlertState<ErrorClient.Alert>?
    }
    
    // MARK: Action
    
    /// Defines the actions that can affect the unicorn list state.
    enum Action: Equatable {
        
        /// This allows the reducer to handle actions specific to a single unicorn.
        case item(
            id: UnicornReducer.State.ID,
            action: UnicornReducer.Action
        )
        
        /// Initiates the fetch process, signaling the need to load unicorns from a repository or API.
        case fetch

        /// Carries the outcome of the fetch operation, encapsulating success with the unicorns list or failure with an error./
        case fetchResponse(TaskResult<[Unicorn]>)
        
        /// Controls whether the add unicorn view should be presented or dismissed.
        case showAddUnicorn(_ isPresented: Bool)

        /// Encapsulates actions that occur on the add unicorn screen, such as submitting the new unicorn data./
        case addUnicorn(AddUnicornReducer.Action)
        
        /// Sets or clears the currently selected unicorn ID, affecting navigation to the detail view.
        case showUnicornDetail(selection: UnicornReducer.State.ID?)

        /// Represents actions within the unicorn detail view, such as saving edits or deleting the unicorn./
        case unicornDetail(UnicornDetailReducer.Action)
        
        /// Responsible for showing and dismissing alerts, including constructing alerts from errors./
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
            /// Unicorn item action
            case .item:
                return .none
            
            /// Fetch unicorns send & response
            case .fetch, .fetchResponse:
                return handleFetch(
                    for: action,
                    state: &state,
                    using: unicornClient
                )
            
            /// Show/Reduce add unicorn action
            /// Show add unicorn
            case .showAddUnicorn(let isPresented):
                state.isAddUnicornPresented = isPresented
                state.addUnicorn = AddUnicornReducer.State()
                return .none
            /// Add unicorn action
            case .addUnicorn(let action):
                return handleAddUnicorn(
                    action,
                    state: &state
                )
                
            /// Show/Reduce unicorn detail action
            /// Show unicorn detail
            case .showUnicornDetail(let selection):
                guard let id = selection, 
                        let item = state.items[id: id]?.item 
                else {
                    state.selection = nil
                    return .none
                }
                let UnicornDetail = UnicornDetailReducer.State(
                    unicorn: item
                )
                state.selection = Identified(UnicornDetail, id: id)
                return .none
            /// Unicorn detail action
            case .unicornDetail(let action):
                return handleUnicornDetail(
                    action,
                    state: &state
                )
            /// Fetch error alert action
            case .alert:
              return .none
            }
        }
        /// Unicron items reducers
        .forEach(
            \.items,
             action: /Action.item(id:action:),
             element: {
                 UnicornReducer()
             }
        )
        /// Add unicorn reducer
        .ifLet(
            \.addUnicorn,
             action: /Action.addUnicorn,
             then: {
                 AddUnicornReducer()
             }
        )
        /// Unicorn detail reducer
        .ifLet(
            \State.selection,
             action: /Action.unicornDetail,
             then: {
                 EmptyReducer()
                     .ifLet(
                        \Identified<UnicornReducer.State.ID, UnicornDetailReducer.State?>.value,
                         action: .self,
                         then: {
                             UnicornDetailReducer()
                         }
                     )
             }
        )
        /// Unicorn fetch error alert reducer
        .ifLet(
            \.$alert,
             action: /Action.alert
        )
    }
}

// MARK: - Reducer Extension

/// Handles actions related to the fetching of unicorns and processes their responses.
extension UnicornListReducer {
    
    /// Handles actions that initiate and respond to the fetching of unicorns.
    ///
    /// - Parameters:
    ///   - action: The action to be processed, which can be initiating a fetch or processing its response.
    ///   - state: The current state of the unicorn list, which will be mutated according to the action.
    ///   - client: The `UnicornClient` responsible for performing unicorn fetch operations.
    /// - Returns: An effect that may send a new action based on the outcome of the fetch.
    
    func handleFetch(
        for action: Action,
        state: inout State,
        using client: UnicornClient
    ) -> Effect<Action> {
        
        switch action {
        /// Fetch unicorns action
        case .fetch:
            state.isLoading = true
            return .run { send in
                await send(
                    .fetchResponse(
                        TaskResult {
                            try await unicornClient.getAll()
                        }
                    )
                )
            }
        /// Fetch unicorns response (success & failure)
        case let .fetchResponse(response):
            return handleFetchResponse(
                response,
                state: &state
            )
            
        default:
            return .none
        }
    }
    
    /// Processes the response from the fetch attempt, updating the state accordingly.
    ///
    /// - Parameters:
    ///   - response: The result of the fetch operation, indicating success with an array of unicorns or failure with an error.
    ///   - state: A reference to the current state of the unicorn list, which will be updated based on the response.
    /// - Returns: An effect that could trigger additional actions but in this case, does not.
    
    func handleFetchResponse(
        _ response: TaskResult<[Unicorn]>,
        state: inout State
    ) -> Effect<Action> {
        
        state.isLoading = false
        
        switch response {
        /// Success response
        case .success(let unicorns):
            let unicornsState = unicorns.map {
                item in
                
                UnicornReducer.State(
                    id: item.id,
                    item: item
                )
            }
            state.items = IdentifiedArray(
                uniqueElements: unicornsState
            )
         
        /// Failure response
        case .failure(let error):
            state.alert = errorClient.error( /// Fetch error alert
                error
            )
        }
        
        return .none
    }
}

// MARK: - Reducer Extension

/// Handles actions related to adding a unicorn.
extension UnicornListReducer {
    
    /// Processes actions that are related to the 'Add Unicorn' functionality.
    ///
    /// - Parameters:
    ///   - action: The action to be processed, which can be either closing the add screen or a response from an add attempt.
    ///   - state: The current state of the unicorn list, which will be mutated according to the action.
    /// - Returns: An effect that may send a new action based on the outcome of the add operation.
    
    func handleAddUnicorn(
        _ action: AddUnicornReducer.Action,
        state: inout State
    ) -> Effect<Action> {
        
        switch action {
        /// Close add unicorn action
        case .close:
            state.isAddUnicornPresented = false
            
        /// Save add unicorn action
        case .saveResponse (let response):
            return handleAddResponse(
                response,
                state: &state
            )
            
        /// Other add unicorn actions
        default:
            return .none
        }
        
        return .none
    }
    
    /// Processes the response from the add unicorn attempt, updating the state accordingly.
    ///
    /// - Parameters:
    ///   - response: The result of the add operation, indicating success or failure.
    ///   - state: A reference to the current state of the unicorn list, which will be updated based on the response.
    /// - Returns: An effect that may send a fetch action to reload the unicorns list on success.
    
    func handleAddResponse(
        _ response: TaskResult<Bool>,
        state: inout State
    ) -> Effect<Action> {
        
        switch response {
        /// Success response
        case .success:
            state.isAddUnicornPresented = false
            return .send(
                .fetch
            )
         
        /// Failure response
        case .failure:
            return .none
        }
    }
}

// MARK: - Reducer Extension

/// Handles actions related to unicorn detail operations.
extension UnicornListReducer {
    
    /// Processes actions related to unicorn detail view operations like saving or deleting.
    ///
    /// - Parameters:
    ///   - action: The action from the detail view, either a save or delete response.
    ///   - state: The current state of the unicorn list, which may be mutated according to the action.
    /// - Returns: An effect that may merge multiple actions such as clearing the detail view and refreshing the list.
    
    func handleUnicornDetail(
        _ action: UnicornDetailReducer.Action,
        state: inout State
    ) -> Effect<Action> {
        
        switch action {
        /// Save/Delete unicorn detail action
        case .saveResponse(let response),
                .deleteResponse(let response):
            
            return handleDetailResponse(
                response,
                state: &state
            )
            
        /// Other unicorn detail actions
        default:
            return .none
        }
    }
    
    /// Processes the responses from save or delete operations on unicorn details, updating the state accordingly.
    ///
    /// - Parameters:
    ///   - response: The result of the save or delete operation, indicating success or failure.
    ///   - state: A reference to the current state of the unicorn list, which will be updated based on the response.
    /// - Returns: An effect that may send actions to close the detail view and to refresh the unicorn list on success.
    
    func handleDetailResponse(
        _ response: TaskResult<Bool>,
        state: inout State
    ) -> Effect<Action> {
        
        switch response {
        /// Success response
        case .success:
            return .merge(
                .send(
                    .showUnicornDetail(
                        selection: nil
                    )
                ),
                .send(
                    .fetch
                )
            )
         
        /// Failure response
        case .failure:
            return .none
        }
    }
}
