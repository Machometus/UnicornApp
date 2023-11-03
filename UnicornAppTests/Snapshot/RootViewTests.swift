//
//  RootViewTests.swift
//  UnicornAppTests
//
//  Created by Mohamed Salem on 31.10.23.
//

import XCTest
import SnapshotTesting
import ComposableArchitecture
@testable import UnicornApp

/// `RootViewTests` conducts snapshot tests for the `RootView` UI component.
final class RootViewTests: XCTestCase {
    
    // MARK: - Snapshot Test
    
    /// Tests the `RootView` by taking a snapshot.
    func testRootView() {
        // Initializes the `RootView` with a new store and default state.
        let view = RootView(
            store: Store(
                initialState:
                    RootReducer.State(),
                reducer: {
                    RootReducer()
                }
            )
        )
        
        // Asserts that the view matches the reference snapshot.
        // If a reference snapshot does not exist, it creates one.
        assertSnapshot(
            of: view,
            as: .image
        )
    }
}
