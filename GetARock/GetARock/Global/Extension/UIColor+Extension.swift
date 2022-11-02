//
//  UIColor+Extension.swift
//  GetARock
//
//  Created by Yu ahyeon on 2022/11/02.
//

import UIKit

enum AppColor {
    case mainPurple
    case lightPurple
    case darkPurple
    case lightGrey
    case lightBackgroundGrey
    case darkBackgroundGrey
    case backgroundWhite
    case warningRed
}

extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int, alpha: Int = 1) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: CGFloat(alpha) / 255.0
        )
    }
    
    static func appColor(_ name: AppColor) -> UIColor {
        switch name {
        case .mainPurple:
            return #colorLiteral(red: 0.6862745098, green: 0.3019607843, blue: 0.9254901961, alpha: 1)
            
        case .lightPurple:
            return #colorLiteral(red: 0.8431372549, green: 0.5960784314, blue: 1, alpha: 1)
            
        case .darkPurple:
            return #colorLiteral(red: 0.2784313725, green: 0.1058823529, blue: 0.3843137255, alpha: 1)
            
        case .lightGrey:
            return #colorLiteral(red: 0.7019607843, green: 0.7019607843, blue: 0.7019607843, alpha: 1)
            
        case .lightBackgroundGrey:
            return #colorLiteral(red: 0.2078431373, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
            
        case .darkBackgroundGrey:
            return #colorLiteral(red: 0.1294117647, green: 0.1294117647, blue: 0.1294117647, alpha: 1)
            
        case .backgroundWhite:
            return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.2)
            
        case .warningRed:
            return #colorLiteral(red: 0.7921568627, green: 0, blue: 0, alpha: 1)
        }
            
    }
    
}
