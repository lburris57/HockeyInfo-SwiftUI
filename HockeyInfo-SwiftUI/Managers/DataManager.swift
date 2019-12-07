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
    var tableModelString = constructTableModelString()
    
    let networkManager = NetworkManager()
    let databaseManager = DBManager()
    
    func seasonScheduleTableHasBeenLoaded() -> Bool
    {
        if let userDefaultTableInformationModel = UserDefaultsHelper.retrieveUserDefaultsTableInformationData(for: tableModelString)
        {
            if userDefaultTableInformationModel.isSeasonScheduleTableLoaded
            {
                return true
            }
        }
        
        return false
    }
    
    func teamTableHasBeenLoaded() -> Bool
    {
        if let userDefaultTableInformationModel = UserDefaultsHelper.retrieveUserDefaultsTableInformationData(for: tableModelString)
        {
            if userDefaultTableInformationModel.isTeamTableLoaded
            {
                return true
            }
        }
        
        return false
    }
    
    func playerTableHasBeenLoaded() -> Bool
    {
        if let userDefaultTableInformationModel = UserDefaultsHelper.retrieveUserDefaultsTableInformationData(for: tableModelString)
        {
            if userDefaultTableInformationModel.isPlayerTableLoaded
            {
                return true
            }
        }
        
        return false
    }
    
    func loadSeasonScheduleData() -> [NHLSchedule]
    {
        var nhlSchedules = [NHLSchedule]()
        
        if seasonScheduleTableHasBeenLoaded()
        {
            //  Retrieve from the database
        }
        else
        {
            //  Retrieve from the network
            
            //networkManager.retrieveFullSeasonSchedule(completion: <#([NHLSchedule]) -> ()#>)
        }
        
        return nhlSchedules
    }
    
    static func constructTableModelString() -> String
    {
        let userSettings = UserSettings()
        
        let season = userSettings.season
        let isPlayoffs = userSettings.isPlayoffs
        
        return "tableModel" + season + (isPlayoffs ? "P" : "")
    }
}
