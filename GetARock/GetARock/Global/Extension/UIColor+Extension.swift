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
    case mainBlue
    case gradationBlue
    case subBlue
    case lightBlue
    case dividerBlue
    case backgroundBlue
    case modalBackgroundBlue
    case lightGrey
    case backgroundWhite
    case warningRed
}

enum GradientColor {
    
    case mainGradienBlue
    case cardGradienPurple
    case cardGradienblue
    
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
            return #colorLiteral(red: 0.9254901961, green: 0.8039215686, blue: 1, alpha: 1)
            
        case .mainBlue:
            return #colorLiteral(red: 0.4941176471, green: 0.5254901961, blue: 0.6862745098, alpha: 1)
            
        case .gradationBlue:
            return #colorLiteral(red: 0.4274509804, green: 0.4941176471, blue: 0.968627451, alpha: 1)
            
        case .subBlue:
            return #colorLiteral(red: 0.4823529412, green: 0.9019607843, blue: 0.9333333333, alpha: 1)
            
        case .lightBlue:
            return #colorLiteral(red: 0.6470588235, green: 0.7019607843, blue: 1, alpha: 1)
            
        case .dividerBlue:
            return #colorLiteral(red: 0.5294117647, green: 0.5568627451, blue: 0.6823529412, alpha: 1)
            
        case .backgroundBlue:
            return #colorLiteral(red: 0.4039215686, green: 0.4274509804, blue: 0.5411764706, alpha: 1)
            
        case .modalBackgroundBlue:
            return #colorLiteral(red: 0.3490196078, green: 0.368627451, blue: 0.4705882353, alpha: 1)
            
        case .lightGrey:
            return #colorLiteral(red: 0.7843137255, green: 0.7843137255, blue: 0.7843137255, alpha: 1)
            
        case .backgroundWhite:
            return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.2)
            
        case .warningRed:
            return #colorLiteral(red: 0.7921568627, green: 0, blue: 0, alpha: 1)
        }
    }
}
