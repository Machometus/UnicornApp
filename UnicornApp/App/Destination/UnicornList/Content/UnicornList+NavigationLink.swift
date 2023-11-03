//
//  UnicornCell+NavigationLink.swift
//  UnicornApp
//
//  Created by Mohamed Salem on 23.10.23.
//

import SwiftUI
import ComposableArchitecture

/// Provides navigation functionality to the UnicornCell within the context of the Composable Architecture.
extension UnicornCell {
    
    // MARK: View builder
    
    /// navigationLink
    ///
    /// Creates a navigation link bound to a specific piece of state within the `UnicornListReducer`. The navigation
    /// link allows the user to navigate to the details of a unicorn when a cell is tapped.
    ///
    /// - Parameters:
    ///   - store: The `Store` that holds the overall state of the `UnicornListReducer`.
    ///   - viewStore: A `ViewStore` that allows the view to read data from the overall state and send actions back to the store.
    ///   - item: The individual `StoreOf<UnicornReducer>` that contains the state and actions for a single unicorn item.
    ///
    /// This function wraps the `UnicornCell` in a `NavigationLink` that is conditionally presented based on the state
    /// controlled by `UnicornListReducer`. It uses `WithViewStore` to access the `UnicornReducer`'s state within the `item` store.
    ///
    /// The `NavigationLink` is uniquely identified by the unicorn's ID (via the `tag`), and its presentation is bound to the `selection` state
    /// in the `UnicornListReducer`. When the selection changes, an action is sent to update the detail view.
    ///
    /// The destination of the `NavigationLink` is a `UnicornDetailView`, provided that the `selection` state exists. This is done using
    /// `IfLetStore` to unwrap the optional `selection` state safely.
    ///
    /// The `label` of the `NavigationLink` is the `UnicornCell` itself, effectively making the entire cell the tappable area for navigation.
    ///
    /// - Returns: A view that creates a navigation link for navigating to the detailed view of a unicorn.
    @ViewBuilder
    func navigationLink(
        store: StoreOf<UnicornListReducer>,
        viewStore: ViewStoreOf<UnicornListReducer>,
        item: StoreOf<UnicornReducer>
    ) -> some View  {
        
        /// Uses WithViewStore to observe the state of the individual unicorn item.
        WithViewStore(
            item,
            observe: { $0 }
        ) {
            row in
            
            /// NavigationLink that binds to the `selection` state within the `UnicornListReducer`.
            /// The `tag` parameter uses the unicorn's ID to uniquely identify this link.
            NavigationLink(
                tag: row.id, /// navigation link tag is UnicornReducer.State.ID?
                selection: /// navigation link selection binding
                    viewStore.binding(
                        get: \.selection?.id,
                        send: UnicornListReducer.Action.showUnicornDetail
                    ),
                destination: {
                    /// If the `selection` state is non-nil, scopes the store to provide a `UnicornDetailView`.
                    IfLetStore(
                        store.scope(
                            state: \.selection?.value,
                            action: UnicornListReducer.Action.unicornDetail
                        ),
                        then: {
                            /// The detail view for the selected unicorn item.
                            UnicornDetailView(
                                store: $0
                            )
                        }
                    )
                },
                label: {
                    /// The `UnicornCell` view itself, which is used as the navigation link's label.
                    self
                }
            )
        }
    }
}
