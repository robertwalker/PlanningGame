//
//  Round.swift
//  
//
//  Created by Robert Walker on 12/1/20.
//

import Foundation

public struct Round {
    public var storyName: String
    public var scoreCard = PlayingCard(faceValue: .question)
    public var hasEnded = false
    
    public init(storyName: String) {
        self.storyName = storyName
    }
}

extension Round: Equatable {
    public static func ==(lhs: Round, rhs: Round) -> Bool {
        return lhs.storyName.caseInsensitiveCompare(rhs.storyName) == .orderedSame
    }
}
