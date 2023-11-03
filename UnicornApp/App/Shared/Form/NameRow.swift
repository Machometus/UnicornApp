//
//  NameRow.swift
//  UnicornApp
//
//  Created by Mohamed Salem on 20.10.23.
//

import SwiftUI

// MARK: - NameRow

/// `NameRow` is a SwiftUI view component that provides a text field for inputting a unicorn's name.
/// This component is used within a form to allow users to enter or update the name of a unicorn.
struct NameRow: View {
    
    // MARK: Binding
    
    /// A binding to a `String` that holds the name of the unicorn.
    /// This binding allows for a two-way connection between the text field and the source of truth, enabling updates to the name.
    @Binding var name: String
    
    // MARK: Body
    
    /// The content and behavior of the `NameRow`.
    var body: some View {
        TextField(
            "Pegasus",
            text: $name
        )
        .subheadlineStyle()
    }
}

// MARK: - Preview

/// A preview provider that creates a view for preview purposes within Xcode.
#Preview {
    /// A `Form` is used to simulate the environment in which `NameRow` typically appears.
    /// A constant binding with a sample text "Pegasus" is used to populate the text field for the preview.
    Form {
        Section {
            NameRow(
                name: .constant("Pegasus")
            )
        }
    }
}
