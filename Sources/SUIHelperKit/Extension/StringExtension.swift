//
//  StringExtension.swift
//  SUIHelperKit
//
//  Created by Михаил on 11.11.2024.
//

import Foundation

public extension String {
	
	static let empty = ""
	
	var digits: String { components(separatedBy: CharacterSet.decimalDigits.inverted).joined() }
	
	var encodeUrl: String { self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)! }
	
	var decodeUrl: String { self.removingPercentEncoding! }
	
	var toURL: URL? { URL(string: self) }
	
}
