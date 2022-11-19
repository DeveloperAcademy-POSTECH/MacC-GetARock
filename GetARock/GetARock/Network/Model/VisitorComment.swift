//
//  VisitorComment.swift
//  GetARock
//
//  Created by 김수진 on 2022/11/18.
//

import Foundation

struct VisitorCommentInfo {
    let commentID: String
    var comment: VisitorComment
}

struct VisitorComment {
    let hostBand: BandInfo
    let guestBand: BandInfo
    let content: String
    let createdAt: Date
}
