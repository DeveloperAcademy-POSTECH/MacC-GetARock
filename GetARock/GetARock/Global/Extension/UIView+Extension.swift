//
//  UIView+Extension.swift
//  GetARock
//
//  Created by Seungwon Choi on 2022/12/01.
//

import UIKit

extension UIView {
    func applyBandInfoBoxDesign(cornerRadius: CGFloat) {
        self.backgroundColor = UIColor.clear
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.dividerBlue.cgColor
    }
}
