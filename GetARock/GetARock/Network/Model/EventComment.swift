//
//  EventComment.swift
//  GetARock
//
//  Created by 김수진 on 2022/11/19.
//

import Foundation

struct EventCommentInfo {
    let commentID: String
    let comment: EventComment
}

struct EventComment {
    let author: BandInfo
    let content: String
    let createdAt: Date
}
