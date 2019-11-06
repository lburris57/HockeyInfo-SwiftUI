//
//  ScheduledGameModel.swift
//  HockeyInfo-SwiftUI
//
//  Created by Larry Burris on 11/4/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation

class ScheduledGameModel: Identifiable
{
    var id = UUID()
    var gameInfo = Constants.EMPTY_STRING
    var venue: String = Constants.EMPTY_STRING
    var startTime: String = Constants.EMPTY_STRING
}
