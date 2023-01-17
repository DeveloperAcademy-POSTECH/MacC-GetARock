//
//  Event.swift
//  GetARock
//
//  Created by 김수진 on 2022/11/19.
//

import Foundation

struct GatheringInfo {
    let gatheringID: String
    let gathering: Gathering
}

enum GatheringStatus: String, Codable {
    
    static let progressingTerm: TimeInterval = 3600*3
    
    case recruiting
    case progressing
    case finished
    case canceled
    
    func toKorean() -> String {
        switch self {
        case .recruiting: return "모집중"
        case .progressing: return "진행중"
        case .finished: return "완료됨"
        case .canceled: return "취소됨"
        }
    }
    
    func calculateStatus(date: Date) -> Self {
        if date > Date() { return .recruiting }
        if date <= Date() && Date() < Date(timeInterval: Self.progressingTerm, since: date) {
            return .progressing
        }
        if Date() >= Date(timeInterval: Self.progressingTerm, since: date) {
            return .finished
        }
        return .canceled
    }
    
}

/// 밴드팅 모임입니다.
struct Gathering {
    
    /// 모임의 제목입니다.
    let title: String
    /// 모임의 주최 밴드입니다.
    let host: BandInfo
    /// 모임의 진행 전/중/후 및 취소를 나타내는 상태정보입니다.
    let status: GatheringStatus
    /// 모임이  이루어지는 날짜 및 시간입니다.
    let date: Date
    /// 모임이 이루어지는 위치입니다.
    let location: Location
    /// 모임의 대한 소개글입니다.
    let introduction: String
    /// 모임 모집을 시작하는 시기 정보입니다.
    let createdAt: Date
    
}
