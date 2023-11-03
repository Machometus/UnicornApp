//
//  FlavourRow.swift
//  UnicornApp
//
//  Created by Mohamed Salem on 20.10.23.
//

import SwiftUI

// MARK: - FlavourRow

/// `FlavourRow` is a SwiftUI view component that presents a picker for selecting a unicorn's flavour.
/// It is intended to be used within a form to let users choose from a predefined list of flavours for a unicorn.
struct FlavourRow: View {
    
    // MARK: Binding
    
    /// A binding to a `Flavour` enumeration that reflects the current selected flavour.
    /// This binding allows for a two-way connection between the picker and the flavour property, enabling the user to select and change the unicorn's flavour.
    @Binding var flavour: Flavour
    
    // MARK: Body
    
    /// The content and behavior of the `FlavourRow`.
    var body: some View {
        // Picker View
        /// A `Picker` view that binds to the `flavour` property and displays a custom label and items.
        /// Users can tap the picker to choose from the available `Flavour` options.
        Picker(
            selection: // Accessibility label for the picker
                $flavour,
            label: // Binding to the flavour property
                FlavourPickerLabel(
                    flavour: flavour
                ),
            content: {
                // Picker Items
                /// A loop to iterate over all cases of the `Flavour` enumeration.
                /// For each flavour, a `FlavourPickerItem` view is presented as an option within the picker.
                ForEach(
                    Flavour.allCases,
                    id: \.rawValue,
                    content: { 
                        flavour in
                        FlavourPickerItem(
                            flavour: flavour
                        )
                    }
                )
            }
        )
        .pickerStyle(
            .inline
        )
    }
}

// MARK: - Preview

/// A preview provider that creates a view for preview purposes within Xcode.
#Preview {
    /// A `Form` is used to simulate the environment in which `FlavourRow` typically appears.
    /// A constant binding with a sample `Flavour` value is used to set the selected flavour for the preview.
    Form {
        Section {
            FlavourRow(
                flavour: .constant(
                    Flavour.red
                )
            )
        }
    }
}
