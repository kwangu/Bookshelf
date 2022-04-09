//
//  UIView+Extension.swift
//  Bookshelf
//
//  Created by 강관구 on 2022/04/08.
//

import Foundation
import UIKit

extension UIView {
    func anchor(top: NSLayoutYAxisAnchor?,
                right: NSLayoutXAxisAnchor?,
                bottom: NSLayoutYAxisAnchor?,
                left: NSLayoutXAxisAnchor?,
                centerX: NSLayoutXAxisAnchor? = nil,
                centerY: NSLayoutXAxisAnchor? = nil,
                padding: UIEdgeInsets = .zero,
                size: CGSize = .zero) {

        translatesAutoresizingMaskIntoConstraints = false

        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }

        if let right = right {
            trailingAnchor.constraint(equalTo: right, constant: -padding.right).isActive = true
        }

        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }

        if let left = left {
            leadingAnchor.constraint(equalTo: left, constant: padding.left).isActive = true
        }

        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }

        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }

        if let centerX = centerX {
            centerXAnchor .constraint(equalTo: centerX).isActive = true
        }
    }
}
