//
//  UnicornListReducerTests.swift
//  UnicornAppTests
//
//  Created by Mohamed Salem on 31.10.23.
//

import XCTest
import ComposableArchitecture
@testable import UnicornApp

/// `UnicornListReducerTests` is a test suite for the `UnicornListReducer`.
final class UnicornListReducerTests: XCTestCase {
    
    // MARK: - Properties
    
    /// Store for testing, configured with the initial state and reducer of the unicorn list.
    let store = TestStore(
        initialState:
            UnicornListReducer.State(),
        reducer: {
            UnicornListReducer()
        }
    )
    
    // MARK: - Test Methods
    
    /// Tests the fetch action for loading unicorn list.
    func testFetch() async throws {
        // Simulates sending a fetch action to the store.
        await store.send(
            .fetch
        ) {
            // Expected change in state after action is processed.
            $0.isLoading = true
        }
        
        // Simulates receiving a fetch response.
        await store.receive(
            .fetchResponse(
                .success(
                    Unicorn.sample
                )
            ),
            timeout: 5) {
                // Expected change in state after fetch response is processed.
                $0.isLoading = false
                $0.items = [
                    UnicornReducer.State(
                        id: Unicorn.cassiopeia.id,
                        item: .cassiopeia
                    ),
                    UnicornReducer.State(
                        id: Unicorn.hippolyta.id,
                        item: .hippolyta
                    ),
                    UnicornReducer.State(
                        id: Unicorn.zephyra.id,
                        item: .zephyra
                    )
                ]
            }
    }
    
    /// Tests showing and hiding the add unicorn interface.
    func testshowAddUnicorn() async throws {
        // Simulates sending an action to show the add unicorn sheet.
        await store.send(
            .showAddUnicorn(true)
        ) {
            // Expected state changes when showing the add unicorn sheet.
            $0.isAddUnicornPresented = true
            
            $0.addUnicorn = AddUnicornReducer.State(
                name: "",
                flavour: .red,
                isLoading: false,
                alert: nil
            )
        }
        
        // Simulates sending an action to hide the add unicorn sheet.
        await store.send(
            .showAddUnicorn(false)
        ) {
            // Expected state changes when hiding the add unicorn sheet.
            $0.isAddUnicornPresented = false
        }
    }
    
    /// Tests showing unicorn detail view.
    func testShowUnicornDetail() async throws {
        // Begins by simulating a fetch to populate the items.
        await store.send(
            .fetch
        ) {
            // Expected state change to indicate loading in progress.
            $0.isLoading = true
        }
        
        // Simulates receiving a successful fetch response.
        await store.receive(
            .fetchResponse(
                .success(
                    Unicorn.sample
                )
            ),
            timeout: 5) {
                // Expected state changes upon successful fetch.
                $0.isLoading = false
                $0.items = [
                    UnicornReducer.State(
                        id: Unicorn.cassiopeia.id,
                        item: .cassiopeia
                    ),
                    UnicornReducer.State(
                        id: Unicorn.hippolyta.id,
                        item: .hippolyta
                    ),
                    UnicornReducer.State(
                        id: Unicorn.zephyra.id,
                        item: .zephyra
                    )
                ]
            }
        
        // Simulates sending an action to show the unicorn detail view.
        await store.send(
            .showUnicornDetail(selection: store.state.items.first?.id)
        ) {
            // Expected state changes when navigating to unicorn detail view.
            if let item = $0.items.first?.item,
               let id = $0.items.first?.id {
                
                // Create and assign the detailed state for the selected unicorn.
                let UnicornDetail = UnicornDetailReducer.State(
                    unicorn: item
                )
                
                $0.selection = Identified(
                    UnicornDetail,
                    id: id
                )
            }
        }
    }
}
