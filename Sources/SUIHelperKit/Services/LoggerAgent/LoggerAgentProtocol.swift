//
//  File.swift
//  SUIHelperKit
//
//  Created by Михаил on 11.11.2024.
//

import Foundation
import OSLog

public protocol LoggerAgentProtocol {
	
	func log(level: LoggerAgentLevel, category: LoggerAgentCategory, message: String, file: String, line: Int)
	func log(level: LoggerAgentLevel, customCategory: String, message: String, file: String, line: Int)
}

public enum LoggerAgentLevel {
	
	case debug
	case info
	case `default`
	case error
	case fault
}

public enum LoggerAgentCategory: String, CaseIterable {
	
	case model
	case ui
	case network
	case cache
	case session
}
