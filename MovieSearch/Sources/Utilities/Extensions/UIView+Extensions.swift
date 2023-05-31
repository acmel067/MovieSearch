//
//  UIView+Extensions.swift
//  MovieSearch
//
//  Created by Acuba, Melody Grace on 5/30/23.
//  Copyright © 2023 Acuba, Melody Grace. All rights reserved.
//

import UIKit

extension UIView {
    var isShown: Bool {
        get {
            !isHidden
        }
        set {
            isHidden = !newValue
        }
    }

    class var nib: UINib? {
        return UINib(nibName: String(describing: self), bundle: nil)
    }

    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner? = nil) {
        if let corners {
            var cornerMasks: CACornerMask = []
            if corners.contains(.allCorners) {
                cornerMasks = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner, .layerMinXMinYCorner]
            } else {
                if corners.contains(.bottomLeft) {
                    cornerMasks.update(with: .layerMinXMaxYCorner)
                }
                if corners.contains(.bottomRight) {
                    cornerMasks.update(with: .layerMaxXMaxYCorner)
                }
                if corners.contains(.topLeft) {
                    cornerMasks.update(with: .layerMinXMinYCorner)
                }
                if corners.contains(.topRight) {
                    cornerMasks.update(with: .layerMaxXMinYCorner)
                }
            }

            layer.cornerRadius = radius
            layer.masksToBounds = true
            layer.maskedCorners = cornerMasks
        } else {
            layer.cornerRadius = radius
            layer.masksToBounds = true
        }
    }
}
