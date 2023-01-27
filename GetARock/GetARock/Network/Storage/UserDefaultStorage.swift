//
//  UserDefaultStorage.swift
//  GetARock
//
//  Created by 김수진 on 2022/12/03.
//

import Foundation

enum DataKeys: String, CaseIterable {
    case userEmail
    case userPassword
    case userBandInfo
}

struct UserDefaultStorage {
    static var userEmail: String {
        return UserData<String>.getValue(forKey: .userEmail) ?? ""
    }
    
    static var userPassword: String {
        return UserData<String>.getValue(forKey: .userPassword) ?? ""
    }
    
    static var userBandInfo: BandInfo? {
        if let bandInfoData = UserData<Data>.getValue(forKey: .userBandInfo) {
            return try? JSONDecoder().decode(BandInfo.self, from: bandInfoData)
        }
        return nil
    }
}

struct UserData<T> {
    static func getValue(forKey key: DataKeys) -> T? {
        if let data = UserDefaults.standard.value(forKey: key.rawValue) as? T {
            return data
        } else {
            return nil
        }
    }
    
    static func setValue(_ value: T, forKey key: DataKeys) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    static func clearAll() {
        DataKeys.allCases.forEach { key in
            UserDefaults.standard.removeObject(forKey: key.rawValue)
        }
    }
    
    static func clear(forKey key: DataKeys) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
}
