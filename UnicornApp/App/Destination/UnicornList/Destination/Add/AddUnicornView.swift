//
//  AddUnicornView.swift
//  UnicornApp
//
//  Created by Mohamed Salem on 20.10.23.
//

import SwiftUI
import ComposableArchitecture

/// A view for adding a new unicorn. It leverages the Composable Architecture for state management and handling user actions.
struct AddUnicornView: View {
    
    // MARK: Store
    
    /// The store for the `AddUnicornReducer` which manages the state and actions for adding a new unicorn.
    let store: StoreOf<AddUnicornReducer>
    
    // MARK: body
    
    /// The body of the view which provides the visual structure of the Add Unicorn view.
    var body: some View {
        
        WithViewStore(
            self.store,
            observe: { $0 }
        ) {
            viewStore in
            
            NavigationView {
                /// Add unicorn form
                UnicornForm(
                    name: /// Unicorn name
                        viewStore.binding(
                            get: { $0.name },
                            send: AddUnicornReducer.Action.nameChanged
                        ),
                    flavour: /// Unicorn flavour
                        viewStore.binding(
                            get: { $0.flavour },
                            send: AddUnicornReducer.Action.flavourChanged
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
                .navigationTitle( /// View title
                    "New Unicorn"
                )
                .toolbar { /// View toolbar
                    AddUnicornToolbar(
                        viewStore: viewStore
                    )
                }
                .alert( /// Add unicorn error alert
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

/// The preview provider for the AddUnicornView which is used to render the UI components within Xcode's canvas for development purposes.
#Preview {
    /// The preview of the AddUnicornView using a mock Store initialized with the default state.
    AddUnicornView(
        store: Store(
            initialState:
                AddUnicornReducer.State(),
            reducer: {
                AddUnicornReducer()
            }
        )
    )
}
