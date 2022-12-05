//
//  AgeGroup.swift
//  GetARock
//
//  Created by 김수진 on 2022/11/18.
//

import Foundation

enum AgeGroup: Codable {
    case lessThanTwenty
    case twenties
    case thirties
    case forties
    case fifties
    case overThanSixty
    
    func toKorean() -> String {
        switch self {
        case .lessThanTwenty: return "20대 미만"
        case .twenties: return "20대"
        case .thirties: return "30대"
        case .forties: return "40대"
        case .fifties: return "50대"
        case .overThanSixty: return "60대 이상"
        }
    }
    
}
