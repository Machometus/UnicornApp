//
//  Flavour.swift
//  UnicornApp
//
//  Created by Mohamed Salem on 24.10.23.
//

import SwiftUI

/// An enumeration defining the various flavors that a `Unicorn` can have, each with a corresponding color and image representation.
/// Conforms to `String`, `Equatable`, `Codable`, and `CaseIterable` to support string values, comparison, encoding/decoding, and iterating over all cases.
enum Flavour: String, Equatable, Codable, CaseIterable {
    
    // MARK: Cases
    
    /// Represents a red flavor with associated raw value "red".
    case red = "red"
    /// Represents a green flavor with associated raw value "green".
    case green = "green"
    /// Represents a blue flavor with associated raw value "blue".
    case blue = "blue"
    
    // MARK: Initializers
    
    /// Initializes a `Flavour` to the default `.red` case.
    init() {
        self = .red
    }
    
    /// Initializes a `Flavour` with a string value. If the string value does not correspond to any case, it defaults to `.red`.
    /// - Parameter name: A `String` value that corresponds to one of the raw values of the `Flavour` cases.
    init(
        _ name: String
    ) {
        self = Flavour(
            rawValue: name
        )
        ?? .red
    }
    
    // MARK: Computed Properties
    
    /// A computed property that returns a localized name for the `Flavour` case.
    var name: String {
        switch self {
        case .red:
            return String(
                localized: "Red"
            )
        case .green:
            return String(
                localized: "Green"
            )
        case .blue:
            return String(
                localized: "Blue"
            )
        }
    }
    
    /// A computed property that returns a `Color` representing the visual color of the `Flavour`.
    var color: Color {
        switch self {
        case .red:
            return .deepMaroon // Custom color representing deep maroon.
        case .green:
            return .oliveShade // Custom color representing an olive shade.
        case .blue:
            return .oceanDepths // Custom color representing the color of ocean depths.
        }
    }
    
    /// A computed property that returns an `Image` associated with the `Flavour`.
    var image: Image {
        switch self {
        case .red:
            return Image(
                .redFlavour
            ) // Custom image asset for red flavour.
        case .green:
            return Image(
                .greenFlavour
            ) // Custom image asset for green flavour.
        case .blue:
            return Image(
                .blueFlavour
            )
        } // Custom image asset for blue flavour.
    }
}

