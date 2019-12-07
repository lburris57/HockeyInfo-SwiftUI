//
//  DataExchangeHelper.swift
//  HockeyInfoSwiftUI
//
//  Created by Larry Burris on 10/13/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation
import RealmSwift

class DataExchangeHelper
{
    let season = Constants.USER_DEFAULTS.string(forKey: Constants.SEASON) ?? "2018-2019"
    let seasonType = Constants.USER_DEFAULTS.string(forKey: Constants.SEASON_TYPE) ?? Constants.REGULAR_SEASON
    
    func convertSeasonScheduleToNHLScheduleList(_ seasonSchedule: SeasonSchedule) -> [NHLSchedule]
    {
        var scheduledGames = [NHLSchedule]()
        
        for scheduledGame in seasonSchedule.gameList
        {
            let nhlSchedule = NHLSchedule()
            
            let startTime = scheduledGame.scheduleInfo.startTime
            
            let lastUpdatedOn = seasonSchedule.lastUpdatedOn
            
            nhlSchedule.id = scheduledGame.scheduleInfo.id
            nhlSchedule.dateCreated = TimeAndDateUtils.getCurrentDateAsString()
            nhlSchedule.lastUpdatedOn = "\(TimeAndDateUtils.getDate(lastUpdatedOn)) at \(TimeAndDateUtils.getTime(lastUpdatedOn))"
            nhlSchedule.date = TimeAndDateUtils.getDate(startTime)
            nhlSchedule.time = TimeAndDateUtils.getTime(startTime)
            nhlSchedule.homeTeam = scheduledGame.scheduleInfo.homeTeamInfo.abbreviation
            nhlSchedule.awayTeam = scheduledGame.scheduleInfo.awayTeamInfo.abbreviation
            nhlSchedule.homeScoreTotal = scheduledGame.scoreInfo.homeScoreTotal ?? 0
            nhlSchedule.awayScoreTotal = scheduledGame.scoreInfo.awayScoreTotal ?? 0
            nhlSchedule.homeShotsTotal = scheduledGame.scoreInfo.homeShotsTotal ?? 0
            nhlSchedule.awayShotsTotal = scheduledGame.scoreInfo.awayShotsTotal ?? 0
            nhlSchedule.playedStatus = scheduledGame.scheduleInfo.playedStatus
            nhlSchedule.scheduleStatus = scheduledGame.scheduleInfo.scheduleStatus
            nhlSchedule.numberOfPeriods = scheduledGame.scoreInfo.periodList?.count ?? 0
            nhlSchedule.currentPeriod = scheduledGame.scoreInfo.currentPeriod ?? 0
            nhlSchedule.currentTimeRemaining = scheduledGame.scoreInfo.currentPeriodSecondsRemaining ?? 0
            nhlSchedule.season = self.season
            nhlSchedule.seasonType = self.seasonType
            
            scheduledGames.append(nhlSchedule)
        }
        
        return scheduledGames
    }
    
    
}
