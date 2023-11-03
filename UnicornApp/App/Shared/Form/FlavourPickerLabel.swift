//
//  FlavourPickerLabel.swift
//  UnicornApp
//
//  Created by Mohamed Salem on 25.10.23.
//

import SwiftUI

/// FlavourPickerLabel.
/// A view component used as a label in a picker for selecting a unicorn's flavour.
struct FlavourPickerLabel: View {
    
    // MARK: Variable
    
    /// The currently selected flavour to be displayed.
    var flavour: Flavour
    
    // MARK: Body
    
    /// Provides the layout and behavior of the label row in the picker.
    var body: some View {
        HStack {
            Text(
                "Select your preferred flavor:"
            )
            .subheadlineStyle()
            Spacer()
            flavour
            .image
            .thumbStyle()
        }
    }
}

// MARK: - Preview

/// Preview for the `FlavourPickerLabel`.
#Preview {
    /// Unicorn picker label row preview
    Form {
        Section {
            // Provides an example with the 'red' flavour for preview.
            FlavourPickerLabel(
                flavour: Flavour.red
            )
        }
    }
}
