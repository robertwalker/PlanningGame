//
//  PlayingCard.swift
//  
//
//  Created by Robert Walker on 12/8/20.
//

import Foundation

enum FaceValue: Int {
    case question = 0
    case one = 1
    case two = 2
    case three = 3
    case four = 4
    case five = 5
    case eight = 8
}

struct PlayingCard {
    let faceValue: FaceValue
    var isFaceDown = false
}

extension PlayingCard: Equatable {
    static func ==(lhs: PlayingCard, rhs: PlayingCard) -> Bool {
        return lhs.faceValue == rhs.faceValue
    }
}
