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
    let networkManager = NetworkManager()
    let databaseManager = DBManager()
    
    let model = UserDefaultManager.decodeDataFromUserDefaults(for: constructSeasonString())
    
    func loadSeasonScheduleData() -> [NHLSchedule]
    {
        var nhlSchedules = [NHLSchedule]()
        
        if model.isSeasonScheduleTableLoaded
        {
            nhlSchedules = databaseManager.retrieveFullSeasonSchedule()
        }
        else
        {
            //  Retrieve from the network
            
            //networkManager.retrieveFullSeasonSchedule(completion: ([NHLSchedule]) -> ())
        }
        
        return nhlSchedules
    }
    
    static func constructSeasonString() -> String
    {
        let userSettings = UserSettings()
        
        let season = userSettings.season
        let isPlayoffs = userSettings.isPlayoffs
        
        return season + (isPlayoffs ? "-Playoffs" : "")
    }
}
