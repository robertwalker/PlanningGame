//
//  Round.swift
//  
//
//  Created by Robert Walker on 12/1/20.
//

import Foundation

struct Round {
    var storyName: String
    var scoreCard = PlayingCard(faceValue: .question)
    var hasEnded = false
    
    init(storyName: String) {
        self.storyName = storyName
    }
}

extension Round: Equatable {
    static func ==(lhs: Round, rhs: Round) -> Bool {
        return lhs.storyName == rhs.storyName
    }
}
