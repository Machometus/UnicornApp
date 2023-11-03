//
//  UnicornReducer.swift
//  UnicornApp
//
//  Created by Mohamed Salem on 17.10.23.
//

import Foundation
import ComposableArchitecture

/// A reducer that manages the state and actions of a single unicorn in the Composable Architecture.
struct UnicornReducer: Reducer {
    
    // MARK: State
    
    /// The state structure for the unicorn reducer.
    /// It conforms to `Equatable` for comparison and `Identifiable` for identification in a list.
    struct State: Equatable, Identifiable {
        
        /// A unique identifier for the unicorn, conforming to `Identifiable` protocol.
        /// This allows differentiation between unicorns, especially when used in a list or collection.
        let id: UUID
        
        /// The item representing the view state of a unicorn.
        /// This could include various properties of a unicorn that determine its representation in the view.
        let item: Unicorn
    }
    
    // MARK: Action
    
    /// The set of actions that can be taken on the unicorn's state.
    /// In this case, it's an empty enumeration as no actions have been defined.
    /// Typically, you'd see cases here that represent different events such as editing properties, deleting, etc.
    enum Action: Equatable {
        // Actions pertaining to the Unicorn entity will be defined here.
    }
    
    // MARK: Reducers
    
    /// The method that dictates how the state changes in response to actions.
    /// - Parameters:
    ///   - state: A reference to the current state of the unicorn that can be mutated in response to actions.
    ///   - action: The action that was dispatched, which may cause the state to change.
    /// - Returns: An `Effect` which is a description of work that can be performed asynchronously, and can send back actions.
    func reduce(
        into state: inout State,
        action: Action
    ) -> Effect<Action> {
        /// Here, you'd handle the different actions defined in `Action` and mutate the state accordingly.
        /// Since there are no actions currently defined, this function would not change the state.
        
        // As of now, no actions are defined, so we return `.none`, indicating that no side effects occur and no further actions are sent.
    }
}
