//
//  File.swift
//  SUIHelperKit
//
//  Created by Михаил on 12.11.2024.
//

import XCTest
@testable import SUIHelperKit

// Класс для тестирования SafeArray
class SafeArrayTests: XCTestCase {

	// Пример модели для тестирования
	struct Item: Codable, Equatable {
		let id: Int
		let name: String
	}
	
	// Модель, содержащая SafeArray
	struct Example: Codable {
		@SafeArray var items: [Item]
		
		// Добавим инициализатор для удобства
		init(items: [Item]) {
			self._items = SafeArray(wrappedValue: items)
		}
	}
	
	// Тест декодирования с некорректными данными
	func testDecodingWithInvalidData() throws {
		let jsonData = """
	 {
	  "items": [
	   {"id": 1, "name": "Item 1"},
	   {"id": 2, "name": "Item 2"},
	   {"id": "invalid", "name": "Invalid Item"},
	   {"id": 3, "name": "Item 3"}
	  ]
	 }
	 """.data(using: .utf8)!
		
		let example = try JSONDecoder().decode(Example.self, from: jsonData)
		XCTAssertEqual(example.items, [Item(id: 1, name: "Item 1"), Item(id: 2, name: "Item 2"), Item(id: 3, name: "Item 3")])
	}
	
	// Тест декодирования с корректными данными
	func testDecodingWithValidData() throws {
		let jsonData = """
	 {
	  "items": [
	   {"id": 1, "name": "Item 1"},
	   {"id": 2, "name": "Item 2"},
	   {"id": 3, "name": "Item 3"}
	  ]
	 }
	 """.data(using: .utf8)!
		
		let example = try JSONDecoder().decode(Example.self, from: jsonData)
		XCTAssertEqual(example.items, [Item(id: 1, name: "Item 1"), Item(id: 2, name: "Item 2"), Item(id: 3, name: "Item 3")])
	}
	
	// Тест кодирования данных
	func testEncoding() throws {
		let example = Example(items: [Item(id: 1, name: "Item 1"), Item(id: 2, name: "Item 2"), Item(id: 3, name: "Item 3")])
		let jsonData = try JSONEncoder().encode(example)
		
		let decodedExample = try JSONDecoder().decode(Example.self, from: jsonData)
		XCTAssertEqual(decodedExample.items, example.items)
	}
	
	// Тест декодирования пустого массива
	func testDecodingEmptyArray() throws {
		let jsonData = """
	 {
	  "items": []
	 }
	 """.data(using: .utf8)!
		
		let example = try JSONDecoder().decode(Example.self, from: jsonData)
		XCTAssertEqual(example.items, [])
	}
	
	// Тест кодирования пустого массива
	func testEncodingEmptyArray() throws {
		let example = Example(items: [])
		let jsonData = try JSONEncoder().encode(example)
		
		let decodedExample = try JSONDecoder().decode(Example.self, from: jsonData)
		XCTAssertEqual(decodedExample.items, [])
	}
	
	// Тест кодирования успешного значения
	func testEncodingSuccess() throws {
		let item = Item(id: 1, name: "Item 1")
		let throwable = Throwable<Item>.success(item)
		let jsonData = try JSONEncoder().encode(throwable)
		
		let jsonDictionary = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any]
		let expectedDictionary: [String: Any] = ["id": 1, "name": "Item 1"]
		
		XCTAssertEqual(jsonDictionary as NSDictionary?, expectedDictionary as NSDictionary?)
	}
	
	// Тест кодирования ошибки
	func testEncodingFailure() throws {
		let error = NSError(domain: "test", code: 123, userInfo: [NSLocalizedDescriptionKey: "Test error"])
		let throwable = Throwable<Item>.failure(error)
		let jsonData = try JSONEncoder().encode(throwable)
		
		let jsonString = String(data: jsonData, encoding: .utf8)
		XCTAssertEqual(jsonString, "\"Test error\"")
	}
}
