//
//  UnicornCellTests.swift
//  UnicornAppTests
//
//  Created by Mohamed Salem on 31.10.23.
//

import XCTest
import SnapshotTesting
import SwiftUI
import ComposableArchitecture
@testable import UnicornApp

/// `UnicornCellTests` conducts snapshot tests for the `UnicornCell` UI component within the UnicornApp.
final class UnicornCellTests: XCTestCase {
    
    // MARK: - Snapshot Test
    
    /// Tests the `UnicornCell` by taking a snapshot to ensure UI consistency and verify that it renders correctly for a specific Unicorn item.
    func testUnicornCell() {
        // Wraps the `UnicornCell` in a `List` to simulate a real-world usage in a list environment and initializes it with a new store populated with predefined `UnicornReducer` state.
        let view = List {
            UnicornCell(
                store: Store(
                    initialState:
                        UnicornReducer.State(
                            id: UUID(),
                            item: .cassiopeia // Represents a specific unicorn configuration, "cassiopeia"
                        ),
                    reducer: {
                        UnicornReducer()
                    }
                )
            )
        }
        
        // Asserts that the view's snapshot matches the reference snapshot.
        // If no reference snapshot exists, it creates one for future comparison.
        assertSnapshot(
            of: view,
            as: .image
        )
    }
}
