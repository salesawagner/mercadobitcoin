//
//  LoggerExtension.swift
//  API
//
//  Created by Wagner Sales on 24/01/24.
//

import OSLog

extension Logger {
    private static var subsystem = Bundle.main.bundleIdentifier ?? "br.com.wagnersales"
    static let request = OSLog(subsystem: subsystem, category: "request")
    static let response = OSLog(subsystem: subsystem, category: "response")
}
