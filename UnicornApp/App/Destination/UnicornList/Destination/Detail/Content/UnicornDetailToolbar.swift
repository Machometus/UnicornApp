//
//  UnicornDetailToolbar.swift
//  UnicornApp
//
//  Created by Mohamed Salem on 23.10.23.
//

import SwiftUI
import ComposableArchitecture

/// Defines the toolbar content for the unicorn detail view.
struct UnicornDetailToolbar: ToolbarContent {
    
    // MARK: Store
    
    /// The view store derived from `UnicornDetailReducer`.
    /// It's used to access and mutate the state and send actions.
    let viewStore: ViewStoreOf<UnicornDetailReducer>
    
    // MARK: Body
    
    /// Provides the content of the toolbar, conforming to `ToolbarContent`.
    ///
    /// In this toolbar, a delete button is provided as a `ToolbarItem`. When tapped,
    /// it sends a `.delete` action to the reducer through the view store.
    var body: some ToolbarContent {
        /// Delete toolbar item
        ToolbarItem(
            placement: .topBarTrailing,
            content: {
                Button(
                    action: {
                        /// Sends a `.delete` action to the view store, which is expected to handle this action in the reducer.
                        viewStore.send(
                            .delete
                        )
                    },
                    label: {
                        Image(
                            systemName: "trash"
                        )
                    }
                )
            }
        )
    }
}
