//
//  ContactView.swift
//  UnicornApp
//
//  Created by Mohamed Salem on 17.10.23.
//

import SwiftUI
import ComposableArchitecture

/// `ContactView` is a SwiftUI view that serves as a presentation layer for user contact information
/// within a navigation view. It composes a banner with user details and social media links.
struct ContactView: View {
    
    // MARK: Store
    
    /// The `store` holds the state and handles actions for the `ContactReducer`.
    let store: StoreOf<ContactReducer>
    
    // MARK: body
    
    /// The body of `ContactView` provides the UI layout and view logic.
    var body: some View {
        
        WithViewStore(
            self.store,
            observe: { $0 }
        ) {
            viewStore in
            
            /// Navigation view
            NavigationView {
                ScrollView {
                    /// Contact stack
                    VStack(
                        spacing: 48,
                        content: {
                            Spacer()
                            /// Banner view
                            BannerView()
                            /// Social media view
                            SocialMediaView(
                                viewStore: viewStore
                            )
                            Spacer()
                        }
                    )
                    .frame(
                        maxWidth: .infinity
                    )
                }
                .backgroundStyle()
                .navigationTitle( /// View title
                    "Contact"
                )
            }
        }        
    }
}

// MARK: - Preview

/// Previews `ContactView` with a mocked `Store`
/// to provide a visual representation of the UI for development.
#Preview {
    /// Contact view preview
    ContactView(
        store: Store(
            initialState: 
                ContactReducer.State(),
            reducer: {
                ContactReducer()
            }
        )
    )
}
