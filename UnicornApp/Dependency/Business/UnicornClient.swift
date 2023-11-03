//
//  UnicornClient.swift
//  UnicornApp
//
//  Created by Mohamed Salem on 20.10.23.
//

import Foundation
import ComposableArchitecture
import SwiftData

// MARK: Client

/// `UnicornClient` is a service layer abstraction that defines a contract for performing
/// CRUD operations on `Unicorn` entities within an application. It allows for a clear separation
/// of concerns by abstracting the data layer, making it easier to manage data operations,
/// handle errors, and switch out implementations for testing or different data storage strategies.
struct UnicornClient {
    
    /// Retrieves a list of all `Unicorn` entities available in the persistent store.
    /// It's an asynchronous function that can throw an error if retrieval fails.
    ///
    /// - Returns: An array of `Unicorn` entities.
    /// - Throws: An error of type `UnicornError.fetch` if the fetch operation fails.
    var getAll: @Sendable () async throws -> [Unicorn]
    
    /// Searches for a `Unicorn` entity by its UUID in the persistent store. If the unicorn exists,
    /// it is returned, otherwise nil is returned. This function is asynchronous and can throw an
    /// error if the search operation fails.
    ///
    /// - Parameter id: The UUID of the unicorn to fetch.
    /// - Returns: An optional `Unicorn` entity if found.
    /// - Throws: An error of type `UnicornError.fetch` if the fetch operation fails.
    var get: @Sendable (UUID) async throws -> Unicorn?
    
    /// Attempts to add a new `Unicorn` entity to the persistent store. It's an asynchronous
    /// function that returns a Boolean value indicating success or failure of the add operation.
    ///
    /// - Parameter unicorn: The `Unicorn` entity to be added.
    /// - Returns: A Boolean value indicating whether the add operation was successful.
    /// - Throws: An error of type `UnicornError.add` if the add operation fails.
    var add: @Sendable (Unicorn) async throws -> Bool
    
    /// Updates an existing `Unicorn` entity with new details in the persistent store.
    /// The function is asynchronous and can throw an error if the update operation fails.
    ///
    /// - Parameters:
    ///   - unicorn: The `Unicorn` entity to update.
    ///   - name: The new name for the unicorn.
    ///   - flavour: The new flavour associated with the unicorn.
    /// - Returns: A Boolean value indicating whether the update operation was successful.
    /// - Throws: An error of type `UnicornError.edit` if the update operation fails.
    var update: @Sendable (Unicorn, String, Flavour) async throws -> Bool
    
    /// Deletes a specified `Unicorn` entity from the persistent store. It's an asynchronous
    /// function that can throw an error if the delete operation fails.
    ///
    /// - Parameter unicorn: The `Unicorn` entity to be deleted.
    /// - Returns: A Boolean value indicating whether the delete operation was successful.
    /// - Throws: An error of type `UnicornError.delete` if the delete operation fails.
    var delete: @Sendable (Unicorn) async throws -> Bool
}

// MARK: Dependency values

extension DependencyValues {
    /// Accessor for the `UnicornClient` within the Composable Architecture's environment.
    var unicornClient: UnicornClient {
        get {
            self[
                UnicornClient.self
            ]
        }
        set {
            self[
                UnicornClient.self
            ] = newValue
        }
    }
}

// MARK: Implementation

