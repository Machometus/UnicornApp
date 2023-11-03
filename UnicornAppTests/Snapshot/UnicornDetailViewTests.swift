//
//  UnicornDetailViewTests.swift
//  UnicornAppTests
//
//  Created by Mohamed Salem on 31.10.23.
//

import XCTest
import SnapshotTesting
import ComposableArchitecture
@testable import UnicornApp

/// `UnicornDetailViewTests` conducts snapshot tests for the `UnicornDetailView` UI component within the UnicornApp.
final class UnicornDetailViewTests: XCTestCase {
    
    // MARK: - Snapshot Test
    
    /// Tests the `UnicornDetailView` by taking a snapshot to ensure UI consistency and verify that it renders correctly for a specific Unicorn state.
    func testUnicornDetailView() {
        // Initializes the `UnicornDetailView` with a new store populated with predefined `UnicornDetailReducer` state.
        let view = UnicornDetailView(
            store: Store(
                initialState:
                    UnicornDetailReducer.State(
                        unicorn:
                            Unicorn(
                                name: "Pegasus",
                                flavour: .red
                            )
                    ),
                reducer: {
                    UnicornDetailReducer()
                }
            )
        )
        
        // Asserts that the view's snapshot matches the reference snapshot.
        // If no reference snapshot exists, it creates one for future comparison.
        assertSnapshot(
            of: view,
            as: .image
        )
    }
}
