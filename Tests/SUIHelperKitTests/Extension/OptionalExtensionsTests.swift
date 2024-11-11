//
//  File.swift
//  SUIHelperKit
//
//  Created by Михаил on 12.11.2024.
//

import XCTest
@testable import SUIHelperKit

class OptionalExtensionsTests: XCTestCase {
	
	// MARK: - Equatable Optional Tests
	func testIsEqualIfExist() {
		let value: Int? = 5
		XCTAssertTrue(value.isEqualIfExist(to: 5))
		
		let nilValue: Int? = nil
		XCTAssertFalse(nilValue.isEqualIfExist(to: 5))
		
		let differentValue: Int? = 10
		XCTAssertFalse(differentValue.isEqualIfExist(to: 5))
	}
	
	// MARK: - Numeric Optional Tests
	func testOrZero() {
		let value: Int? = 5
		XCTAssertEqual(value.orZero, 5)
		
		let nilValue: Int? = nil
		XCTAssertEqual(nilValue.orZero, 0)
	}
	
	func testOrWithNumeric() {
		let value: Int? = 5
		XCTAssertEqual(value.or(10), 5)
		
		let nilValue: Int? = nil
		XCTAssertEqual(nilValue.or(10), 10)
	}
	
	// MARK: - Bool Optional Tests
	func testOrFalse() {
		let value: Bool? = true
		XCTAssertEqual(value.orFalse, true)
		
		let nilValue: Bool? = nil
		XCTAssertEqual(nilValue.orFalse, false)
	}
	
	func testOrTrue() {
		let value: Bool? = false
		XCTAssertEqual(value.orTrue, false)
		
		let nilValue: Bool? = nil
		XCTAssertEqual(nilValue.orTrue, true)
	}
	
	// MARK: - Date Optional Tests
	func testOrNow() {
		let fixedDate = Date(timeIntervalSince1970: 1000)
		let value: Date? = fixedDate
		XCTAssertEqual(value.orNow, fixedDate)
		
		let nilValue: Date? = nil
		let currentDate = Date()
		XCTAssertTrue(Calendar.current.isDate(nilValue.orNow, equalTo: currentDate, toGranularity: .second))
	}
	
	// MARK: - String Optional Tests
	func testOrEmptyWithNil() {
		   let optionalString: String? = nil
		   XCTAssertEqual(optionalString.orEmpty, "")
	   }
	   
	   func testOrEmptyWithEmptyString() {
		   let optionalString: String? = ""
		   XCTAssertEqual(optionalString.orEmpty, "")
	   }
	   
	   func testOrEmptyWithNonEmptyString() {
		   let optionalString: String? = "Hello, World!"
		   XCTAssertEqual(optionalString.orEmpty, "Hello, World!")
	   }
}
