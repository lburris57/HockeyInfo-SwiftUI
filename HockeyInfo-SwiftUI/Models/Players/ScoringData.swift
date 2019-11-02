//
//  ScoringData.swift
//  Hockey Info SwiftUI
//
//  Created by Larry Burris on 06/16/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation
import SwiftUI

struct ScoringData: Codable, Hashable, Identifiable
{
    var id = UUID()
    var goals = 0
    var assists = 0
    var points = 0
    var hatTricks = 0
    var powerplayGoals = 0
    var powerplayAssists = 0
    var powerplayPoints = 0
    var shorthandedGoals = 0
    var shorthandedAssists = 0
    var shorthandedPoints = 0
    var gameWinningGoals = 0
    var gameTyingGoals = 0
    
    private enum CodingKeys : String, CodingKey
    {
        case goals = "goals"
        case assists = "assists"
        case points = "points"
        case hatTricks = "hatTricks"
        case powerplayGoals = "powerplayGoals"
        case powerplayAssists = "powerplayAssists"
        case powerplayPoints = "powerplayPoints"
        case shorthandedGoals = "shorthandedGoals"
        case shorthandedAssists = "shorthandedAssists"
        case shorthandedPoints = "shorthandedPoints"
        case gameWinningGoals = "gameWinningGoals"
        case gameTyingGoals = "gameTyingGoals"
    }
}
