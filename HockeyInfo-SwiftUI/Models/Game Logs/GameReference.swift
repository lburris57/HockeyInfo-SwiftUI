//
//  GameReference.swift
//  Hockey Info SwiftUI
//
//  Created by Larry Burris on 06/16/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation
import SwiftUI

struct GameReference: Codable, Hashable, Identifiable
{
    var id = 0
    var startTime: String
    var awayTeam: TeamData
    var homeTeam: TeamData
    var playedStatus: String
    
    private enum CodingKeys : String, CodingKey
    {
        case id = "id"
        case startTime = "startTime"
        case awayTeam = "awayTeam"
        case homeTeam = "homeTeam"
        case playedStatus = "playedStatus"
    }
}
