//
//  SocialMediaView.swift
//  UnicornApp
//
//  Created by Mohamed Salem on 24.10.23.
//

import SwiftUI
import ComposableArchitecture

/// A view representing a row of social media buttons, which the user can tap to perform actions such as visiting a social media page.
struct SocialMediaView: View {
    
    // MARK: Store
    
    /// The `ViewStore` that the `SocialMediaView` interacts with,
    /// provided by the `ComposableArchitecture`.
    let viewStore: ViewStoreOf<ContactReducer>
    
    // MARK: Body
    
    /// The content and layout of the view.
    var body: some View {
        /// Links stack
        HStack(
            spacing: 24,
            content: {
                /// LinkedIn button
                Button(
                    action: {
                        viewStore.send(
                            .linkedin
                        )
                    },
                    label: {
                        Image(
                            .linkedin
                        )
                        .smallStyle()
                    }
                )
                /// Xing button
                Button(
                    action: {
                        viewStore.send(
                            .xing
                        )
                    },
                    label: {
                        Image(
                            .xing
                        )
                        .smallStyle()
                    }
                )
                /// Twitter button
                Button(
                    action: {
                        viewStore.send(
                            .twitter
                        )
                    },
                    label: {
                        Image(
                            .twitter
                        )
                        .smallStyle()
                    }
                )
            }
        )
    }
}

// MARK: - Preview

/// A preview provider that creates a preview for the `SocialMediaView`.
#Preview {
    /// An instance of `SocialMediaView` configured with a `ViewStore` for previewing purposes.
    SocialMediaView(
        viewStore:
            ViewStore(
                Store(
                    initialState: ContactReducer.State(),
                    reducer: {
                        ContactReducer()
                    }
                ),
                observe: { $0 }
            )
    )
}
