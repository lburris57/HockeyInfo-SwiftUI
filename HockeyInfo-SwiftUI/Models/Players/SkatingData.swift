//
//  SkatingData.swift
//  Hockey Info SwiftUI
//
//  Created by Larry Burris on 06/16/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation
import SwiftUI

struct SkatingData: Codable, Hashable, Identifiable
{
    var id = UUID()
    var plusMinus = 0
    var shots = 0
    var shotPercentage = 0.0
    var blockedShots = 0
    var hits = 0
    var faceoffs = 0
    var faceoffWins = 0
    var faceoffLosses = 0
    var faceoffPercent = 0.0
    
    private enum CodingKeys : String, CodingKey
    {
        case plusMinus = "plusMinus"
        case shots = "shots"
        case shotPercentage = "shotPercentage"
        case blockedShots = "blockedShots"
        case hits = "hits"
        case faceoffs = "faceoffs"
        case faceoffWins = "faceoffWins"
        case faceoffLosses = "faceoffLosses"
        case faceoffPercent = "faceoffPercent"
    }
}
