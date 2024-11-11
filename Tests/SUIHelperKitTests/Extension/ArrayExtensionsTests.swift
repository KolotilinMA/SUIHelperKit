//
//  ArrayExtensionsTests.swift
//  SUIHelperKit
//
//  Created by Михаил on 12.11.2024.
//

import XCTest
@testable import SUIHelperKit

class ArrayExtensionsTests: XCTestCase {

	func testRemovingDuplicatesWithIntegers() {
		let array = [1, 2, 2, 3, 4, 4, 5]
		let expected = [1, 2, 3, 4, 5]
		XCTAssertEqual(array.removingDuplicates(), expected)
	}
	
	func testRemovingDuplicatesWithStrings() {
		let array = ["a", "b", "b", "c", "a"]
		let expected = ["a", "b", "c"]
		XCTAssertEqual(array.removingDuplicates(), expected)
	}
	
	func testRemovingDuplicatesWithCustomStruct() {
		struct CustomStruct: Hashable {
			let id: Int
			let value: String
		}
		
		let array = [
			CustomStruct(id: 1, value: "a"),
			CustomStruct(id: 2, value: "b"),
			CustomStruct(id: 1, value: "a")
		]
		let expected = [
			CustomStruct(id: 1, value: "a"),
			CustomStruct(id: 2, value: "b")
		]
		XCTAssertEqual(array.removingDuplicates(), expected)
	}
	
	func testRemovingDuplicatesWithEmptyArray() {
		let array: [Int] = []
		let expected: [Int] = []
		XCTAssertEqual(array.removingDuplicates(), expected)
	}
	
	func testOrEmpty() {
		let array: [Int]? = [1, 2, 3]
		let result = orEmpty(array)
		XCTAssertEqual(result, [1, 2, 3])
		
		let nilArray: [Int]? = nil
		let emptyResult = orEmpty(nilArray)
		XCTAssertEqual(emptyResult, [])
	}
	
	func testChunks() {
		let array = [1, 2, 3, 4, 5, 6, 7, 8, 9]
		let result = array.chunks(3)
		XCTAssertEqual(result, [[1, 2, 3], [4, 5, 6], [7, 8, 9]])
		
		let result2 = array.chunks(4)
		XCTAssertEqual(result2, [[1, 2, 3, 4], [5, 6, 7, 8], [9]])
		
		let emptyArray: [Int] = []
		let emptyResult = emptyArray.chunks(3)
		XCTAssertEqual(emptyResult, [])
	}
}
