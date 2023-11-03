//
//  AddUnicornReducerTests.swift
//  UnicornAppTests
//
//  Created by Mohamed Salem on 31.10.23.
//

import XCTest
import ComposableArchitecture
@testable import UnicornApp

/// `UnicornDetailReducerTests` conducts unit tests for the `UnicornDetailReducer`.
final class UnicornDetailReducerTests: XCTestCase {
    
    // MARK: - Properties
    
    /// Store for testing, initialized with a test state representing a unicorn.
    let store = TestStore(
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
    
    // MARK: - Test Methods
    
    /// Tests the action to change a unicorn's name.
    func testNameChanged() async throws {
        // Simulates sending a name changed action to the store.
        await store.send(
            .nameChanged("Unicorn 1")
        ) {
            // Expected change in state after name changed action is processed.
            $0.name = "Unicorn 1"
        }
    }
    
    /// Tests the action to change a unicorn's flavour.
    func testFlavourChanged() async throws {
        // Simulates sending a flavour changed action to the store.
        await store.send(
            .flavourChanged(.blue)
        ) {
            // Expected change in state after flavour changed action is processed.
            $0.flavour = .blue
        }
    }
    
    /// Tests the save action for a unicorn's details.
    func testSave() async throws {
        // Prepares state by changing name and flavour.
        await store.send(
            .nameChanged("Unicorn 1")
        ) {
            $0.name = "Unicorn 1"
        }
        
        await store.send(
            .flavourChanged(.blue)
        ) {
            $0.flavour = .blue
        }
        
        // Simulates sending a save action to the store.
        await store.send(
            .save
        ) {
            // Expected state changes to indicate a loading process.
            $0.isLoading = true
        }
        
        await store.receive(
            .saveResponse(
                .success(
                    true
                )
            ),
            timeout: 5
        ) {
            $0.isLoading = false
        }
    }
    
    /// Tests the delete action for a unicorn.
    func testDelete() async throws {
        // Simulates sending a delete action to the store.
        await store.send(
            .delete
        ) {
            // Expected state changes to indicate a loading process.
            $0.isLoading = true
        }
        
        // Simulates receiving a delete response.
        await store.receive(
            .deleteResponse(
                .success(
                    true
                )
            ),
            timeout: 5
        ) {
            // Expected change in state after a successful delete.
            $0.isLoading = false
        }
    }
}
