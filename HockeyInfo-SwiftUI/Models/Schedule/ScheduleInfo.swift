//
//  ScheduleInfo.swift
//  Hockey Info SwiftUI
//
//  Created by Larry Burris on 06/16/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation
import SwiftUI

struct ScheduleInfo: Codable, Hashable, Identifiable
{
    var id = 0
    var startTime: String
    var venueAllegiance: String
    var scheduleStatus: String
    var playedStatus: String
    var awayTeamInfo: TeamData
    var homeTeamInfo: TeamData
    var venueInfo: VenueData
    
    private enum CodingKeys : String, CodingKey
    {
        case id = "id"
        case startTime = "startTime"
        case venueAllegiance = "venueAllegiance"
        case scheduleStatus = "scheduleStatus"
        case playedStatus = "playedStatus"
        case awayTeamInfo = "awayTeam"
        case homeTeamInfo = "homeTeam"
        case venueInfo = "venue"
    }
}
