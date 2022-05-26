//
//  PlayingCard.swift
//  
//
//  Created by Robert Walker on 12/8/20.
//

import Foundation

public enum FaceValue: String {
    case question = "question"
    case skip = "skip"
    case one = "one"
    case two = "two"
    case three = "three"
    case four = "four"
    case five = "five"
    case eight = "eight"
    
    var pointValue: Int {
        get {
            switch self {
            case .question:
                return 0
            case .skip:
                return 0
            case .one:
                return 1
            case .two:
                return 2
            case .three:
                return 3
            case .four:
                return 4
            case .five:
                return 5
            case .eight:
                return 8
            }
        }
    }
}

public struct PlayingCard {
    public let faceValue: FaceValue
    public var isFaceDown = false
    
    public init(faceValue: FaceValue, isFaceDown: Bool) {
        self.faceValue = faceValue
        self.isFaceDown = isFaceDown
    }
    
    public init(faceValue: FaceValue) {
        self.faceValue = faceValue
    }
}

extension PlayingCard: Equatable {
    public static func ==(lhs: PlayingCard, rhs: PlayingCard) -> Bool {
        return lhs.faceValue == rhs.faceValue
    }
}
