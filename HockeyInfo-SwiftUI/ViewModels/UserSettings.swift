//
//  UserSettings.swift
//  HockeyInfoSwiftUI
//
//  Created by Larry Burris on 7/13/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation
import SwiftUI
import Combine

final class UserSettings: ObservableObject
{
    let userDefaults = UserDefaults.standard
    
    var willChange = PassthroughSubject<Void, Never>()
    
    var oldSeasonValue = Constants.EMPTY_STRING
    var oldPlayoffYearValue = Constants.EMPTY_STRING
    var oldSeasonTypeValue = Constants.EMPTY_STRING
    
    var isValid = true
    
    var seasonType = Constants.EMPTY_STRING
    {
        willSet
        {
            oldSeasonValue = userDefaults.string(forKey: Constants.SEASON_TYPE) ?? Constants.EMPTY_STRING
            
            print("Previously selected season type is: \(userDefaults.string(forKey: Constants.SEASON_TYPE) ?? "Unknown season type")")
            
            willChange.send(())
        }
        
        didSet
        {
            userDefaults.set(seasonType, forKey: Constants.SEASON_TYPE)
            
            print("Selected season type is: \(userDefaults.string(forKey: Constants.SEASON_TYPE) ?? "Unknown season type")")
        }
    }
    
    var season = Constants.EMPTY_STRING
    {
        willSet
        {
            oldSeasonTypeValue = userDefaults.string(forKey: Constants.SEASON) ?? Constants.EMPTY_STRING
            
            print("Previously selected season is: \(userDefaults.string(forKey: Constants.SEASON) ?? "Unknown season")")
            
            willChange.send(())
        }
        
        didSet
        {
            userDefaults.set(season, forKey: Constants.SEASON)
            
            print("Selected season is: \(userDefaults.string(forKey: Constants.SEASON) ?? "Unknown season")")
        }
    }
    
    var playoffYear = Constants.EMPTY_STRING
    {
        willSet
        {
            oldPlayoffYearValue = userDefaults.string(forKey: Constants.PLAYOFF_YEAR) ?? Constants.EMPTY_STRING
            
            print("Previously selected playoff year is: \(userDefaults.string(forKey: Constants.PLAYOFF_YEAR) ?? "Unknown playoff year")")
            
            willChange.send(())
        }
        
        didSet
        {
            userDefaults.set(season, forKey: Constants.PLAYOFF_YEAR)
            
            print("Selected playoff year is: \(userDefaults.string(forKey: Constants.PLAYOFF_YEAR) ?? "Unknown playoff year")")
        }
    }
    
    init()
    {
        self.seasonType = userDefaults.string(forKey: Constants.SEASON_TYPE) ?? Constants.REGULAR_SEASON
        self.playoffYear = userDefaults.string(forKey: Constants.PLAYOFF_YEAR) ?? TimeAndDateUtils.getCurrentPlayoffSeason()
        self.season = userDefaults.string(forKey: Constants.SEASON) ?? "2018-2019"
    }
}
