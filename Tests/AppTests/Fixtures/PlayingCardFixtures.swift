//
//  PlayingCardFixtures.swift
//  
//
//  Created by Robert Walker on 12/4/20.
//
@testable import App

let playerHandLinear = [
    PlayingCard(faceValue: .one),
    PlayingCard(faceValue: .two),
    PlayingCard(faceValue: .three),
    PlayingCard(faceValue: .question),
]

let playerHandPowersOfTwo = [
    PlayingCard(faceValue: .one),
    PlayingCard(faceValue: .two),
    PlayingCard(faceValue: .four),
    PlayingCard(faceValue: .eight),
    PlayingCard(faceValue: .question),
]

let playerHandFibonacci = [
    PlayingCard(faceValue: .one),
    PlayingCard(faceValue: .two),
    PlayingCard(faceValue: .three),
    PlayingCard(faceValue: .five),
    PlayingCard(faceValue: .eight),
    PlayingCard(faceValue: .question),
]
