//
//  TeamStats.swift
//  Hockey Info SwiftUI
//
//  Created by Larry Burris on 06/16/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation
import SwiftUI

struct TeamStats: Codable, Hashable, Identifiable
{
    var id = UUID()
    var gamesPlayed: Int
    var standingsInfo: StandingsData
    var faceoffInfo: FaceoffData
    var powerplayInfo: PowerplayData
    var miscellaneousInfo: MiscellaneousData
    
    private enum CodingKeys : String, CodingKey
    {
        case gamesPlayed = "gamesPlayed"
        case standingsInfo = "standings"
        case faceoffInfo = "faceoffs"
        case powerplayInfo = "powerplay"
        case miscellaneousInfo = "miscellaneous"
    }
}
