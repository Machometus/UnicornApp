//
//  Failure.swift
//  UnicornApp
//
//  Created by Mohamed Salem on 29.10.23.
//

import Foundation

/// An enumeration that represents the potential errors that can be encountered when performing operations related to `Unicorn` objects.
enum UnicornError: Error {
    
    // MARK: Cases
    
    /// Represents an error that occurs during the fetching process of a `Unicorn`.
    case fetch
    
    /// Represents an error that occurs while attempting to add a new `Unicorn`.
    case add
    
    /// Represents an error that occurs when editing the properties of an existing `Unicorn`.
    case edit
    
    /// Represents an error encountered during the deletion of a `Unicorn`.
    case delete
    
    /// Represents an error that cannot be categorized amongst the other defined cases; a generic error case.
    case unknown
}
