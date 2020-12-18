//
//  Requests.swift
//  
//
//  Created by Robert Walker on 12/11/20.
//

import Foundation

protocol StartGameRequester {
    var gameMaster: Player { get }
    var pointScale: PointScale { get }
}

struct StartGameRequest: StartGameRequester {
    let gameMaster: Player
    let pointScale: PointScale
}
