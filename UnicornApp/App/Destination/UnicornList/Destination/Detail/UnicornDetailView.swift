//
//  UnicornDetailView.swift
//  UnicornApp
//
//  Created by Mohamed Salem on 18.10.23.
//

import SwiftUI
import ComposableArchitecture

/// A SwiftUI View for displaying and editing the details of a Unicorn. 
/// It uses the Composable Architecture framework for managing the state of the UI and handling the interactions.
struct UnicornDetailView: View {
    
    // MARK: Store
    
    /// The store that holds the state for the Unicorn Detail and allows for the dispatch of actions.
    let store: StoreOf<UnicornDetailReducer>
    
    // MARK: body
    
    /// The body of the view which provides the visual structure of the Unicorn Detail view.
    var body: some View {
        
        WithViewStore(
            self.store,
            observe: { $0 }
        ) { 
            viewStore in
            
            /// Edit unicorn form
            UnicornForm(
                name: /// Unicorn name
                    viewStore.binding(
                        get: { $0.name },
                        send: UnicornDetailReducer.Action.nameChanged
                    ),
                flavour: /// Unicorn flavour
                    viewStore.binding(
                        get: { $0.flavour },
                        send: UnicornDetailReducer.Action.flavourChanged
                    ),
                action: { /// Unicorn action
                    viewStore.send(.save)
                }
            )
#if !SWIFTDATA
            .loading( /// Loading view
                viewStore.isLoading
            )
#endif
            .onAppear { /// View life cycle
                viewStore.send(
                    .onAppear
                )
            }
            .navigationTitle( /// View title
                "Edit Unicorn"
            )
            .toolbar { /// View toolbar
                UnicornDetailToolbar(
                    viewStore: viewStore
                )
            }
            .alert( /// Save/Delete unicorns error alert
                store:
                    self.store.scope(
                        state: \.$alert,
                        action: { .alert($0) }
                    )
            )
        }
    }
}

// MARK: - Preview

/// The preview section for the UnicornDetailView, showing a mocked-up view
#Preview {
    /// The preview of the UnicornDetailView using a mock Store initialized with default values.
    UnicornDetailView(
        store: Store(
            initialState:
                UnicornDetailReducer.State(
                    unicorn:
                        Unicorn(
                            name: "Pegasus",
                            flavour: .red
                        )
                ),
            reducer: {
                UnicornDetailReducer()
            }
        )
    )
}
