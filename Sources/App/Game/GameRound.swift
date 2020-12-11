//
//  GameRound.swift
//  
//
//  Created by Robert Walker on 12/1/20.
//

import Foundation

struct GameRound {
    var storyName: String
    var pointValue: FaceValue
    
    init(storyName: String) {
        self.storyName = storyName
        self.pointValue = .question
    }
}
