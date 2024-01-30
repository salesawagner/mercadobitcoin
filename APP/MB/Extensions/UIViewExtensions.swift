//
//  UIViewExtensions.swift
//  MB
//
//  Created by Wagner Sales on 29/01/24.
//

import UIKit

extension UIView {
    func fill(on view: UIView, insets: UIEdgeInsets = .zero) {
        view.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top),
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: insets.left),
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -insets.right),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -insets.bottom)
        ])
    }
}
