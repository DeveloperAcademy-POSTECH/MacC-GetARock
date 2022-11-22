//
//  UIColor+Extension.swift
//  GetARock
//
//  Created by Yu ahyeon on 2022/11/02.
//

import UIKit

extension UIColor {

    static var mainPurple: UIColor {
        return #colorLiteral(red: 0.6862745098, green: 0.3019607843, blue: 0.9254901961, alpha: 1)
    }

    static var lightPurple: UIColor {
        return #colorLiteral(red: 0.9254901961, green: 0.8039215686, blue: 1, alpha: 1)
    }

    static var mainBlue: UIColor {
        return #colorLiteral(red: 0.4941176471, green: 0.5254901961, blue: 0.6862745098, alpha: 1)
    }

    static var gradationBlue: UIColor {
        return #colorLiteral(red: 0.4274509804, green: 0.4941176471, blue: 0.968627451, alpha: 1)
    }

    static var subBlue: UIColor {
        return #colorLiteral(red: 0.4823529412, green: 0.9019607843, blue: 0.9333333333, alpha: 1)
    }

    static var lightBlue: UIColor {
        return #colorLiteral(red: 0.6470588235, green: 0.7019607843, blue: 1, alpha: 1)
    }

    static var dividerBlue: UIColor {
        return #colorLiteral(red: 0.5294117647, green: 0.5568627451, blue: 0.6823529412, alpha: 1)
    }

    static var backgroundBlue: UIColor {
        return #colorLiteral(red: 0.4039215686, green: 0.4274509804, blue: 0.5411764706, alpha: 1)
    }

    static var modalBackgroundBlue: UIColor {
        return #colorLiteral(red: 0.3490196078, green: 0.368627451, blue: 0.4705882353, alpha: 1)
    }

    static var lightGrey: UIColor {
        return #colorLiteral(red: 0.7843137255, green: 0.7843137255, blue: 0.7843137255, alpha: 1)
    }

    static var backgroundWhite: UIColor {
        return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.2)
    }

    static var warningRed: UIColor {
        return #colorLiteral(red: 0.7921568627, green: 0, blue: 0, alpha: 1)
    }
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
}
