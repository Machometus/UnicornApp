//
//  SaveRow.swift
//  UnicornApp
//
//  Created by Mohamed Salem on 20.10.23.
//

import SwiftUI

/// SaveRow.
/// A view that represents a save action within a form. Typically, this will be presented as a button at the end of a form to trigger a save operation.
struct SaveRow: View {
    
    // MARK: Action
    
    /// The action to execute when the save button is tapped.
    var action: () -> Void
    
    // MARK: Body
    
    /// The content and behavior of the `SaveRow`.
    var body: some View {
        Button(
            // The closure that is executed when the user taps the button.
            action: action,
            label: {
                HStack {
                    Spacer()
                    Text(
                        "Save"
                    )
                    .subheadlineStyle()
                    Spacer()
                }
            }
        )
    }
}

// MARK: - Preview

/// A preview provider that supplies a view representing the `SaveRow`.
#Preview {
    /// Unicorn save row preview
    Form {
        Section {
            SaveRow(
                action: {}
            )
        }
    }
}
