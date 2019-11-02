//
//  OverallRankData.swift
//  Hockey Info SwiftUI
//
//  Created by Larry Burris on 06/16/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation
import SwiftUI

struct OverallRankData: Codable, Hashable, Identifiable
{
    var id = UUID()
    var rank = 0
    var gamesBack: Double = 0.0
    
    private enum CodingKeys : String, CodingKey
    {
        case rank = "rank"
        case gamesBack = "gamesBack"
    }
}
