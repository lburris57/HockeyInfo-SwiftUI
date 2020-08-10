//
//  UserDefaultsHelper.swift
//  HockeyInfoSwiftUI
//
//  Created by Larry Burris on 10/20/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation

struct UserDefaultsHelper
{
    let userDefaults = UserDefaults.standard
    
    static func constructSeasonString() -> String
    {
        let userSettings = UserSettingsViewModel()
        
        let season = userSettings.season
        let isPlayoffs = userSettings.isPlayoffs
        
        return season + (isPlayoffs ? "-Playoffs" : "")
    }
}
