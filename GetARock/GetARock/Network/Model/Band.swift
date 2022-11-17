//
//  Band.swift
//  GetARock
//
//  Created by 김수진 on 2022/11/17.
//

import Foundation

struct Band {
}

enum PlayPosition {
    case vocal
    case guitar
    case keyboard
    case drum
    case bass
    case etc
    
    func toKorean() -> String {
        switch self {
        case .vocal: return "보컬"
        case .guitar: return "기타"
        case .keyboard: return "키보드"
        case .drum: return "드럼"
        case .bass: return "베이스"
        case .etc: return "그 외"
        }
    }
}

enum AgeGroup {
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

