//
//  DataManager.swift
//  HockeyInfo-SwiftUI
//
//  Created by Larry Burris on 12/2/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation

class DataManager
{
    let userDefaults = UserDefaults.standard
    
    func loadSeasonScheduleData() -> [NHLSchedule]
    {
        let userSettings = UserSettings()
        
        print("User settings season in DataManager is: \(userSettings.season)")
        print("User settings season type in DataManager is: \(userSettings.seasonType)")
        
        return [NHLSchedule]()
    }
}
