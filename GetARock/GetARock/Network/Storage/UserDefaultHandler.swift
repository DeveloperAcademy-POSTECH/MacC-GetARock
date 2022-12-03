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
    
    static func setUserEmail(email: String) {
        UserData.setValue(email, forKey: .userEmail)
    }
    
    static func setUserPassword(password: String) {
        UserData.setValue(password, forKey: .userPassword)
    }
    
}
