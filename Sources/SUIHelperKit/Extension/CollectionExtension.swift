//
//  CollectionExtension.swift
//  SUIHelperKit
//
//  Created by Михаил on 12.11.2024.
//

import Foundation

extension Collection {

	/// Returns the element at the specified index if it exists, otherwise nil.
	subscript (safe index: Index) -> Element? {
		return indices.contains(index) ? self[index] : nil
	}
}
