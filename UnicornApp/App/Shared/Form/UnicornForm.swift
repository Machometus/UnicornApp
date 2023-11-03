//
//  UnicornForm.swift
//  UnicornApp
//
//  Created by Mohamed Salem on 20.10.23.
//

import SwiftUI

// MARK: - UnicornForm

/// `UnicornForm` is a SwiftUI view that presents a form for creating or editing a unicorn's details.
/// It binds to a `name` and `flavour` property and executes an action, typically used for saving the data.
struct UnicornForm: View {
    
    // MARK: Binding
    
    /// A binding to a `String` that represents the name of the unicorn.
    /// Changes to this property are propagated back to the source of truth.
    @Binding var name: String
    
    /// A binding to a `Flavour` enum value that represents the flavour of the unicorn.
    /// Changes to this property are propagated back to the source of truth.
    @Binding var flavour: Flavour
    
    // MARK: Action
    
    /// An action closure that is executed when a save operation is triggered.
    /// This is typically used to persist the form data.
    var action: () -> Void
    
    // MARK: Body
    
    /// The content and behavior of the `UnicornForm` view.
    var body: some View {
        Form {
            /// The section in the form dedicated to entering the name of the unicorn.
            /// It uses a `NameRow` view for the user to input the unicorn's name.
            Section(
                header:
                    Text(
                        "Name"
                    )
                    .footnoteStyle()
                ,
                content: {
                    NameRow(
                        name: $name
                    )
                }
            )
            /// The section in the form dedicated to selecting the flavour of the unicorn.
            /// It uses a `FlavourRow` view for the user to choose from predefined flavours.
            Section(
                header:
                    Text(
                        "Flavour"
                    )
                    .footnoteStyle()
                ,
                content: {
                    FlavourRow(
                        flavour: $flavour
                    )
                }
            )
            /// The section containing the save button.
            /// It uses a `SaveRow` view which triggers the provided action when tapped.
            /// The save button is disabled if the `name` is empty.
            Section {
                SaveRow(
                    action: action
                )
                .disabled(
                    name.isEmpty
                )
            }
        }
        .backgroundStyle()
        .scrollContentBackground(
            .hidden
        )
    }
}

// MARK: - Preview

/// A preview provider that supplies a view configured for previewing purposes.
#Preview {
    /// A preview of the `UnicornForm` view with constant bindings and an empty action.
    /// This setup is used to render the form in the design canvas of Xcode.
    UnicornForm(
        name: .constant("Pegasus"),
        flavour: .constant(.red),
        action: {}
    )
}
