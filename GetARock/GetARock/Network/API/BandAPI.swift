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
    
}
