//
//  ContactReducerTests.swift
//  UnicornAppTests
//
//  Created by Mohamed Salem on 31.10.23.
//

import XCTest
import ComposableArchitecture
@testable import UnicornApp

/// `ContactReducerTests` contains tests for the contact reducer of the UnicornApp.
final class ContactReducerTests: XCTestCase {
    
    // MARK: - Properties
    
    /// `store` is a `TestStore` initialized with the state and reducer of the contact module.
    let store = TestStore(
        initialState:
            ContactReducer.State(),
        reducer: {
            ContactReducer()
        }
    )

    // MARK: - Test Methods
    
    /// Tests the LinkedIn action within the contact reducer.
    func testLinkedIn() async throws {
        // Sends a .linkedin action and expects appropriate changes or effects to occur.
        await store.send(
            .linkedin
        )
    }
    
    /// Tests the Xing action within the contact reducer.
    func testXing() async throws {
        // Sends a .xing action and expects appropriate changes or effects to occur.
        await store.send(
            .xing
        )
    }
    
    /// Tests the Twitter action within the contact reducer.
    func testTwitter() async throws {
        // Sends a .twitter action and expects appropriate changes or effects to occur.
        await store.send(
            .twitter
        )
    }
}
