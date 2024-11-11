//
//  File.swift
//  SUIHelperKit
//
//  Created by Михаил on 12.11.2024.
//

import XCTest
@testable import SUIHelperKit

class WeakClosureTests: XCTestCase {
	
	class TestObject {
		var called = false
		var capturedValues: [String] = []
		
		func action() {
			called = true
		}
		
		func actionWithOneParam(_ param: String) {
			called = true
			capturedValues.append(param)
		}
		
		func actionWithTwoParams(_ param1: String, _ param2: String) {
			called = true
			capturedValues.append(contentsOf: [param1, param2])
		}
		
		func actionWithThreeParams(_ param1: String, _ param2: String, _ param3: String) {
			called = true
			capturedValues.append(contentsOf: [param1, param2, param3])
		}
	}
	
	func testWeakClosureNoParams() {
		var object: TestObject? = TestObject()
		let closure = weak(object!) { obj in
			obj.action()
		}
		
		closure()
		XCTAssertTrue(object!.called, "Closure should call the action on the object when it exists")
		
		object = nil
		closure()
		XCTAssertNil(object, "Object should be released, so closure should not call action")
	}
	
	func testWeakClosureOneParam() {
		var object: TestObject? = TestObject()
		let closure = weak(object!) { obj, param in
			obj.actionWithOneParam(param)
		}
		
		closure("test")
		XCTAssertTrue(object!.called, "Closure should call the action with one parameter when object exists")
		XCTAssertEqual(object!.capturedValues.first, "test")
		
		object = nil
		closure("another test")
		XCTAssertNil(object, "Object should be released, so closure should not call action")
	}
	
	func testWeakClosureTwoParams() {
		var object: TestObject? = TestObject()
		let closure = weak(object!) { obj, param1, param2 in
			obj.actionWithTwoParams(param1, param2)
		}
		
		closure("test1", "test2")
		XCTAssertTrue(object!.called, "Closure should call the action with two parameters when object exists")
		XCTAssertEqual(object!.capturedValues, ["test1", "test2"])
		
		object = nil
		closure("another test1", "another test2")
		XCTAssertNil(object, "Object should be released, so closure should not call action")
	}
	
	func testWeakClosureThreeParams() {
		var object: TestObject? = TestObject()
		let closure = weak(object!) { obj, param1, param2, param3 in
			obj.actionWithThreeParams(param1, param2, param3)
		}
		
		closure("test1", "test2", "test3")
		XCTAssertTrue(object!.called, "Closure should call the action with three parameters when object exists")
		XCTAssertEqual(object!.capturedValues, ["test1", "test2", "test3"])
		
		object = nil
		closure("another test1", "another test2", "another test3")
		XCTAssertNil(object, "Object should be released, so closure should not call action")
	}
}
