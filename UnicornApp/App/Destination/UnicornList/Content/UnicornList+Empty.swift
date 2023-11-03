//
//  UnicornList+Empty.swift
//  UnicornApp
//
//  Created by Mohamed Salem on 23.10.23.
//

import SwiftUI
import ComposableArchitecture

/// Provides a way to handle and display empty states in a list view within the context of the Composable Architecture.
extension List {
    
    // MARK: View builder
    
    /// Empty
    ///
    /// Modifies the current list view to handle and display an empty state based on the state observed from `UnicornListReducer`.
    ///
    /// - Parameter viewStore: A `ViewStore` that provides access to read the state of the `UnicornListReducer`.
    ///
    /// This function returns a modified view that switches between the original list content and an empty state message.
    /// It uses a `Group` to conditionally show either the content of the list or an empty state view.
    ///
    /// If the `items` state is not empty, it shows the list view itself. If the `items` state is empty and the `isLoading` state is false,
    /// it displays a message indicating that no unicorns are found. If the list is empty but the `isLoading` state is true,
    /// it maintains the background style, typically to show a loading indicator or preserve space while loading.
    ///
    /// - Returns: A view that either shows the list content or an empty state message.
    @ViewBuilder
    func Empty(
        _ viewStore: ViewStoreOf<UnicornListReducer>
    ) -> some View {
        
        Group {
            /// If the list has items, the original list view is presented.
            if !viewStore.items.isEmpty {
                self
                    .scrollContentBackground(.hidden)
            }
            else {
                /// Checks if the list is currently loading.
                if !viewStore.isLoading {
                    /// Displays a message indicating there are no unicorns in the list.
                    Text("No unicorns found")
                        .headlineStyle()
                } else {
                    /// Keeps the background style, useful for when the list is loading and you might want to show a spinner.
                    backgroundStyle()
                }
            }
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
        .backgroundStyle() // Applies a background style to the entire group.
    }
}

