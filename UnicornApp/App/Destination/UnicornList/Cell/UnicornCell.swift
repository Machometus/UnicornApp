//
//  UnicornCell.swift
//  UnicornApp
//
//  Created by Mohamed Salem on 17.10.23.
//

import SwiftUI
import ComposableArchitecture

/// A view component that displays information about a unicorn in a cell format.
struct UnicornCell: View {
    
    // MARK: Store
    
    /// A `Store` that holds the state of the unicorn and allows dispatching of actions.
    /// The store is specialized with `UnicornReducer` which manages the unicorn logic.
    let store: StoreOf<UnicornReducer>
    
    // MARK: body
    
    /// The body of the `UnicornCell`. It observes the state from the store and renders the UI accordingly.
    var body: some View {
        /// `WithViewStore` is a helper that allows the view to read state from the `store`
        /// and send actions in response to user input.
        WithViewStore(
            self.store,
            observe: { $0 }
        ) { 
            viewStore in
            
            /// Horizontal stack composing the cell content.
            HStack {
                /// Displays the flavour image.
                viewStore.item.flavour.image
                    .mediumStyle()
                
                /// Displays the name of the unicorn.
                Text(
                    viewStore.item.name
                )
                .largeTitleStyle(
                    viewStore.item.flavour.color
                )
            }
            /// An alignment guide modifier is used here to align the leading separator edge of the cell's content.
            /// `d` represents the view dimensions, and the content is aligned to the leading edge.
            .alignmentGuide(
                .listRowSeparatorLeading
            ) {
                d in
                d[.leading]
            }
        }
    }
}

// MARK: - Preview

#Preview {
    /// Provides a preview of the `UnicornCell`.
    List {
        /// Generates a cell for each flavour, using `UnicornReducer.State` to create the initial state.
        ForEach(
            Flavour.allCases,
            id: \.rawValue,
            content: {
                flavour in
                
                UnicornCell(
                    store: Store(
                        initialState:
                            UnicornReducer.State(
                                id: UUID(),
                                item:
                                    Unicorn.cassiopeia
                            ),
                        reducer: {
                            UnicornReducer()
                        }
                    )
                )

            }
        )
    }
}
