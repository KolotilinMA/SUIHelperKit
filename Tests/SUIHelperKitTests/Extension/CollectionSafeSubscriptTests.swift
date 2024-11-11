//
//  File.swift
//  SUIHelperKit
//
//  Created by Михаил on 12.11.2024.
//

import XCTest
@testable import SUIHelperKit

class CollectionSafeSubscriptTests: XCTestCase {

	func testSafeSubscriptWithinBounds() {
		let array = [1, 2, 3, 4, 5]
		XCTAssertEqual(array[safe: 2], 3, "Safe subscript should return the correct element within bounds")
	}

	func testSafeSubscriptOutOfBounds() {
		let array = [1, 2, 3, 4, 5]
		XCTAssertNil(array[safe: 10], "Safe subscript should return nil for an out-of-bounds index")
	}
	
	func testSafeSubscriptEmptyCollection() {
		let emptyArray: [Int] = []
		XCTAssertNil(emptyArray[safe: 0], "Safe subscript should return nil for an index in an empty collection")
	}
	
	func testSafeSubscriptNegativeIndex() {
		let array = [1, 2, 3, 4, 5]
		XCTAssertNil(array[safe: -1], "Safe subscript should return nil for a negative index")
	}

	func testSafeSubscriptSingleElementArray() {
		let singleElementArray = [42]
		XCTAssertEqual(singleElementArray[safe: 0], 42, "Safe subscript should return the element if index is 0 in a single-element array")
		XCTAssertNil(singleElementArray[safe: 1], "Safe subscript should return nil for out-of-bounds index in a single-element array")
	}
}
