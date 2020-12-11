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
    
    var imageName: String {
        switch self {
        case .question:
            return "question_card.png"
        case .one:
            return "one_card.png"
        case .two:
            return "two_card.png"
        case .three:
            return "three_card.png"
        case .four:
            return "four_card.png"
        case .five:
            return "five_card.png"
        case .eight:
            return "eight_card.png"
        }
    }
}

struct PlayingCard: Equatable {
    let faceValue: FaceValue
    var isFaceDown = false
    var imageName: String {
        if isFaceDown {
            return "card_back.png"
        }
        return faceValue.imageName
    }
}
