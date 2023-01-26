//
//  CollectionReference+Extension.swift
//  GetARock
//
//  Created by 김수진 on 2022/12/04.
//

import FirebaseFirestore

extension CollectionReference {
    
    func addDocument<T: Encodable>(from value: T,
                                   encoder: Firestore.Encoder = Firestore.Encoder()) async throws
    -> DocumentReference {
        let encoded = try encoder.encode(value)
        
        typealias DocumentReferenceContinuation = CheckedContinuation<DocumentReference, Error>
        return try await withCheckedThrowingContinuation({ (continuation: DocumentReferenceContinuation) in
            let result = addDocument(data: encoded) { error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
            }
            continuation.resume(returning: result)
        })
        
    }
    
}
