//
//  EventComment.swift
//  GetARock
//
//  Created by 김수진 on 2022/11/19.
//

import Foundation

struct GatheringCommentInfo {
    let commentID: String
    let comment: GatheringComment
}

struct GatheringComment {
    let gathering: GatheringInfo
    let author: BandInfo
    let content: String
    let createdAt: Date
}
