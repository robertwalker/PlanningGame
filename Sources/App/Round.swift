//
//  Round.swift
//  
//
//  Created by Robert Walker on 12/1/20.
//

import Foundation

struct Round: Equatable {
    var storyName: String
    var pointValue: FaceValue
    var hasEnded = false
    
    init?(storyName: String) {
        if storyName.trimmingCharacters(in: .whitespacesAndNewlines) == "" { return nil }
        self.storyName = storyName
        self.pointValue = .question
    }
}
