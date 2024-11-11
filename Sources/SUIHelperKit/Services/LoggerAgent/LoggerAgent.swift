//
//  LoggerAgent.swift
//  SUIHelperKit
//
//  Created by Михаил on 11.11.2024.
//

import Foundation
import OSLog


@available(iOS 14.0, *)

public class LoggerAgent: LoggerAgentProtocol, @unchecked Sendable {
	
	public static let shared = LoggerAgent()
	static let subsystem = "com.SUIHelperKit.core"
	
	private let modelLogger = Logger(subsystem: subsystem, category: LoggerAgentCategory.model.rawValue)
	private let uiLogger = Logger(subsystem: subsystem, category: LoggerAgentCategory.ui.rawValue)
	private let networkLogger = Logger(subsystem: subsystem, category: LoggerAgentCategory.network.rawValue)
	private let cacheLogger = Logger(subsystem: subsystem, category: LoggerAgentCategory.cache.rawValue)
	private let sessionLogger = Logger(subsystem: subsystem, category: LoggerAgentCategory.session.rawValue)
	
	private var customLoggers: [String: Logger] = [:]
	
	public func log(level: LoggerAgentLevel = .default, category: LoggerAgentCategory, message: String, file: String = #file, line: Int = #line) {
		
		let logMessage = "\(extractFileName(from: file)): \(message), #:\(line)"
		let logger = logger(for: category.rawValue)
		
		switch level {
		case .debug: logger.debug("\(logMessage, privacy: .public)")
		case .info: logger.info("\(logMessage, privacy: .public)")
		case .default: logger.notice("\(logMessage, privacy: .public)")
		case .error: logger.error("\(logMessage, privacy: .public)")
		case .fault: logger.fault("\(logMessage, privacy: .public)")
		}
	}
	
	public func log(level: LoggerAgentLevel = .default, customCategory: String, message: String, file: String = #file, line: Int = #line) {
		
		let logMessage = "\(extractFileName(from: file)): \(message), #:\(line)"
		let logger = logger(for: customCategory)
		
		switch level {
		case .debug: logger.debug("\(logMessage, privacy: .public)")
		case .info: logger.info("\(logMessage, privacy: .public)")
		case .default: logger.notice("\(logMessage, privacy: .public)")
		case .error: logger.error("\(logMessage, privacy: .public)")
		case .fault: logger.fault("\(logMessage, privacy: .public)")
		}
	}
	
	private func logger(for category: String) -> Logger {
		switch category {
		case LoggerAgentCategory.model.rawValue: return modelLogger
		case LoggerAgentCategory.ui.rawValue: return uiLogger
		case LoggerAgentCategory.network.rawValue: return networkLogger
		case LoggerAgentCategory.cache.rawValue: return cacheLogger
		case LoggerAgentCategory.session.rawValue: return sessionLogger
		default:
			if let customLogger = customLoggers[category] {
				return customLogger
			} else {
				let newLogger = Logger(subsystem: LoggerAgent.subsystem, category: category)
				customLoggers[category] = newLogger
				return newLogger
			}
		}
	}
	
	private func extractFileName(from path: String) -> String {
		return (path as NSString).lastPathComponent.components(separatedBy: ".").first.orEmpty
	}
}
