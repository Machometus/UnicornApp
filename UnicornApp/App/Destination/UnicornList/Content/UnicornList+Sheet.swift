//
//  UnicornList+Sheet.swift
//  UnicornApp
//
//  Created by Mohamed Salem on 23.10.23.
//

import SwiftUI
import ComposableArchitecture

/// Extension on View to provide the functionality of presenting a sheet for adding a unicorn.
extension View {
    
    // MARK: View builder
    
    /// addUnicornSheet
    ///
    /// Provides a method to present a sheet that allows the user to add a new unicorn. The sheet is presented based on
    /// a specific state variable within the `UnicornListReducer`'s state and is managed by the `ViewStore`.
    ///
    /// - Parameters:
    ///   - store: The `Store` that holds the state of the `UnicornListReducer`. This `Store` is scoped to the particular
    ///     piece of state and actions that the `AddUnicornView` cares about.
    ///   - viewStore: A `ViewStore` that allows the view to read data from the state and send actions back to the store.
    ///
    /// The method uses a binding to the `isAddUnicornPresented` state to control whether the sheet is shown. When the state
    /// is true, the sheet is presented. The content of the sheet is created using the `IfLetStore` to safely unwrap the
    /// `addUnicorn` optional state. If it is present, the `AddUnicornView` is constructed with a scoped store.
    ///
    /// The method uses a `@ViewBuilder` attribute, which allows the body to return different view types based on the condition.
    ///
    /// - Returns: A view that conditionally presents a sheet for adding a unicorn.
    @ViewBuilder
    func addUnicornSheet(
        _ store: StoreOf<UnicornListReducer>,
        with viewStore: ViewStoreOf<UnicornListReducer>
    ) -> some View {
        
        self.sheet(
            /// Binding to determine whether the sheet is presented. It uses the view store to create a binding
            /// to the `isAddUnicornPresented` property in the state, and it handles the dismiss action by sending
            /// the `showAddUnicorn` action with a false value.
            isPresented:
                viewStore.binding(
                    get: \.isAddUnicornPresented,
                    send: UnicornListReducer.Action.showAddUnicorn
                ),
            /// The content of the sheet.
            /// Uses the `IfLetStore` utility provided by the Composable Architecture to unwrap the optional
            /// `addUnicorn` state and provide a scoped store to the `AddUnicornView` if it is available.
            content: {
                IfLetStore(
                    store.scope(
                        state: \.addUnicorn,
                        action: UnicornListReducer.Action.addUnicorn
                    ),
                    then: {
                        /// The view that allows users to add a new unicorn. It receives a scoped store
                        /// that only contains the relevant state and actions for adding a unicorn.
                        AddUnicornView(store: $0)
                    }
                )
            }
        )
    }
}
