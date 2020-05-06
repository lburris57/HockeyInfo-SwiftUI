//
//  UserDefaultManager.swift
//  HockeyInfo-SwiftUI
//
//  Created by Larry Burris on 5/5/20.
//  Copyright © 2020 Larry Burris. All rights reserved.
//
import Foundation

class UserDefaultManager
{
    static let userDefaults = UserDefaults.standard
    
    static let userSettings = UserSettings()
    
    static func encodeDataToUserDefaults(for key: String, _ model: UserDefaultTableInformationModel)
    {
        let encoder = JSONEncoder()

        if let encoded = try? encoder.encode(model)
        {
            userDefaults.set(encoded, forKey: key)
        }
    }

    static func decodeDataFromUserDefaults(for key: String) -> UserDefaultTableInformationModel
    {
        let season = userSettings.season
        let isPlayoffs = userSettings.isPlayoffs
        
        let model = UserDefaultTableInformationModel(season: season, isPlayoffs: isPlayoffs, isSeasonScheduleTableLoaded: false, isTeamTableLoaded: false, isTeamStandingsLoaded: false,
                            isTeamStatisticsLoaded: false, isPlayerTableLoaded: false, isPlayerStatisticsLoaded: false, isPlayerInjuriesLoaded: false, lastUpdated: TimeAndDateUtils.getCurrentDateAsString())
        
        if let savedData = userDefaults.object(forKey: key) as? Data
        {
            let decoder = JSONDecoder()
            
            if let decodedModel = try? decoder.decode(UserDefaultTableInformationModel.self, from: savedData)
            {
                return decodedModel
            }
        }
        
        return model
    }
}
