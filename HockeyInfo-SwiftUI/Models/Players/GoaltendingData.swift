//
//  GoaltendingData.swift
//  Hockey Info SwiftUI
//
//  Created by Larry Burris on 06/16/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation
import SwiftUI

struct GoaltendingData: Codable, Hashable, Identifiable
{
    var id = UUID()
    var wins = 0
    var losses = 0
    var overtimeWins = 0
    var overtimeLosses = 0
    var goalsAgainst = 0
    var shotsAgainst = 0
    var saves = 0
    var goalsAgainstAverage = 0.0
    var savePercentage = 0.0
    var shutouts = 0
    var gamesStarted = 0
    var creditForGame = 0
    var minutesPlayed = 0
    
    private enum CodingKeys : String, CodingKey
    {
        case wins = "wins"
        case losses = "losses"
        case overtimeWins = "overtimeWins"
        case overtimeLosses = "overtimeLosses"
        case goalsAgainst = "goalsAgainst"
        case shotsAgainst = "shotsAgainst"
        case saves = "saves"
        case goalsAgainstAverage = "goalsAgainstAverage"
        case savePercentage = "savePercentage"
        case shutouts = "shutouts"
        case gamesStarted = "gamesStarted"
        case creditForGame = "creditForGame"
        case minutesPlayed = "minutesPlayed"
    }
}
