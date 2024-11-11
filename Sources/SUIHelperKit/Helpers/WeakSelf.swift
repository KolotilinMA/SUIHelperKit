//
//  File.swift
//  SUIHelperKit
//
//  Created by Михаил on 12.11.2024.
//

import Foundation

public typealias EmptyClosure = () -> Void

// Хелперные функции для оборачивания замыканий со слабымми ссылками на внешние обьекты

public func weak<T: AnyObject>(_ object: T, action: @escaping (T) -> Void) -> EmptyClosure {
	{ [weak object] in
		guard let object else { return }
		action(object)
	}
}

public func weak<T: AnyObject, VAR1>(_ object: T, action: @escaping (T, VAR1) -> Void) -> (VAR1) -> Void {
	{ [weak object]  val1 in
		guard let object else { return }
		action(object, val1)
	}
}

public func weak<T: AnyObject, VAR1, VAR2>(_ object: T, action: @escaping (T, VAR1, VAR2) -> Void) -> (VAR1, VAR2) -> Void {
	{ [weak object]  val1, val2 in
		guard let object else { return }
		action(object, val1, val2)
	}
}

public func weak<T: AnyObject, VAR1, VAR2, VAR3>(
	_ object: T,
	action: @escaping (T, VAR1, VAR2, VAR3) -> Void
) -> (VAR1, VAR2, VAR3) -> Void {
	{ [weak object]  val1, val2, val3 in
		guard let object else { return }
		action(object, val1, val2, val3)
	}
}
