//
//  NSObject+Extension.swift
//  GetARock
//
//  Created by 김수진 on 2022/11/01.
//

import Foundation

extension NSObject {
    static var className: String {
        return String(describing: self)
    }
}
