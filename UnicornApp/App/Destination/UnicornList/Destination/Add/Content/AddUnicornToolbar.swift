//
//  AddUnicornToolbar.swift
//  UnicornApp
//
//  Created by Mohamed Salem on 23.10.23.
//

import SwiftUI
import ComposableArchitecture

/// A structure that defines the toolbar content for adding a new unicorn.
struct AddUnicornToolbar: ToolbarContent {
    
    // MARK: Store
    
    /// The view store derived from `AddUnicornReducer`.
    /// It allows us to access and mutate the state and dispatch actions.
    let viewStore: ViewStoreOf<AddUnicornReducer>
    
    // MARK: Body
    
    /// Provides the content of the toolbar, conforming to `ToolbarContent`.
    /// The toolbar consists of a close button which when tapped will send a `.close` action
    /// to the reducer through the view store.
    var body: some ToolbarContent {
        ToolbarItem(
            placement: .navigationBarLeading,
            content: {
                Button(
                    action: {
                        /// Sends a `.close` action to the view store, which should handle this action in the reducer
                        /// to close the current view or dismiss the sheet/modal that is presenting this view.
                        viewStore.send(
                            .close
                        )
                    },
                    label: {
                        Image(systemName: "xmark")
                    }
                )
            }
        )
    }
}
