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
    let createdAt: Date
}

