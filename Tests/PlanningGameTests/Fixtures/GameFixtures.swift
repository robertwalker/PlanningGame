@testable import PlanningGame

func makeOnePlayerGame(pointScale: PointScale) -> Game {
    let gameMaster = Player(name: "Game Master")
    var game = Game(gameMaster: gameMaster, pointScale: pointScale)
    let playerOne = Player(name: "Player One")
    try! game.addPlayer(playerOne)
    return game
}

func makeTwoPlayerGame(pointScale: PointScale) -> Game {
    var game = makeOnePlayerGame(pointScale: pointScale)
    let playerTwo = Player(name: "Player Two")
    try! game.addPlayer(playerTwo)
    return game
}

func makeOnePlayerGameInRoundOne(pointScale: PointScale) -> Game {
    var game = makeOnePlayerGame(pointScale: pointScale)
    let roundOne = Round(storyName: "Story One")
    try! game.startRound(round: roundOne)
    return game
}

func makeTwoPlayerGameInRoundOne(pointScale: PointScale) -> Game {
    var game = makeTwoPlayerGame(pointScale: pointScale)
    let roundOne = Round(storyName: "Story One")
    try! game.startRound(round: roundOne)
    return game
}
