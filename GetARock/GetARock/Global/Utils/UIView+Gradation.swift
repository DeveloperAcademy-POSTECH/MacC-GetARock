//
//  UIView+Gradation.swift
//  GetARock
//
//  Created by Yu ahyeon on 2022/11/02.
//

import UIKit

extension UIView {
    
    func setGradient(color1:UIColor, color2:UIColor, startPoint1:Double, startPoint2:Double, endPoint1:Double, endPoint2:Double
    ){
        let gradient = CAGradientLayer()
        gradient.colors = [color1.cgColor, color2.cgColor]
        gradient.startPoint = CGPoint(x: startPoint1, y: startPoint2)
        gradient.endPoint = CGPoint(x: endPoint1, y: endPoint2)
        gradient.locations = [0.0, 1.0]
        gradient.frame = self.bounds
        self.layer.insertSublayer(gradient, at: 0)
    }

    func fillMainGradient() {
        setGradient(
            color1: UIColor.appColor(.mainPurple),
            color2: UIColor.gradientColor(.mainGradienBlue),
            startPoint1: 0.0,
            startPoint2: 0.5,
            endPoint1: 1.0,
            endPoint2: 0.5
        )
    }
    
    func fillActiveGradation() {
        setGradient(
            color1: UIColor.appColor(.mainPurple).withAlphaComponent(0.3),
            color2: UIColor.black.withAlphaComponent(0.0),
            startPoint1: 0.0,
            startPoint2: 0.0,
            endPoint1: 1.0,
            endPoint2: 1.0
        )
    }
    
    func fillCardListGradation() {
        setGradient(
            color1: UIColor.appColor(.darkPurple).withAlphaComponent(0.0),
            color2: UIColor.appColor(.darkPurple),
            startPoint1: 0.5,
            startPoint2: 0.0,
            endPoint1: 0.5,
            endPoint2: 1.0

        )
    }
    
    func fillCardDetailGradation() {
        setGradient(
            color1: UIColor.gradientColor(.cardGradienPurple),
            color2: UIColor.gradientColor(.cardGradienblue),
            startPoint1: 0.0,
            startPoint2: 0.0,
            endPoint1: 0.5,
            endPoint2: 1.0
        )
    }
}
