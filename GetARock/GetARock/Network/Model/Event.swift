//
//  Event.swift
//  GetARock
//
//  Created by 김수진 on 2022/11/19.
//

import Foundation

struct EventInfo {
    let eventID: String
    let event: Event
}

/// 모임 이벤트입니다.
struct Event {
    enum Status: String {
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
    }
    
    /// 모임의 제목입니다.
    let title: String
    /// 모임의 주최 밴드입니다.
    let host: BandInfo
    /// 모임의 진행 전/중/후 및 취소를 나타내는 상태정보입니다.
    let status: Status
    /// 모임이  이루어지는 날짜 및 시간입니다.
    let date: Date
    /// 모임이 이루어지는 위치입니다.
    let location: Location
    /// 모임의 대한 소개글입니다.
    let introduction: String
    /// 모임 모집을 시작하는 시기 정보입니다.
    let createdAt: Date
    
}
