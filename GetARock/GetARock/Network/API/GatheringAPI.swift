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

    private let database = FirebaseFirestore.Firestore.firestore()
    
    func saveGathering(gathering: Gathering) async throws -> GatheringID {
        guard let email = AuthAPI().getCurrentUser()?.email else { throw AuthError.noEmailInfo }
        var gatheringDTO = gathering.toGatheringDTO()
        gatheringDTO.hostBandID = email
        gatheringDTO.createdAt = Timestamp()
        
        let reference = database.collection("gathering")
        let result = try await reference.addDocument(from: gatheringDTO)
        return result.documentID
    }
    
    func getGatheringInfo(gatheringID: String) async throws -> GatheringInfo {
        let snapShot = try await database.collection("gathering").document(gatheringID).getDocument()
        let gatheringData = try snapShot.data(as: GatheringDTO.self)
        let gatheringInfo = try await gatheringData.toGathering()

        return GatheringInfo(gatheringID: gatheringID, gathering: gatheringInfo)
    }
    
    func getAllGatheringInfos() async throws -> [GatheringInfo] {
        let snapShot = try await database.collection("gathering").getDocuments()
        var gatheringInfos: [GatheringInfo] = []
        
        for document in snapShot.documents {
            let gatheringID = document.documentID
            guard let gatheringData = try? document.data(as: GatheringDTO.self) else { continue }
            // TODO: 밴드 정보를 가져오면서 생기는 지연현상 개선 필요
            guard let gathering = try? await gatheringData.toGathering() else { continue }
            let gatheringInfo = GatheringInfo(gatheringID: gatheringID, gathering: gathering)
            gatheringInfos.append(gatheringInfo)
        }
        
        return gatheringInfos
    }
    
}
