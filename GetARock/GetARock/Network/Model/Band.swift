//
//  Band.swift
//  GetARock
//
//  Created by 김수진 on 2022/11/17.
//

import Foundation

struct Band {
    /// 밴드의 이름입니다.
    var name: String
    /// 밴드가 갖고있는 포지션입니다.
    var filledPosition: [PlayPosition]
    /// 밴드의 합주곡입니다.
    var repertoire: [String]
    /// 밴드의 연령대입니다.
    var ageGroups: [AgeGroup]
    /// 밴드의 합주실 위치입니다.
    var bandRoomLocation: Location
    /// 밴드의 자유소개 글입니다.
    var introduction: String
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
