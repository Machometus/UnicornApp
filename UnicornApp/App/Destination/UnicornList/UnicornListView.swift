//
//  UnicornListView.swift
//  UnicornApp
//
//  Created by Mohamed Salem on 17.10.23.
//

import SwiftUI
import ComposableArchitecture

/// A SwiftUI View for displaying a list of Unicorns. It adheres to the
/// Composable Architecture framework for managing the state of the UI and
/// the interactions within it.
struct UnicornListView: View {
    
    // MARK: Store
    
    /// The store that holds the state for the Unicorn List and allows for the dispatch of actions.
    let store: StoreOf<UnicornListReducer>
    
    // MARK: body
    
    /// The body of the view which provides the visual structure of the Unicorn List view.
    var body: some View {
        
        WithViewStore(
            self.store,
            observe: { $0 }
        ) {
            viewStore in
            
            NavigationView {
                /// A list that displays the unicorns using a ForEachStore,
                /// which creates a new view for each item in the list.
                List {
                    ForEachStore(
                        self.store.scope(
                            state: \.items,
                            action: UnicornListReducer.Action.item
                        ),
                        content: {
                            /// Unicorn list cell
                            UnicornCell(
                                store: $0
                            )
                            .navigationLink( /// Turning list cell into a navigation link
                                store: self.store,
                                viewStore: viewStore,
                                item: $0
                            )
                        }
                    )
                }
                .Empty( /// Empty unicorn list view
                    viewStore
                )
#if !SWIFTDATA
                .loading( /// Loading view
                    viewStore.isLoading
                )
#endif
                .onStart { /// View life cycle
                    viewStore.send(
                        .fetch
                    )
                }
                .navigationTitle( /// View title
                    "Unicorns"
                )
                .toolbar { /// View toolbar
                    UnicornListToolbar(
                        viewStore: viewStore
                    )
                }
                .addUnicornSheet( /// Add unicorn sheet
                    store,
                    with: viewStore
                )
                .alert( /// Fetch unicorns error alert
                    store:
                        self.store.scope(
                            state: \.$alert,
                            action: { .alert($0) }
                        )
                )
            }
        }
    }
}

// MARK: - Preview

/// The preview section for the UnicornListView, showing a mocked-up view
#Preview {
    /// The preview of the UnicornListView using a mock Store initialized with default values.
    UnicornListView(
        store: Store(
            initialState:
                UnicornListReducer.State(),
            reducer: {
                UnicornListReducer()
            }
        )
    )
}
