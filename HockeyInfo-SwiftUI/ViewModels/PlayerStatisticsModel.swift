//
//  PlayerStatisticsModel.swift
//  HockeyInfo-SwiftUI
//
//  Created by Larry Burris on 11/2/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation

class PlayerStatisticsModel: Identifiable
{
    var id = UUID()
    var playerId: Int = 0
    var gamesPlayed: Int = 0
    var goals: Int = 0
    var assists: Int = 0
    var points: Int = 0
    var hatTricks: Int = 0
    var powerplayGoals: Int = 0
    var powerplayAssists: Int = 0
    var powerplayPoints: Int = 0
    var shortHandedGoals: Int = 0
    var shortHandedAssists: Int = 0
    var shortHandedPoints: Int = 0
    var gameWinningGoals: Int = 0
    var gameTyingGoals: Int = 0
    var penalties: Int = 0
    var penaltyMinutes: Int = 0
    
    //  Skater Data
    var plusMinus: Int = 0
    var shots: Int = 0
    var shotPercentage: Double = 0.0
    var blockedShots: Int = 0
    var hits: Int = 0
    var faceoffs: Int = 0
    var faceoffWins: Int = 0
    var faceoffLosses: Int = 0
    var faceoffPercent: Double = 0.0
    
    //  Goaltending data
    var wins: Int = 0
    var losses: Int = 0
    var overtimeWins: Int = 0
    var overtimeLosses: Int = 0
    var goalsAgainst: Int = 0
    var shotsAgainst: Int = 0
    var saves: Int = 0
    var goalsAgainstAverage: Double = 0.0
    var savePercentage: Double = 0.0
    var shutouts: Int = 0
    var gamesStarted: Int = 0
    var creditForGame: Int = 0
    var minutesPlayed: Int = 0
}
