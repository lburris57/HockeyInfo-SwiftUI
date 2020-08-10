//
//  UserDefaultTableModel.swift
//  HockeyInfo-SwiftUI
//
//  Created by Larry Burris on 12/1/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation

struct UserDefaultTableInformationModel: Codable
{
    var season: String = Constants.EMPTY_STRING
    var isPlayoffs: Bool = false
    var lastUpdated: String = Constants.EMPTY_STRING
}

/*
 
 If initial load, create an instance of UserDefaultTableInformationModel for both the current season and the current playoff season
 in the Constants.S2019_2020 and Constants.P2019_2020 format with the lastUpdated date as current date.
 
 Each time the user updates the settings, check whether the objects exist and create new ones, if needed.  It won't be possible to
 create objects with future dates.
 
 Keep the UserDefaultTableInformationModel for the current season settings in memory.
 
 Each day, the season schedule, team statistics, team standings, player statistics and player injuries must be reloaded for the current season.
 This will be done in the application code.
 
 Make sure to save the objects back to UserDefaults before changing settings or closing the app.
 
*/
