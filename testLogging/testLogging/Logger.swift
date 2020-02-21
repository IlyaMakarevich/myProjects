//
//  Logger.swift
//  testLogging
//
//  Created by Ilya Makarevich on 2/21/20.
//  Copyright © 2020 apalon. All rights reserved.
//

import Foundation
import os.log
/// Wrapper class for os_log function
public class Logger: NSObject {

    /// Application layer description
    ///
    /// - app: Application layer log
    /// - ui: User Experience layer log
    /// - network: Networking layer log
    /// - database: Database layer log
    enum Category: String {
        case app, ui, network, database
    }

    /// Log accessibility level
    ///
    /// - `public`: Log message will be visible in Console app
    /// - `private`: Log message won't be visible in Console app
    enum AccessLevel: String {
        case `public`, `private`
    }

    /// Creates OSLog object which describes log subsystem and category
    ///
    /// - Parameter category: Category, provided predefined log category
    /// - Returns: OSLog
    private func createOSLog(category: Category) -> OSLog {
        return OSLog(subsystem: Bundle.main.bundleIdentifier ?? "-", category: category.rawValue)
    }

    /// Prints provided log message with help of os_log function
    ///
    /// - Parameters:
    ///   - category: Category, provided predefined log category
    ///   - access: AccessLevel, log access level
    ///   - type: OSLogType, log type level, for example, .debug, .info, .error
    ///   - message: String, provided log message
    func log(category: Logger.Category, message: String, access: Logger.AccessLevel = Logger.AccessLevel.private, type: OSLogType = OSLogType.debug) {
        switch access {
        case .private:
            os_log("%{private}@", log: createOSLog(category: category), type: type, message)
        case .public:
            os_log("%{public}@", log: createOSLog(category: category), type: type, message)
        }
    }

}
