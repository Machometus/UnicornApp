//
//  RootView.swift
//  UnicornApp
//
//  Created by Mohamed Salem on 16.10.23.
//

import SwiftUI
import ComposableArchitecture

/// `RootView` is the main view of the application that hosts the tab view interface.
/// It utilizes the `RootReducer` to manage its state and handle the actions triggered from its tabs.
struct RootView: View {
    
    // MARK: Store
    
    /// The store holds the `RootReducer` which manages the state for the tab views and their respective content.
    let store: StoreOf<RootReducer>
    
    // MARK: body
    
    /// The body property defines the view's UI structure.
    var body: some View {
        
        WithViewStore(
            self.store,
            observe: { $0 }
        ) {
            viewStore in
            
            /// Root tab view
            TabView(
                selection:
                    viewStore.binding(
                        get: \.selected,
                        send: RootReducer.Action.select
                    )
                ,
                content: {
                    /// Unicorn list view tab
                    UnicornListView(
                        store:
                            self.store.scope(
                                state: \.unicorns,
                                action: RootReducer.Action.unicorns
                            )
                    )
                    .tabItem {
                        Image(.list)
                        Text("Unicorns")
                    }
                    .tag(RootReducer.Tab.unicorns)
                    
                    /// Contact view tab
                    ContactView(
                        store:
                            self.store.scope(
                                state: \.contact,
                                action: RootReducer.Action.contact
                            )
                    )
                    .tabItem {
                        Image(.contact)
                        Text("Contact")
                    }
                    .tag(RootReducer.Tab.contact)
                }
            )
        }
    }
}

// MARK: - Preview

#Preview {
    /// Root view preview
    RootView(
        store: Store(
            initialState: 
                RootReducer.State(),
            reducer: {
                RootReducer()
            }
        )
    )
}
