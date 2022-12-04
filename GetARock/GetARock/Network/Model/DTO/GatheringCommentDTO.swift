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
        async let auther = bandAPI.getBandInfo(bandID: self.authorID)
        
        return GatheringComment(
            gathering: try await gathering,
            author: try await auther,
            content: self.content,
            createdAt: self.createdAt.dateValue()
        )
        
    }
    
    func changeValue(authorID: String) -> Self {
        GatheringCommentDTO(
            gatheringID: self.gatheringID,
            authorID: authorID,
            content: self.content,
            createdAt: self.createdAt
        )
    }
    
    func changeValue(createdAt: Timestamp) -> Self {
        GatheringCommentDTO(
            gatheringID: self.gatheringID,
            authorID: self.authorID,
            content: self.content,
            createdAt: createdAt
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
