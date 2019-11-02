//
//  MiscellaneousData.swift
//  Hockey Info SwiftUI
//
//  Created by Larry Burris on 06/16/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation
import SwiftUI

struct MiscellaneousData: Codable, Hashable, Identifiable
{
    var id = UUID()
    var goalsFor: Int = 0
    var goalsAgainst: Int = 0
    var shots: Int = 0
    var penalties: Int = 0
    var penaltyMinutes: Int = 0
    var hits: Int = 0
    
    private enum CodingKeys : String, CodingKey
    {
        case goalsFor = "goalsFor"
        case goalsAgainst = "goalsAgainst"
        case shots = "shots"
        case penalties = "penalties"
        case penaltyMinutes = "penaltyMinutes"
        case hits = "hits"
    }
}
