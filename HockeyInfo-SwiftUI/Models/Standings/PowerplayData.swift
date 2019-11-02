//
//  PowerplayData.swift
//  Hockey Info SwiftUI
//
//  Created by Larry Burris on 06/16/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation
import SwiftUI

struct PowerplayData: Codable, Hashable, Identifiable
{
    var id = UUID()
    var powerplays: Int = 0
    var powerplayGoals: Int = 0
    var powerplayPercent: Double = 0.0
    var penaltyKills: Int = 0
    var penaltyKillGoalsAllowed: Int = 0
    var penaltyKillPercent: Double = 0.0
    
    private enum CodingKeys : String, CodingKey
    {
        case powerplays = "powerplays"
        case powerplayGoals = "powerplayGoals"
        case powerplayPercent = "powerplayPercent"
        case penaltyKills = "penaltyKills"
        case penaltyKillGoalsAllowed = "penaltyKillGoalsAllowed"
        case penaltyKillPercent = "penaltyKillPercent"
    }
}
