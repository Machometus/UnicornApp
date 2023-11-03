//
//  UnicornListViewTests.swift
//  UnicornAppTests
//
//  Created by Mohamed Salem on 31.10.23.
//

import XCTest
import SnapshotTesting
import ComposableArchitecture
@testable import UnicornApp

/// `UnicornListViewTests` conducts snapshot tests for the `UnicornListView` component within the UnicornApp.
final class UnicornListViewTests: XCTestCase {
    
    // MARK: - Tests

    /// Tests the `UnicornListView` with an empty state to ensure that the view renders correctly when no unicorns are present.
    func testUnicornListView() {
        // Initializes the `UnicornListView` with an empty `UnicornListReducer` state.
        let view = UnicornListView(
            store: Store(
                initialState:
                    UnicornListReducer.State(),
                reducer: {
                    UnicornListReducer()
                }
            )
        )
        
        // Takes a snapshot of the view to verify its appearance.
        assertSnapshot(
            of: view,
            as: .image
        )
    }
    
    /// Tests the `UnicornListView` with a filled state to ensure it renders correctly with a list of unicorns.
    func testUnicornListView_Filled() {
        // Prepares a filled state with sample unicorns to simulate a list with content.
        let unicornsState = Unicorn.sample.map {
            item in
            
            UnicornReducer.State(
                id: item.id,
                item: item
            )
        }
        let items = IdentifiedArray(
            uniqueElements: unicornsState
        )
        
        // Initializes the `UnicornListView` with the filled state.
        let view = UnicornListView(
            store: Store(
                initialState:
                    UnicornListReducer.State(
                        items:
                            IdentifiedArray(
                                uniqueElements: items
                             )
                    ),
                reducer: {
                    UnicornListReducer()
                }
            )
        )
        
        // Takes a snapshot of the filled view to verify its appearance with unicorns.
        assertSnapshot(
            of: view,
            as: .image
        )
    }
}
