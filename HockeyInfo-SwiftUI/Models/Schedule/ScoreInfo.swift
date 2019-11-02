//
//  ScoreInfo.swift
//  Hockey Info SwiftUI
//
//  Created by Larry Burris on 06/16/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation
import SwiftUI

struct ScoreInfo: Codable, Hashable, Identifiable
{
    var id = UUID()
    var currentPeriod : Int?
    var currentPeriodSecondsRemaining: Int?
    var awayScoreTotal: Int?
    var awayShotsTotal: Int?
    var homeScoreTotal: Int?
    var homeShotsTotal: Int?
    var periodList: [PeriodInfo]?
    
    private enum CodingKeys : String, CodingKey
    {
        case currentPeriod = "currentPeriod"
        case currentPeriodSecondsRemaining = "currentPeriodSecondsRemaining"
        case awayScoreTotal = "awayScoreTotal"
        case awayShotsTotal = "awayShotsTotal"
        case homeScoreTotal = "homeScoreTotal"
        case homeShotsTotal = "homeShotsTotal"
        case periodList = "periods"
    }
}
