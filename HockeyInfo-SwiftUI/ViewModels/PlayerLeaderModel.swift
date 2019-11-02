//
//  PlayerLeaderModel.swift
//  HockeyInfoSwiftUI
//
//  Created by Larry Burris on 7/18/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation
import SwiftUI

struct PlayerLeaderModel: Hashable, Identifiable
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
    var shutouts: Int = 0
    var goalsAgainstAverage: Double = 0.0
    var savePercentage: Double = 0.0
    var imageURL: String = Constants.EMPTY_STRING
    var season: String = Constants.EMPTY_STRING
    var seasonType: String = Constants.EMPTY_STRING
}
