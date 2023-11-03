//
//  ContactReducer.swift
//  UnicornApp
//
//  Created by Mohamed Salem on 17.10.23.
//

import Foundation
import ComposableArchitecture

/// The `ContactReducer` is responsible for handling actions related to contact information,
/// specifically for opening social media links. It conforms to the `Reducer` protocol from the Composable Architecture.
struct ContactReducer: Reducer {
    
    // MARK: State
    
    /// The `State` struct for the `ContactReducer` represents the state this reducer handles.
    /// Since this reducer doesn't manage any stateful data, the `State` is empty and conforms to `Equatable`.
    struct State: Equatable { }
    
    // MARK: Action
    
    /// The `Action` enum defines actions that the `ContactReducer` knows how to handle.
    /// Each case corresponds to a user interaction with the social media contact information.
    enum Action: Equatable {
        
        /// Represents an action to open the user's LinkedIn profile.
        case linkedin
        
        /// Represents an action to open the user's Xing profile.
        case xing
        
        /// Represents an action to open the user's Twitter feed./
        case twitter
    }
    
    // MARK: Dependencies
    
    /// A dependency provided by the `ComposableArchitecture` which allows for opening URLs.
    /// It can be overridden for testing or mocking purposes.
    @Dependency(\.urlOpenerClient) var urlOpenerClient
    
    // MARK: Reducers
    
    /// The `reduce` function takes the current state and an action
    /// and decides how to change the state and which effects to run.
    func reduce(
        into state: inout State,
        action: Action
    ) -> Effect<Action> {
        
        switch action {
        /// Show LinkedIn action
        case .linkedin:
            urlOpenerClient.open(
                "https://www.linkedin.com/in/machometus/" /// LinkedIn link
            )
        /// Show Xing action
        case .xing:
            urlOpenerClient.open(
                "https://www.xing.com/profile/Mohamed_Salem19" /// Xing link
            )
        /// Show Twitter action
        case .twitter:
            urlOpenerClient.open(
                "https://twitter.com/MSalemsson" /// Twitter link
            )
        }
        
        return .none
    }
}
