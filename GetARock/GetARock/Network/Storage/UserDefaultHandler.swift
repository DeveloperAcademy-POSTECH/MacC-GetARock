//
//  UserDefaultHandler.swift
//  GetARock
//
//  Created by 김수진 on 2022/12/03.
//

import Foundation

struct UserDefaultHandler {
    static func clearAllData() {
        UserData<Any>.clearAll()
    }
    
}
