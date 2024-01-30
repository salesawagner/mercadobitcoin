//
//  UIEdgeInsetsExtensions.swift
//  MB
//
//  Created by Wagner Sales on 30/01/24.
//

import UIKit

extension UIEdgeInsets {
    static func all(constant: CGFloat) -> UIEdgeInsets {
        .init(top: constant, left: constant, bottom: constant, right: constant)
    }
}
