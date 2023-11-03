//
//  AddUnicornReducerTests.swift
//  UnicornAppTests
//
//  Created by Mohamed Salem on 31.10.23.
//

import XCTest
import ComposableArchitecture
@testable import UnicornApp

/// `AddUnicornReducerTests` conducts unit tests for the `AddUnicornReducer`.
final class AddUnicornReducerTests: XCTestCase {
    
    // MARK: - Properties
    
    /// Store for testing, initialized with the default state for adding a new unicorn.
    let store = TestStore(
        initialState:
            AddUnicornReducer.State(),
        reducer: {
            AddUnicornReducer()
        }
    )
    
    // MARK: - Test Methods
    
    /// Tests the action to change a new unicorn's name.
    func testNameChanged() async throws {
        // Simulates sending a name changed action to the store.
        await store.send(
            .nameChanged("Unicorn 1")
        ) {
            // Expected change in state after the name change action is processed.
            $0.name = "Unicorn 1"
        }
    }
    
    /// Tests the action to change a new unicorn's flavour.
    func testFlavourChanged() async throws {
        // Simulates sending a flavour changed action to the store.
        await store.send(
            .flavourChanged(.blue)
        ) {
            // Expected change in state after the flavour change action is processed.
            $0.flavour = .blue
        }
    }
    
    /// Tests the save action for adding a new unicorn's details.
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
        
        // Simulates receiving a save response.
        await store.receive(
            .saveResponse(
                .success(
                    true
                )
            ),
            timeout: 5
        ) {
            // Expected change in state after a successful save.
            $0.isLoading = false
        }
    }
}
