//
//  Round.swift
//  
//
//  Created by Robert Walker on 12/1/20.
//

import Foundation

struct Round {
    var storyName: String
    var pointValue: FaceValue
    var hasEnded = false
    
    init?(storyName: String) {
        if storyName.trimmingCharacters(in: .whitespacesAndNewlines) == "" { return nil }
        self.storyName = storyName
        self.pointValue = .question
    }
}

extension Round: Equatable {
    static func ==(lhs: Round, rhs: Round) -> Bool {
        return lhs.storyName == rhs.storyName
    }
}
