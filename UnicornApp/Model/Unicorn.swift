//
//  Unicorn.swift
//  UnicornApp
//
//  Created by Mohamed Salem on 17.10.23.
//

import Foundation
import SwiftData

#if SWIFTDATA

/// `Unicorn` is a data model representing a mythical creature with specific attributes.
/// It leverages SwiftData's features for managing persistent data, such as unique identifiers.
@Model
class Unicorn {
    
    // MARK: Properties
    
    /// A unique identifier for the Unicorn. It is an attribute marked to be unique within the data store.
    @Attribute(.unique) var id: UUID
    /// The name of the Unicorn, represented by a `String`.
    var name: String
    /// The flavor of the Unicorn, which is an instance of the `Flavour` enum.
    var flavour: Flavour
    
    // MARK: Initializers
    
    /// A convenience initializer for creating a new `Unicorn` instance with default values.
    /// The `id` is generated as a new UUID, the `name` is an empty string, and the `flavour` is set to `.red`.
    convenience init() {
        self.init(
            id: UUID(), 
            name: "",
            flavour: .red
        )
    }
    
    /// A convenience initializer for creating a new `Unicorn` instance with a specified `name` and `flavour`.
    /// The `id` is generated as a new UUID.
    /// - Parameters:
    ///   - name: The name for the new `Unicorn`.
    ///   - flavour: The `Flavour` of the new `Unicorn`.
    convenience init(
        name: String,
        flavour: Flavour
    ) {
        self.init(
            id: UUID(),
            name: name,
            flavour: flavour
        )
    }
    
    /// The designated initializer for creating a new `Unicorn` instance with all properties specified.
    /// - Parameters:
    ///   - id: The unique identifier for the `Unicorn`.
    ///   - name: The name of the `Unicorn`.
    ///   - flavour: The `Flavour` of the `Unicorn`.
    private init(
        id: UUID,
        name: String,
        flavour: Flavour
    ) {
        self.id = id
        self.name = name
        self.flavour = flavour
    }
}

#else

/// A struct representing a `Unicorn`, conforming to `Equatable` and `Codable` protocols.
/// It serves as a data model in environments where SwiftData is not used.
struct Unicorn: Equatable, Codable {
    
    // MARK: Properties
    
    /// A string representation of the internal id, used for storage and encoding.
    var _id: String
    /// A `UUID` that uniquely identifies the Unicorn.
    var id: UUID
    /// The name of the Unicorn.
    var name: String
    /// The flavour of the Unicorn, represented by an instance of `Flavour` enum.
    var flavour: Flavour
    
    // MARK: Initializers
    
    /// Initializes a new `Unicorn` with default values. The `_id` is an empty string,
    /// `id` is a new UUID, `name` is an empty string, and `flavour` is set to `.red`.
    init() {
        self._id = ""
        self.id = UUID()
        self.name = ""
        self.flavour = .red
    }
    
    /// Initializes a new `Unicorn` with specified `name` and `flavour`. The `_id` is an empty string
    /// and `id` is a new UUID.
    /// - Parameters:
    ///   - name: The name for the Unicorn.
    ///   - flavour: The flavour for the Unicorn.
    init(
        name: String,
        flavour: Flavour
    ) {
        self._id = ""
        self.id = UUID()
        self.name = name
        self.flavour = flavour
    }
    
    // MARK: Encoder & Decoder

    /// Coding keys to map the properties of a `Unicorn` to and from an external representation, such as JSON.
    private enum CodingKeys: String, CodingKey {
        case _id
        case id
        case name
        case flavour
    }
    
    /// Initializes a new `Unicorn` from a decoder.
    /// - Throws: Decoding error if any of the properties fail to decode.
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        _id = try container.decode(String.self, forKey: ._id)
        let uuidString = try container.decode(String.self, forKey: .id)
        id = UUID(uuidString: uuidString) ?? UUID()
        name = try container.decode(String.self, forKey: .name)
        let flavourString = try container.decode(String.self, forKey: .flavour)
        flavour = Flavour(flavourString)
    }

    /// Encodes the `Unicorn` into an encoder.
    /// - Throws: Encoding error if any properties fail to encode.
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id.uuidString, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(flavour.rawValue, forKey: .flavour)
    }
}

#endif
