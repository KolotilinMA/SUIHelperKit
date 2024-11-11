//
//  OptionalExtension.swift
//  SUIHelperKit
//
//  Created by Михаил on 11.11.2024.
//

import Foundation

public extension Optional where Wrapped: Equatable {
	func isEqualIfExist(to value: Wrapped) -> Bool {
		guard let self else { return false }
		return self == value
	}
}

public extension Optional where Wrapped: Numeric {
	var orZero: Wrapped { self ?? .zero }

	func or(_ value: Wrapped) -> Wrapped { self ?? value }
}

// MARK: - Bool
public extension Optional where Wrapped == Bool {
	/// Возвращает False если Bool == nil, иначе развернутый опционал
	var orFalse: Wrapped { self ?? false }
	
	/// Возвращает True если Bool == nil, иначе развернутый опционал
	var orTrue: Wrapped { self ?? true }
}

public extension Optional where Wrapped == Date {
	var orNow: Wrapped { self ?? Date() }
}

public extension Optional where Wrapped == String {
	var orEmpty: String {
		guard let string = self else { return .empty }
		return string
	}
}
