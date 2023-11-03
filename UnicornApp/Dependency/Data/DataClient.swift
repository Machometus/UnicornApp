//
//  DataClient.swift
//  UnicornApp
//
//  Created by Mohamed Salem on 30.10.23.
//

#if !SWIFTDATA
import Foundation
import ComposableArchitecture

// MARK: Client

/// `DataClient` is responsible for handling data operations related to `Unicorn` entities.
/// It defines a set of asynchronous methods that correspond to CRUD operations,
/// utilizing the `httpClient` and `urlClient` to make network requests.
struct DataClient {
    /// Fetches the list of all unicorns.
    /// - Throws: `UnicornError.fetch` if the network request fails.
    /// - Returns: A `Data` object containing the unicorns.
    var getAll: @Sendable () async throws -> Data
    
    /// Fetches a unicorn by its unique identifier.
    /// - Parameter id: The `UUID` of the unicorn to fetch.
    /// - Throws: `UnicornError.fetch` if the network request fails.
    /// - Returns: A `Data` object containing the specified unicorn.
    var get: @Sendable (UUID) async throws -> Data
    
    /// Adds a new unicorn to the collection.
    /// - Parameter unicorn: The `Unicorn` object to add.
    /// - Throws: `UnicornError.add` if the network request fails.
    /// - Returns: A `Data` object representing the added unicorn.
    var add: @Sendable (Unicorn) async throws -> Data
    
    /// Updates an existing unicorn's information.
    /// - Parameters:
    ///   - unicorn: The existing `Unicorn` object to update.
    ///   - name: The new name for the unicorn.
    ///   - flavour: The new flavour for the unicorn.
    /// - Throws: `UnicornError.edit` if the network request fails.
    /// - Returns: A `Data` object representing the updated unicorn.
    var update: @Sendable (Unicorn, String, Flavour) async throws -> Data
    
    /// Deletes a unicorn from the collection.
    /// - Parameter unicorn: The `Unicorn` object to delete.
    /// - Throws: `UnicornError.delete` if the network request fails.
    /// - Returns: A `Data` object representing the deleted unicorn.
    var delete: @Sendable (Unicorn) async throws -> Data
}

// MARK: Dependency values

extension DependencyValues {
    /// Provides access to the `DataClient` dependency within the Composable Architecture environment.
    /// This allows for swapping the `DataClient` implementation for testing or mock purposes.
    var dataClient: DataClient {
        get {
            self[
                DataClient.self
            ]
        }
        set {
            self[
                DataClient.self
            ] = newValue
        }
    }
}

// MARK: Implementation

extension DataClient: DependencyKey {
    /// Provides a live environment implementation of `DataClient`, connecting to real network endpoints.
    static var liveValue = DataClient(
        /// Get list of all unicrons available
        getAll: {
            do {
                @Dependency(\.urlClient.unicorns) var url
                @Dependency(\.httpClient) var httpClient
                
                guard let (data, response) = try await httpClient.get(
                    url()
                )
                else {
                    throw UnicornError.fetch
                }
                
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200
                else {
                    throw UnicornError.fetch
                }
                
                return data
            }
            catch {
                throw UnicornError.fetch
            }
        },
        /// Get a unicorn for a given ID if available
        get: {
            id in
            
            do {
                @Dependency(\.urlClient.unicorn) var url
                @Dependency(\.httpClient) var httpClient
                
                guard let (data, response) = try await httpClient.get(
                    url(
                        id.uuidString
                    )
                ) else {
                    throw UnicornError.fetch
                }
                
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200
                else {
                    throw UnicornError.fetch
                }
                
                return data
            }
            catch {
                throw UnicornError.fetch
            }
        },
        /// Add a newly created unicorn
        add: {
            unicorn in
            
            do {
                @Dependency(\.urlClient.unicorns) var url
                @Dependency(\.httpClient) var httpClient
                
                guard let (data, response) = try await httpClient.post(
                    url(),
                    unicorn
                )
                else {
                    throw UnicornError.add
                }
                
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 201
                else {
                    throw UnicornError.add
                }
                
                return data
            }
            catch {
                throw UnicornError.add
            }
        },
        /// Update an existed unicorn with a new unicorn
        update: {
            unicorn, name, flavour in
            
            do {
                @Dependency(\.urlClient.unicorn) var url
                @Dependency(\.httpClient) var httpClient
                
                var newUnicorn = unicorn
                
                newUnicorn.name = name
                newUnicorn.flavour = flavour
                
                guard let (data, response) = try await httpClient.put(
                    url(
                        unicorn._id
                    ),
                    newUnicorn
                )
                else {
                    throw UnicornError.edit
                }
                
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200
                else {
                    throw UnicornError.edit
                }
                
                return data
            }
            catch {
                throw UnicornError.edit
            }
        },
        /// Delete a unicorn
        delete: {
            unicorn in
            
            do {
                @Dependency(\.urlClient.unicorn) var url
                @Dependency(\.httpClient) var httpClient
                
                guard let (data, response) = try await httpClient.delete(
                    url(
                        unicorn._id
                    )
                )
                else {
                    throw UnicornError.delete
                }
                
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200
                else {
                    throw UnicornError.delete
                }
                
                return data
            }
            catch {
                throw UnicornError.delete
            }
        }
    )
    
    /// Provides a test environment implementation of `DataClient`, returning empty `Data` instances.
    /// This can be used in unit tests to avoid performing real network requests.
    static let testValue = Self(
        getAll: {
            Data()
        },
        get: { _ in
            Data()
        },
        add: { _ in
            Data()
        },
        update: { _, _, _  in
            Data()
        },
        delete: { _ in
            Data()
        }
    )
}
#endif
