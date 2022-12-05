//
//  Band.swift
//  GetARock
//
//  Created by 김수진 on 2022/11/17.
//

import Foundation

struct BandInfo {
    let bandID: String
    var band: Band
}

struct Band: Codable {
    /// 포지션과 해당 포지션의 인원을 나타냅니다.
    struct PositionSet: Codable {
        var position: PlayPosition
        var numberOfPerson: Int
    }
    
    /// 밴드의 이름입니다.
    var name: String
    /// 밴드가 갖고있는 포지션입니다.
    var filledPosition: [PositionSet]
    /// 밴드의 합주곡입니다.
    var repertoire: [String]
    /// 밴드의 연령대입니다.
    var ageGroups: [AgeGroup]
    /// 밴드의 합주실 위치입니다.
    var location: Location
    /// 밴드의 자유소개 글입니다.
    var introduction: String
}

extension Band {
    func getNumberOfMembers() -> Int {
        var sum = 0
        self.filledPosition.forEach { positionSet in
            sum += positionSet.numberOfPerson
        }
        return sum
    }
}
