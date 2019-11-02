//
//  ScoringSummary.swift
//  Hockey Info SwiftUI
//
//  Created by Larry Burris on 06/16/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation
import SwiftUI

struct ScoringSummary: Decodable, Identifiable
{
    var id = UUID()
    var lastUpdatedOn: String
    var game: GameReference
    var scoringInfo: ScoringInfo
    
    private enum CodingKeys : String, CodingKey
    {
        case lastUpdatedOn = "lastUpdatedOn"
        case game = "game"
        case scoringInfo = "scoring"
    }
}
