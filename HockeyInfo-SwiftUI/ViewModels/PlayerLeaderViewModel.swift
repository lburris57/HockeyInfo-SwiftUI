//
//  PlayerLeaderViewModel.swift
//  HockeyInfoSwiftUI
//
//  Created by Larry Burris on 7/18/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation

struct PlayerLeaderViewModel
{
    var id = UUID()
    var index: Int = 0
    var firstName: String = Constants.EMPTY_STRING
    var lastName: String = Constants.EMPTY_STRING
    var teamAbbreviation: String = Constants.EMPTY_STRING
    var points: Int = 0
    var goals: Int = 0
    var assists: Int = 0
    var plusMinus: Int = 0
    var wins: Int = 0
    var shutouts: Double = 0
    var goalsAgainstAverage: Double = 0.0
    var savePercentage: Double = 0.0
}
