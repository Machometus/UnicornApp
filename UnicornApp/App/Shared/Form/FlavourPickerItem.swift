//
//  FlavourPickerItem.swift
//  UnicornApp
//
//  Created by Mohamed Salem on 20.10.23.
//

import SwiftUI

/// FlavourPickerItem.
/// A view that represents an individual selection item within a picker, showing a flavour option for a unicorn.
struct FlavourPickerItem: View {
    
    // MARK: Variable
    
    /// The flavour that this picker item represents.
    var flavour: Flavour
    
    // MARK: Body
    
    /// The content and behavior of the `FlavourPickerItem` view.
    var body: some View {
        Text(
            // Creates a localized string for the flavour, assuming localization definitions exist.
            String(
                localized:
                    "\(flavour.name.capitalized) Unicorn"
            )
        )
        .subheadlineStyle()
        .tag(
            flavour
        )
    }
}

// MARK: - Preview

/// Preview provider for `FlavourPickerItem`.
#Preview {
    /// Unicorn picker item row preview
    Form {
        Section {
            // Provides a series of example picker items for previewing different flavours.
            FlavourPickerItem(
                flavour: 
                    Flavour.red
            )
            FlavourPickerItem(
                flavour: 
                    Flavour.blue
            )
            FlavourPickerItem(
                flavour: 
                    Flavour.green
            )
        }
    }
}
