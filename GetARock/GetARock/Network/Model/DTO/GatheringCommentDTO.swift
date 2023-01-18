//
//  GatheringCommentDTO.swift
//  GetARock
//
//  Created by 김수진 on 2022/12/04.
//

import Foundation

import Firebase

struct GatheringCommentDTO: Codable {
    let gatheringID: String
    let authorID: String
    let content: String
    let createdAt: Timestamp
}

extension GatheringCommentDTO {
    
    func toGatheringComment() async throws -> GatheringComment {
        let gatheringAPI = GatheringAPI()
        let bandAPI = BandAPI()
        async let gathering = gatheringAPI.getGatheringInfo(gatheringID: self.gatheringID)
        async let author = bandAPI.getBandInfo(bandID: self.authorID)
        
        return GatheringComment(
            gathering: try await gathering,
            author: try await author,
            content: self.content,
            createdAt: self.createdAt.dateValue()
        )
        
    }
    
    func changeValue(
        gatheringID: String? = nil,
        authorID: String? = nil,
        content: String? = nil,
        createdAt: Timestamp? = nil
    ) -> Self {
        GatheringCommentDTO(
            gatheringID: gatheringID ?? self.gatheringID,
            authorID: authorID ?? self.authorID,
            content: content ?? self.content,
            createdAt: createdAt ?? self.createdAt
        )
    }
    
}

extension GatheringComment {
    
    func toGatheringCommentDTO() -> GatheringCommentDTO {
        return GatheringCommentDTO(
            gatheringID: self.gathering.gatheringID,
            authorID: self.author.bandID,
            content: self.content,
            createdAt: Timestamp(date: self.createdAt)
        )
    }
    
}
