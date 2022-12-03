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
    
    static func setUserEmail(nickname: String) {
        UserData.setValue(nickname, forKey: .userEmail)
    }
    
    static func setUserPassword(currentLatitude: String) {
        UserData.setValue(currentLatitude, forKey: .userPassword)
    }
    
}
