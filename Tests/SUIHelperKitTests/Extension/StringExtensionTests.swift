//
//  File.swift
//  SUIHelperKit
//
//  Created by Михаил on 12.11.2024.
//

import XCTest
@testable import SUIHelperKit

class StringExtensionTests: XCTestCase {
	
	func testDigits() {
		XCTAssertEqual("123abc456".digits, "123456")
		XCTAssertEqual("abc".digits, "")
	}
	
	func testEncodeUrl() {
		XCTAssertEqual("test string".encodeUrl, "test%20string")
	}
	
	func testDecodeUrl() {
		XCTAssertEqual("test%20string".decodeUrl, "test string")
	}
	
	func testToURL() {
		XCTAssertNotNil("https://www.example.com".toURL)
		XCTAssertNotNil("not a url".toURL)  // это валидный URL, так как он превращается в "not%20a%20url"
		XCTAssertNil("".toURL)
		XCTAssertNotNil(" ".toURL)
		XCTAssertNil("ht tp://invalid".toURL)
		XCTAssertNotNil("http://".toURL)
	}
}
