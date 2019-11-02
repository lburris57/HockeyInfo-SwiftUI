//
//  PlayerStatData.swift
//  Hockey Info SwiftUI
//
//  Created by Larry Burris on 06/16/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation
import SwiftUI

struct PlayerStatData: Codable, Hashable, Identifiable
{
    var id = UUID()
    var gamesPlayed = 0
    var scoringData = ScoringData()
    var skatingData: SkatingData?
    var goaltendingData: GoaltendingData?
    var penaltyData = PenaltyData()
    
    private enum CodingKeys : String, CodingKey
    {
        case gamesPlayed = "gamesPlayed"
        case scoringData = "scoring"
        case skatingData = "skating"
        case goaltendingData = "goaltending"
        case penaltyData = "penalties"
    }
}
