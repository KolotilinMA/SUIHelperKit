//
//  SafeArray.swift
//  SUIHelperKit
//
//  Created by Михаил on 12.11.2024.
//

import Foundation

@propertyWrapper
public struct SafeArray<T: Codable>: Codable {

	// MARK: - Properties
	public var wrappedValue: [T]

	// MARK: - Init
	public init(wrappedValue: [T]) {
		self.wrappedValue = wrappedValue
	}
	
	public init(from decoder: Decoder) throws {
		let container = try decoder.singleValueContainer()
		wrappedValue = try container.safelyDecodeArray { index, error in
			if #available(iOS 14.0, *) {
				LoggerAgent.shared.log(category: .cache, message: "SafeDecodingError at index: \(String(index)) \(error)")
			} else {
				// Fallback on earlier versions
			}
		}
	}
	
	// MARK: - Encode
	public func encode(to encoder: Encoder) throws {
		var container = encoder.singleValueContainer()
		try container.encode(wrappedValue)
	}
}

extension SingleValueDecodingContainer {

	// MARK: - Public methods
	func safelyDecodeArray<T>(onItemError: (((Int, Any)) -> Void)?) throws -> [T] where T: Decodable {
		let decodedArray = orEmpty(try? decode([Throwable<T>].self))
		let filtredArray = decodedArray.enumerated().compactMap { index, result -> T? in
			switch result {
			case let .success(value):
				return value

			case let .failure(error):
				onItemError?((index, error))
				return nil
			}
		}

		return filtredArray
	}
}

enum Throwable<T: Decodable>: Decodable {

	case success(T)
	case failure(Error)

	// MARK: - Init

	init(from decoder: Decoder) throws {
		do {
			let decoded = try T(from: decoder)
			self = .success(decoded)
		} catch let error {
			self = .failure(error)
		}
	}
}

// Добавляем поддержку Encodable для Throwable
extension Throwable: Encodable where T: Encodable {
	func encode(to encoder: Encoder) throws {
		var container = encoder.singleValueContainer()
		switch self {
		case .success(let value):
			try container.encode(value)
		case .failure(let error):
			let errorMessage = error.localizedDescription
			try container.encode(errorMessage)
		}
	}
}
