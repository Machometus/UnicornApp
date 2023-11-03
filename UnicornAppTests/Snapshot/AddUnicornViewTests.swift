//
//  AddUnicornViewTests.swift
//  UnicornAppTests
//
//  Created by Mohamed Salem on 31.10.23.
//

import XCTest
import SnapshotTesting
import ComposableArchitecture
@testable import UnicornApp

/// `AddUnicornViewTests` conducts snapshot tests for the `AddUnicornView` UI component within the UnicornApp.
final class AddUnicornViewTests: XCTestCase {
    
    // MARK: - Snapshot Test
    
    /// Tests the `AddUnicornView` by taking a snapshot to ensure UI consistency.
    func testAddUnicornView() {
        // Initializes the `AddUnicornView` with a new store and the default state of `AddUnicornReducer`.
        let view = AddUnicornView(
            store: Store(
                initialState:
                    AddUnicornReducer.State(),
                reducer: {
                    AddUnicornReducer()
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
