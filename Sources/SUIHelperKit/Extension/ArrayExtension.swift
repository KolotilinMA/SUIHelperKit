//
//  ArrayExtension.swift
//  SUIHelperKit
//
//  Created by Михаил on 12.11.2024.
//

import Foundation

extension Array where Element: Hashable {
	
	/// Removes duplicate elements from the array, preserving the order of the first occurrences.
	///
	/// - Returns: An array with duplicate elements removed.
	public func removingDuplicates() -> Array {
		var buffer = Array()
		var added = Set<Element>()
		for elem in self {
			if added.insert(elem).inserted {
				buffer.append(elem)
			}
		}
		return buffer
	}
	
	/// Splits the array into chunks of the given size.
	///
	/// - Parameter size: The size of each chunk.
	/// - Returns: An array of array slices, each with the specified size.
	public func chunks(_ size: Int) -> [ArraySlice<Element>] {
		guard size > 0 else { return [] }
		return stride(from: 0, to: count, by: size).map {
			self[$0 ..< Swift.min($0 + size, count)]
		}
	}
}

/// Returns the array if it is not nil, otherwise returns an empty array.
///
/// - Parameter array: The optional array.
/// - Returns: The array itself if not nil, otherwise an empty array.
public func orEmpty<T>(_ array: [T]?) -> [T] {
	return array ?? []
}
