//
//  GatheringDTO.swift
//  GetARock
//
//  Created by 김수진 on 2022/12/04.
//

import Foundation

import Firebase

/// 밴드팅 모임입니다.
struct GatheringDTO: Codable {
    /// 모임의 제목입니다.
    let title: String
    /// 모임의 주최 밴드입니다.
    let hostBandID: String
    /// 모임의 진행 전/중/후 및 취소를 나타내는 상태정보입니다.
    let status: GatheringStatus
    /// 모임이  이루어지는 날짜 및 시간입니다.
    let date: Timestamp
    /// 모임이 이루어지는 위치입니다.
    let location: Location
    /// 모임의 대한 소개글입니다.
    let introduction: String
    /// 모임 모집을 시작하는 시기 정보입니다.
    let createdAt: Timestamp
    
}

extension GatheringDTO {
    
    func toGathering() async throws -> Gathering {
        let bandAPI = BandAPI()
        let hostBand = try await bandAPI.getBandInfo(bandID: hostBandID)
        return Gathering(
            title: self.title,
            host: hostBand,
            status: self.status,
            date: self.date.dateValue(),
            location: self.location,
            introduction: self.introduction,
            createdAt: self.createdAt.dateValue()
        )
    }
    
    func changeValue(hostBandID: String) -> Self {
        GatheringDTO(
            title: self.title,
            hostBandID: hostBandID,
            status: self.status,
            date: self.date,
            location: self.location,
            introduction: self.introduction,
            createdAt: self.createdAt
        )
    }
    
    func changeValue(createdAt: Timestamp) -> Self {
        GatheringDTO(
            title: self.title,
            hostBandID: self.hostBandID,
            status: self.status,
            date: self.date,
            location: self.location,
            introduction: self.introduction,
            createdAt: createdAt
        )
    }
    
}

extension Gathering {
    
    func toGatheringDTO() -> GatheringDTO {
        GatheringDTO(
            title: self.title,
            hostBandID: self.host.bandID,
            status: self.status,
            date: Timestamp(date: self.date),
            location: self.location,
            introduction: self.introduction,
            createdAt: Timestamp(date: self.createdAt)
        )
    }
    
}