extension UnicornClient: DependencyKey {
#if SWIFTDATA
    /// Provides a live implementation of `UnicornClient` using SwiftData for database operations.
    static var liveValue = UnicornClient(
        // Fetches all unicorns using SwiftData.
        // Throws `UnicornError.fetch` on failure.
        getAll: {
            do {
                @Dependency(\.swiftDataClient.context) var context
                
                let fetchDescriptor = FetchDescriptor<Unicorn>()
                
                return try context().fetch(
                    fetchDescriptor
                )
            } 
            catch {
                throw UnicornError.fetch
            }
        },
        // Fetches a unicorn by its `id` using SwiftData.
        // Throws `UnicornError.fetch` on failure.
        get: {
            id in
            
            do {
                @Dependency(\.swiftDataClient.context) var context
                
                let fetchDescriptor = FetchDescriptor<Unicorn>(
                    predicate:
                        #Predicate {
                            $0.id == id
                        }
                )
                
                return try context().fetch(
                    fetchDescriptor
                ).first
            } 
            catch {
                throw UnicornError.fetch
            }
        },
        // Inserts a new unicorn into the database using SwiftData.
        // Throws `UnicornError.add` on failure.
        add: {
            unicorn in
            
            do {
                @Dependency(\.swiftDataClient.context) var context
                
                try context().insert(
                    unicorn
                )
                try context().save()
                
                return true
            } 
            catch {
                throw UnicornError.add
            }
        },
        // Updates an existing unicorn's name and flavour using SwiftData.
        // Throws `UnicornError.edit` on failure.
        update: {
            unicorn, name, flavour in
            
            do {
                @Dependency(\.swiftDataClient.context) var context
                
                unicorn.name = name
                unicorn.flavour = flavour
                
                try context().save()
                
                return true
            }
            catch {
                throw UnicornError.edit
            }
        },
        // Deletes a unicorn from the database using SwiftData.
        // Throws `UnicornError.delete` on failure.
        delete: {
            unicorn in
            
            do {
                @Dependency(\.swiftDataClient.context) var context
                
                try context().delete(
                    unicorn
                )
                try context().save()
                
                return true
            } 
            catch {
                throw UnicornError.delete
            }
        }
    )
#else
    /// Provides a live implementation of `UnicornClient` using a generic data client.
    static var liveValue = UnicornClient(
        // Fetches all unicorns using a generic data client.
        // Throws `UnicornError.fetch` on failure.
        getAll: {
            do {
                @Dependency(\.dataClient) var dataClient
                
                let data = try await dataClient.getAll()
                
                let unicorns = try JSONDecoder().decode(
                    [Unicorn].self,
                    from: data
                )
                
                return unicorns
            } 
            catch {
                throw UnicornError.fetch
            }
        },
        // Fetches a unicorn by its `id` using a generic data client.
        // Throws `UnicornError.fetch` on failure.
        get: {
            id in
            
            do {
                @Dependency(\.dataClient) var dataClient
                
                let data = try await dataClient.get(id)
                
                let unicorn = try JSONDecoder().decode(
                    Unicorn.self,
                    from: data
                )
                
                return unicorn
            } 
            catch {
                throw UnicornError.fetch
            }
        },
        // Adds a new unicorn using a generic data client.
        // Throws `UnicornError.add` on failure.
        add: {
            unicorn in
            
            do {
                @Dependency(\.dataClient) var dataClient
                
                let data = try await dataClient.add(
                    unicorn
                )
                
                return true
            }
            catch {
                throw UnicornError.add
            }
        },
        // Updates an existing unicorn using a generic data client.
        // Throws `UnicornError.edit` on failure.
        update: {
            unicorn, name, flavour in
            
            do {
                @Dependency(\.dataClient) var dataClient
                
                let data = try await dataClient.update(
                    unicorn,
                    name,
                    flavour
                )
                
                return true
            }
            catch {
                throw UnicornError.edit
            }
        },
        // Deletes a unicorn using a generic data client.
        // Throws `UnicornError.delete` on failure.
        delete: {
            unicorn in
            
            do {
                @Dependency(\.dataClient) var dataClient
                
                let data = try await dataClient.delete(
                    unicorn
                )
                
                return true
            }
            catch {
                throw UnicornError.delete
            }
        }
    )
#endif
    
    /// Provides a test implementation of `UnicornClient` with predefined responses.
    static let testValue = Self(
        getAll: {
            // Returns a sample list of unicorns for testing purposes.
            Unicorn.sample
        },
        get: { _ in
            // Returns a `nil` or a sample unicorn based on the test case.
            .none
        },
        add: { _ in
            // Simulates the addition of a unicorn for testing purposes, returns `true`.
            true
        },
        update: { _, _, _  in
            // Simulates the update of a unicorn for testing purposes, returns `true`.
            true
        },
        delete: { _ in
            // Simulates the deletion of a unicorn for testing purposes, returns `true`.
            true
        }
    )
}
