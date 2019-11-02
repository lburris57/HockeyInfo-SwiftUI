//
//  TeamStandingsData.swift
//  Hockey Info SwiftUI
//
//  Created by Larry Burris on 06/16/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation
import SwiftUI

struct TeamStandingsData: Codable, Hashable, Identifiable
{
    var id = UUID()
    var teamInformation: TeamInformation
    var teamStats: TeamStats
    var overallRankInfo: OverallRankData
    var conferenceRankInfo: ConferenceRankData
    var divisionRankInfo: DivisionRankData
    var playoffRankInfo: PlayoffRankData
    
    private enum CodingKeys : String, CodingKey
    {
        case teamInformation = "team"
        case teamStats = "stats"
        case overallRankInfo = "overallRank"
        case conferenceRankInfo = "conferenceRank"
        case divisionRankInfo = "divisionRank"
        case playoffRankInfo = "playoffRank"
    }
}
