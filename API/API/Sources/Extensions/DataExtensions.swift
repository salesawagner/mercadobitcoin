//
//  DataExtensions.swift
//  API
//
//  Created by Wagner Sales on 24/01/24.
//

import Foundation
import OSLog

extension Data {
    var toString: String? {
        String(data: self, encoding: .utf8)
    }
}
