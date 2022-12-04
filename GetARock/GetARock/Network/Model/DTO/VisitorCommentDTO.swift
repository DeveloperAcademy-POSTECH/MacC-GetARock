//
//  VisitorCommentDTO.swift
//  GetARock
//
//  Created by 김수진 on 2022/12/04.
//

import Foundation

import Firebase

struct VisitorCommentDTO: Codable {
    let hostBandID: String
    let authorID: String
    let content: String
    let createdAt: Timestamp
}

extension VisitorCommentDTO {
    
    func toVisitorComment() async throws -> VisitorComment {
        let bandAPI = BandAPI()
        
        async let hostBand = bandAPI.getBandInfo(bandID: self.hostBandID)
        async let auther = bandAPI.getBandInfo(bandID: self.authorID)
        
        return VisitorComment(
            hostBand: try await hostBand,
            author: try await auther,
            content: self.content,
            createdAt: self.createdAt.dateValue()
        )
        
    }
    
    func changeValue(authorID: String) -> Self {
        VisitorCommentDTO(
            hostBandID: self.hostBandID,
            authorID: authorID,
            content: self.content,
            createdAt: createdAt
        )
    }
    
    func changeValue(createdAt: Timestamp) -> Self {
        VisitorCommentDTO(
            hostBandID: self.hostBandID,
            authorID: self.authorID,
            content: self.content,
            createdAt: createdAt
        )
    }
    
}

extension VisitorComment {
    
    func toVisitorCommentDTO() -> VisitorCommentDTO {
        return VisitorCommentDTO(
            hostBandID: self.hostBand.bandID,
            authorID: self.author.bandID,
            content: self.content,
            createdAt: Timestamp(date: self.createdAt)
        )
    }
    
}
