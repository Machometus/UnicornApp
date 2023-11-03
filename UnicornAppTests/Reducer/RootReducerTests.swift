//
//  RootReducerTests.swift
//  UnicornAppTests
//
//  Created by Mohamed Salem on 31.10.23.
//

import XCTest
import ComposableArchitecture
@testable import UnicornApp

/// `RootReducerTests` contains tests for the root reducer of the UnicornApp.
final class RootReducerTests: XCTestCase {
    
    // MARK: - Properties
    
    /// `store` is a `TestStore` initialized with the state and reducer of the root module.
    let store = TestStore(
        initialState:
            RootReducer.State(),
        reducer: {
            RootReducer()
        }
    )
    
    // MARK: - Test Methods
    
    /// Tests the tab selection functionality within the root reducer.
    func testSelectTab() async throws {
        
        // Sends a .select action with the .contact case and expects the state to update accordingly.
        await store.send(
            .select(
                .contact
            )
        ) {
            // Verifies that the `selected` state is updated to `.contact`.
            $0.selected = .contact
        }
        
        // Sends another .select action with the .unicorns case and expects the state to update accordingly.
        await store.send(
            .select(
                .unicorns
            )
        ) {
            // Verifies that the `selected` state is updated to `.unicorns`.
            $0.selected = .unicorns
        }
    }
}
