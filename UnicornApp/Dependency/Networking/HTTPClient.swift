//
//  HTTPClient.swift
//  UnicornApp
//
//  Created by Mohamed Salem on 30.10.23.
//

import Foundation
import ComposableArchitecture

// MARK: Client

/// A client that defines the interface for an HTTP client capable of performing standard RESTful operations.
struct HTTPClient {
    /// Use GET requests to retrieve resource representation/information only – and not to modify it in any way. As GET requests do not change the state of the resource, these are said to be safe methods. Additionally, GET APIs should be idempotent, which means that making multiple identical requests must produce the same result every time until another API (POST or PUT) has changed the state of the resource on the server.
    var get: @Sendable (URL?) async throws -> (Data, URLResponse)?
    
    /// Use POST APIs to create new subordinate resources, e.g., a file is subordinate to a directory containing it or a row is subordinate to a database table. Talking strictly in terms of REST, POST methods are used to create a new resource into the collection of resources.
    var post: @Sendable (URL?, Codable) async throws -> (Data, URLResponse)?
    
    /// Use PUT APIs primarily to update existing resource (if the resource does not exist, then API may decide to create a new resource or not). If a new resource has been created by the PUT API, the origin server MUST inform the user agent via the HTTP response code 201 (Created) response and if an existing resource is modified, either the 200 (OK) or 204 (No Content) response codes SHOULD be sent to indicate successful completion of the request.
    var put: @Sendable (URL?, Codable) async throws -> (Data, URLResponse)?
    
    /// DELETE APIs are used to delete resources (identified by the Request-URI). DELETE operations are idempotent. If you DELETE a resource, it’s removed from the collection of resources. If the request passes through a cache and the Request-URI identifies one or more currently cached entities, those entries SHOULD be treated as stale. Responses to this method are not cacheable.
    var delete: @Sendable (URL?) async throws -> (Data, URLResponse)?
}

// MARK: Dependency values

extension DependencyValues {
    /// Provides access to the HTTP client within the dependency injection system of `ComposableArchitecture`.
    var httpClient: HTTPClient {
        get {
            self[
                HTTPClient.self
            ]
        }
        set {
            self[
                HTTPClient.self
            ] = newValue
        }
    }
}

// MARK: Implementation

extension HTTPClient: DependencyKey {
    
    /// The live implementation of `HTTPClient` using `URLSession` for network operations.
    static var liveValue = HTTPClient(
        get: {
            url in
            
            guard let url
            else {
                throw UnicornError.unknown
            }
            
            return try? await URLSession.shared.data(
                from: url
            )
        },
        post: {
            url, value in
            
            guard let url
            else {
                throw UnicornError.unknown
            }
            
            let json = try? JSONEncoder().encode(
                value
            )
            
            var request = URLRequest(
                url: url
            )
            request.httpMethod = "POST"
            request.addValue(
                "application/json",
                forHTTPHeaderField: "Content-Type"
            )
            request.httpBody = json
            
            return try? await URLSession.shared.data(
                for: request
            )
        },
        put: {
            url, value in
            
            guard let url
            else {
                throw UnicornError.unknown
            }
            
            let json = try? JSONEncoder().encode(
                value
            )
            
            var request = URLRequest(
                url: url
            )
            request.httpMethod = "PUT"
            request.addValue(
                "application/json",
                forHTTPHeaderField: "Content-Type"
            )
            request.httpBody = json
            
            return try? await URLSession.shared.data(
                for: request
            )
        },
        delete: {
            url in
            
            guard let url
            else {
                throw UnicornError.unknown
            }
            
            var request = URLRequest(
                url: url
            )
            request.httpMethod = "DELETE"
            
            return try? await URLSession.shared.data(
                for: request
            )
        }
    )
    
    /// A test implementation of `HTTPClient` that can be used for unit testing, returning no data and ignoring the URL.
    static let testValue = Self(
        get: { _ in
            .none
        },
        post: { _, _ in
            .none
        },
        put: { _, _ in
            .none
        },
        delete: { _ in
            .none
        }
    )
}

