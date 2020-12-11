@testable import App

func makeOnePlayerGameSession(pointScale: PointScale) -> GameSession {
    let gameMaster = Player(name: "Game Master")
    var gameSession = GameSession(gameMaster: gameMaster, pointScale: pointScale)
    let playerOne = Player(name: "Player One")
    try! gameSession.append(player: playerOne)
    return gameSession
}

func makeTwoPlayerGameSession(pointScale: PointScale) -> GameSession {
    var gameSession = makeOnePlayerGameSession(pointScale: pointScale)
    let playerTwo = Player(name: "Player Two")
    try! gameSession.append(player: playerTwo)
    return gameSession
}
