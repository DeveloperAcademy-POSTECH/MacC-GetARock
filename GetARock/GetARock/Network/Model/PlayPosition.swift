//
//  PlayPosition.swift
//  GetARock
//
//  Created by 김수진 on 2022/11/18.
//

import Foundation

enum PlayPosition {
    case vocal
    case guitar
    case keyboard
    case drum
    case bass
    case etc
    
    func toKorean() -> String {
        switch self {
        case .vocal: return "보컬"
        case .guitar: return "기타"
        case .keyboard: return "키보드"
        case .drum: return "드럼"
        case .bass: return "베이스"
        case .etc: return "그 외"
        }
    }
    
    func imageName() -> String {
        switch self {
        case .vocal: return "Vocal"
        case .guitar: return "Guitar"
        case .keyboard: return "Keyboard"
        case .drum: return "Drum"
        case .bass: return "Bass"
        case .etc: return "Etc"
        }
    }
}
