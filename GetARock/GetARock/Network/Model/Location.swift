//
//  Location.swift
//  GetARock
//
//  Created by 김수진 on 2022/11/18.
//

import Foundation

struct Location {
    /// 나타내고자하는  위치의 이름입니다.
    let name: String
    /// 나타내고자하는  위치의 주소입니다.
    let address: String
    /// 나타내고자하는  위치의 세부 주소입니다.
    /// ex) 건물의 동호수
    let additionalAddress: String
    /// 나타내고자하는  위치의 좌표입니다.
    let coordinate: Coordinate
}
