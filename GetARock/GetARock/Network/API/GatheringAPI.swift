//
//  GatheringAPI.swift
//  GetARock
//
//  Created by 김수진 on 2022/12/04.
//

import Foundation

import FirebaseFirestore
import FirebaseFirestoreSwift

struct GatheringAPI {
    typealias GatheringID = String
    typealias GatheringCommentID = String

    private let database = FirebaseFirestore.Firestore.firestore()
    
    func saveGathering(gathering: Gathering) async throws -> GatheringID {
        guard let email = AuthAPI().getCurrentUser()?.email else { throw AuthError.noEmailInfo }
        let gatheringDTO = gathering
            .toGatheringDTO()
            .changeValue(
                hostBandID: email,
                createdAt: Timestamp()
            )
            
        let reference = database.collection("gathering")
        let result = try await reference.addDocument(from: gatheringDTO)
        return result.documentID
    }
    
    func getGatheringInfo(gatheringID: String) async throws -> GatheringInfo {
        let snapShot = try await database.collection("gathering").document(gatheringID).getDocument()
        var gatheringData = try snapShot.data(as: GatheringDTO.self)
        gatheringData = gatheringData.changeValue(
            status: gatheringData.status.calculateStatus(date: gatheringData.date.dateValue())
        )
        let gatheringInfo = try await gatheringData.toGathering()

        return GatheringInfo(gatheringID: gatheringID, gathering: gatheringInfo)
    }
    
    func getAllGatheringInfos() async throws -> [GatheringInfo] {
        let snapShot = try await database.collection("gathering").getDocuments()
        var gatheringInfos: [GatheringInfo] = []
        
        for document in snapShot.documents {
            let gatheringID = document.documentID
            guard var gatheringData = try? document.data(as: GatheringDTO.self) else { continue }
            gatheringData = gatheringData.changeValue(
                status: gatheringData.status.calculateStatus(date: gatheringData.date.dateValue())
            )

            guard let gathering = try? await gatheringData.toGathering() else { continue }
            let gatheringInfo = GatheringInfo(gatheringID: gatheringID, gathering: gathering)
            gatheringInfos.append(gatheringInfo)
        }
        
        return gatheringInfos.sorted {
            $0.gathering.date > $1.gathering.date
        }
    }
    
    func getAllOwnedGatheringInfos(owner bandID: String) async throws -> [GatheringInfo] {
        let snapShot = try await database.collection("gathering").whereField("hostBandID", isEqualTo: bandID).getDocuments()
        var gatheringInfos: [GatheringInfo] = []
        
        for document in snapShot.documents {
            let gatheringID = document.documentID
            guard var gatheringData = try? document.data(as: GatheringDTO.self) else { continue }
            gatheringData = gatheringData.changeValue(
                status: gatheringData.status.calculateStatus(date: gatheringData.date.dateValue())
            )

            guard let gathering = try? await gatheringData.toGathering() else { continue }
            let gatheringInfo = GatheringInfo(gatheringID: gatheringID, gathering: gathering)
            gatheringInfos.append(gatheringInfo)
        }
        
        return gatheringInfos.sorted {
            $0.gathering.date > $1.gathering.date
        }
    }

    func getAllJoinedGatheringInfos(participant bandID: String) async throws -> [GatheringInfo] {

        let snapShot = try await database.collection("gatheringComment").whereField("authorID", isEqualTo: bandID).getDocuments()
        var gatheringIDs: [String] = []
        var gatheringInfos: [GatheringInfo] = []

        for document in snapShot.documents {
            guard let commentData = try? document.data(as: GatheringCommentDTO.self) else { continue }
            let gatheringID = commentData.gatheringID
            if gatheringIDs.firstIndex(of: gatheringID) != nil {
                continue
            }
            gatheringIDs.append(gatheringID)
        }
        for gatheringID in gatheringIDs {
            guard let gathering = try? await GatheringAPI().getGatheringInfo(gatheringID: gatheringID) else { continue }
            gatheringInfos.append(gathering)
        }
        
        return gatheringInfos.sorted {
            $0.gathering.date > $1.gathering.date
        }
    }
    
    func saveComment(comment: GatheringComment) async throws -> GatheringCommentID {
        guard let email = AuthAPI().getCurrentUser()?.email else { throw AuthError.noEmailInfo }
        let gatheringCommentDTO = comment
            .toGatheringCommentDTO()
            .changeValue(
                authorID: email,
                createdAt: Timestamp()
            )
        let reference = database.collection("gatheringComment")
        let result = try await reference.addDocument(from: gatheringCommentDTO)
        return result.documentID
    }
    
    func getComments(of gatheringID: GatheringID) async throws -> [GatheringCommentInfo] {
        let snapShot = try await database.collection("gatheringComment").whereField("gatheringID", isEqualTo: gatheringID).getDocuments()
        var commentInfos: [GatheringCommentInfo] = []
        
        for document in snapShot.documents {
            let commentID = document.documentID
            guard let commentData = try? document.data(as: GatheringCommentDTO.self) else { continue }
            async let gathering = getGatheringInfo(gatheringID: commentData.gatheringID)
            async let author = BandAPI().getBandInfo(bandID: commentData.authorID)
            
            guard let gathering = try? await gathering else { continue }
            guard let author = try? await author else { continue }
            
            let commentInfo = GatheringCommentInfo(
                commentID: commentID,
                comment: GatheringComment(
                    gathering: gathering,
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
