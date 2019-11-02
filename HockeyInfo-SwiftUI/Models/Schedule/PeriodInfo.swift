//
//  PeriodInfo.swift
//  Hockey Info SwiftUI
//
//  Created by Larry Burris on 06/16/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation
import SwiftUI

struct PeriodInfo: Codable, Hashable, Identifiable
{
    var id = UUID()
    var periodNumber: Int = 0
    var awayScore: Int = 0
    var awayShots: Int = 0
    var homeScore: Int = 0
    var homeShots: Int = 0
    
    private enum CodingKeys : String, CodingKey
    {
        case periodNumber = "periodNumber"
        case awayScore = "awayScore"
        case awayShots = "awayShots"
        case homeScore = "homeScore"
        case homeShots = "homeShots"
    }
}
