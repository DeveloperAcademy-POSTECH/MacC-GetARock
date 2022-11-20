//
//  UIView+Gradation.swift
//  GetARock
//
//  Created by Yu ahyeon on 2022/11/02.
//

import UIKit

extension UIView {

    func setGradient(startColor: UIColor, endColor: UIColor, startPointY: Double, endPointY: Double) {
        let gradient = CAGradientLayer()
        gradient.colors = [startColor.cgColor, endColor.cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: startPointY)
        gradient.endPoint = CGPoint(x: 1.0, y: endPointY)
        gradient.locations = [0.0, 1.0]
        gradient.frame = self.bounds
        self.layer.insertSublayer(gradient, at: 0)
    }

    func fillMainGradient() {
        setGradient(
            startColor: UIColor.appColor(.mainPurple),
            endColor: UIColor.appColor(.gradationBlue),
            startPointY: 0.5,
            endPointY: 0.5
        )
    }

    func fillActiveGradation() {
        setGradient(
            startColor: UIColor.appColor(.mainPurple).withAlphaComponent(0.3),
            endColor: UIColor.black.withAlphaComponent(0.0),
            startPointY: 0.0,
            endPointY: 1.0
        )
    }
}
