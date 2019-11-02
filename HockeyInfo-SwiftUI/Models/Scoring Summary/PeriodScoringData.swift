//
//  PeriodScoringData.swift
//  Hockey Info SwiftUI
//
//  Created by Larry Burris on 06/16/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation
import SwiftUI

struct PeriodScoringData: Codable, Hashable, Identifiable
{
    var id = UUID()
    var periodNumber: Int
    var homeScore: Int
    var awayScore: Int
    var scoringPlays: [ScoringPlay]
    
    private enum CodingKeys : String, CodingKey
    {
        case periodNumber = "periodNumber"
        case homeScore = "homeScore"
        case awayScore = "awayScore"
        case scoringPlays = "scoringPlays"
    }
}
