//
//  ScoringInfo.swift
//  Hockey Info SwiftUI
//
//  Created by Larry Burris on 06/16/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation
import SwiftUI

struct ScoringInfo: Codable, Hashable, Identifiable
{
    var id = UUID()
    var homeScoreTotal: Int
    var awayScoreTotal: Int
    var periodList: [PeriodScoringData]
    
    private enum CodingKeys : String, CodingKey
    {
        case homeScoreTotal = "homeScoreTotal"
        case awayScoreTotal = "awayScoreTotal"
        case periodList = "periods"
    }
}
