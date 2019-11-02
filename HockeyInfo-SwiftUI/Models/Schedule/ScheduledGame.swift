//
//  ScheduledGame.swift
//  Hockey Info SwiftUI
//
//  Created by Larry Burris on 06/16/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation
import SwiftUI

struct ScheduledGame: Codable, Hashable, Identifiable
{
    var id = UUID()
    var scheduleInfo: ScheduleInfo
    var scoreInfo: ScoreInfo
    
    private enum CodingKeys : String, CodingKey
    {
        case scheduleInfo = "schedule"
        case scoreInfo = "score"
    }
}
