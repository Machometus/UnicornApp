//
//  RootReducer.swift
//  UnicornApp
//
//  Created by Mohamed Salem on 17.10.23.
//

import Foundation
import ComposableArchitecture

/// `RootReducer` manages the state and actions at the application's root level.
/// It handles navigation between different tabs and their associated content.
struct RootReducer: Reducer {
    
    // MARK: State
    
    /// `State` holds the root level state, tracking the selected tab and encapsulating the states
    /// for individual tabs such as unicorns and contact information.
    struct State: Equatable {
        
        /// Holds the currently selected tab.
        var selected = Tab.unicorns
        
        /// State for the unicorns list, handled by `UnicornListReducer`.
        var unicorns = UnicornListReducer.State()
        
        /// State for the contact information, handled by `ContactReducer`.
        var contact = ContactReducer.State()
    }
    
    // MARK: Action
    
    /// `Action` enumerates the actions that can be taken at the root level,
    /// such as selecting a tab or handling sub-actions for each content tab.
    enum Action: Equatable {
        
        /// Action to change the currently selected tab.
        case select(Tab)
        
        /// Actions forwarded to the `UnicornListReducer`.
        case unicorns(UnicornListReducer.Action)
        
        /// Actions forwarded to the `ContactReducer`.
        case contact(ContactReducer.Action)
    }
    
    // MARK: Tab Items
    
    /// `Tab` identifies each tab in the app, such as unicorns and contact.
    enum Tab {
        
        /// Identifies the unicorns tab.
        case unicorns
        
        /// Identifies the contact information tab.
        case contact
    }
    
    // MARK: Reducers
    
    /// `body` defines how the `RootReducer` responds to actions and transforms the state.
    var body: some ReducerOf<Self> {
        Reduce {
            state, action in
            
            switch action {
            /// Select tab action
            case .select(let tab):
                state.selected = tab
                return .none
                
            /// Unicrons action
            case .unicorns:
                return .none
            /// Contact action
            case .contact:
                return .none
            }
        }
        /// Unicrons reducer
        Scope(
            state: \.unicorns,
            action: /Action.unicorns
        ) {
            UnicornListReducer()
        }
        /// Contact reducer
        Scope(
            state: \.contact,
            action: /Action.contact
        ) {
            ContactReducer()
        }
    }
}
