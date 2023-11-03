//
//  UnicornListToolbar.swift
//  UnicornApp
//
//  Created by Mohamed Salem on 23.10.23.
//

import SwiftUI
import ComposableArchitecture

/// A component of the user interface representing a toolbar specifically designed for the unicorn list view.
/// It provides buttons for actions such as refreshing the list or adding new unicorns.
struct UnicornListToolbar: ToolbarContent {
    
    // MARK: Store
    
    /// A `ViewStore` instance that allows the toolbar to send actions to the `UnicornListReducer`.
    /// The `UnicornListReducer` is responsible for handling the business logic of the unicorn list feature.
    let viewStore: ViewStoreOf<UnicornListReducer>
    
    // MARK: Body
    
    /// The content and layout of the toolbar.
    var body: some ToolbarContent {
        // Conditional compilation block to include this code only if SWIFTDATA is not defined.
#if !SWIFTDATA
        /// Refresh toolbar item which is intended for manual refreshing of the unicorn list.
        ToolbarItem(
            placement: .topBarLeading,
            content: {
                Button(
                    action: {
                        /// Sends the fetch action to the `UnicornListReducer` when the button is tapped.
                        /// This action is meant to trigger the loading of the latest unicorn data.
                        viewStore.send(
                            .fetch
                        )
                    },
                    label: {
                        Image(systemName: "arrow.clockwise")
                    }
                )
            }
        )
#endif
        /// Add toolbar item which is intended for adding a new unicorn to the list.
        ToolbarItem(
            placement: .topBarTrailing,
            content: {
                Button(
                    action: {
                        /// Sends the showAddUnicorn action with a true value to the `UnicornListReducer`.
                        /// This action is intended to open the interface for adding a new unicorn.
                        viewStore.send(
                            .showAddUnicorn(true)
                        )
                    },
                    label: {
                        Image(systemName: "plus")
                    }
                )
            }
        )
    }
}
