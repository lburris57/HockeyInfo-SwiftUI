//
//  URLHelper.swift
//  HockeyInfoSwiftUI
//
//  Created by Larry Burris on 10/17/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation

class URLHelper
{
    static let userSettings = UserSettings()
    
    let season = userSettings.season
    let seasonType = userSettings.seasonType
    let playoffYear = userSettings.playoffYear
    let isPlayoffs = Constants.USER_DEFAULTS.bool(forKey: Constants.IS_PLAYOFFS)
    
    var seasonSettingURL: String
    
    init()
    {
        print("Value of season is: \(season)")
        print("Value of seasonType is: \(seasonType)")
        print("Value of playoffYear is: \(playoffYear)")
        print("Value of isPlayoffs is: \(isPlayoffs)")
        
        seasonSettingURL = isPlayoffs ? playoffYear : season + "-" + Constants.REGULAR_SEASON.lowercased()
    }
    
    func retrieveFullSeasonURL() -> String
    {
        return "https://api.mysportsfeeds.com/v2.1/pull/nhl/\(seasonSettingURL)/games.json"
    }
    
    func retrieveRosterPlayersURL() -> String
    {
        return "https://api.mysportsfeeds.com/v2.1/pull/nhl/players.json?rosterstatus=assigned-to-roster&season=\(seasonSettingURL)"
    }
    
    func retrieveStandingsURL() -> String
    {
        return "https://api.mysportsfeeds.com/v2.1/pull/nhl/\(seasonSettingURL)/standings.json"
    }
    
    func retrievePlayerStatsURL() -> String
    {
        return "https://api.mysportsfeeds.com/v2.1/pull/nhl/\(seasonSettingURL)/player_stats_totals.json"
    }
    
    func retrievePlayerInjuriesURL() -> String
    {
        return "https://api.mysportsfeeds.com/v2.1/pull/nhl/injuries.json"
    }
    
    func retrieveGameLogsURL() -> String
    {
        return "https://api.mysportsfeeds.com/v2.1/pull/nhl/\(seasonSettingURL)/team_gamelogs.json?team=\(Constants.ALL_TEAMS)"
    }
    
    func retrieveScoringSummaryURL(_ gameId: Int) -> String
    {
        return "https://api.mysportsfeeds.com/v2.1/pull/nhl/\(seasonSettingURL)/games/\(gameId)/boxscore.json?teamstats=none&playerstats=none"
    }
    
    func retrieveLatestScheduleInfoURL(_ dateRange: String) -> String
    {
        return "https://api.mysportsfeeds.com/v2.1/pull/nhl/\(seasonSettingURL)/games.json?team=\(Constants.ALL_TEAMS)&date=\(dateRange)"
    }
    
    func retrieveScheduleForDateURL(_ scheduledDate: String) -> String
    {
        return "https://api.mysportsfeeds.com/v2.1/pull/nhl/\(seasonSettingURL)/date/\(scheduledDate)/games.json"
    }
}
