//
//  ViewExtensions.swift
//  MBTests
//
//  Created by Wagner Sales on 29/01/24.
//

import UIKit

extension UIView {
    var tapGesture: UITapGestureRecognizer? {
        gestureRecognizers?.compactMap { $0 as? UITapGestureRecognizer }.first
    }
}
