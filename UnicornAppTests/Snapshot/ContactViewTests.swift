//
//  ContactViewTests.swift
//  UnicornAppTests
//
//  Created by Mohamed Salem on 31.10.23.
//

import XCTest
import SnapshotTesting
import ComposableArchitecture
@testable import UnicornApp

/// `ContactViewTests` conducts snapshot tests for the `ContactView` UI component.
final class ContactViewTests: XCTestCase {
    
    // MARK: - Snapshot Test
    
    /// Tests the `ContactView` by taking a snapshot.
    func testContactView() {
        // Initializes the `ContactView` with a new store and default state.
        let view = ContactView(
            store: Store(
                initialState:
                    ContactReducer.State(),
                reducer: {
                    ContactReducer()
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
