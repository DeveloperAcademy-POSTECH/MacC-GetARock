//
//  BandAPI.swift
//  GetARock
//
//  Created by 김수진 on 2022/12/03.
//

import Foundation

import FirebaseFirestore
import FirebaseFirestoreSwift

struct BandAPI {
    typealias BandID = String
    typealias VisitorCommentID = String
    
    private let database = FirebaseFirestore.Firestore.firestore()
    
    func saveBand(band: Band) async throws {
        guard let email = AuthAPI().getCurrentUser()?.email else { throw AuthError.noEmailInfo }
        let bandData = try band.encode()
        let reference = database.collection("band").document(email)
        try await reference.setData(bandData)
    }
    
    func getBandInfo(bandID: String) async throws -> BandInfo {
        let snapShot = try await database.collection("band").document(bandID).getDocument()
        let bandData = try snapShot.data(as: Band.self)
        let bandInfo = BandInfo(bandID: bandID, band: bandData)
        
        return bandInfo
    }
    
    func getAllBandInfos() async throws -> [BandInfo] {
        let snapShot = try await database.collection("band").getDocuments()
        var bandInfos: [BandInfo] = []
        
        for document in snapShot.documents {
            let bandID = document.documentID
            guard let bandData = try? document.data(as: Band.self) else { continue }
            let bandInfo = BandInfo(bandID: bandID, band: bandData)
            bandInfos.append(bandInfo)
        }
        
        return bandInfos
    }
    
    func saveComment(comment: VisitorComment) async throws -> VisitorCommentID {
        guard let email = AuthAPI().getCurrentUser()?.email else { throw AuthError.noEmailInfo }
        var visitorCommentDTO = comment.toVisitorCommentDTO()
        visitorCommentDTO.authorID = email
        visitorCommentDTO.createdAt = Timestamp()
        
        let reference = database.collection("visitorComment")
        let result = try await reference.addDocument(from: visitorCommentDTO)
        return result.documentID
    }
    
    func getComments(of bandID: BandID) async throws -> [VisitorCommentInfo] {
        let snapShot = try await database.collection("visitorComment").getDocuments()
        var commentInfos: [VisitorCommentInfo] = []
        
        // TODO: 지연현상 개선 필요
        for document in snapShot.documents {
            let commentID = document.documentID
            guard let commentData = try? document.data(as: VisitorCommentDTO.self) else { continue }
            async let hostBand = BandAPI().getBandInfo(bandID: commentData.hostBandID)
            async let author = BandAPI().getBandInfo(bandID: commentData.authorID)
            
            guard let hostBand = try? await hostBand else { continue }
            guard let author = try? await author else { continue }
            
            let commentInfo = VisitorCommentInfo(
                commentID: commentID,
                comment: VisitorComment(
                    hostBand: hostBand,
                    author: author,
                    content: commentData.content,
                    createdAt: commentData.createdAt.dateValue()
                )
            )
            commentInfos.append(commentInfo)
        }
        
        return commentInfos
    }
    
}
