//
//  GameLogData.swift
//  Hockey Info SwiftUI
//
//  Created by Larry Burris on 06/16/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation
import SwiftUI

struct GameLogData: Codable, Hashable, Identifiable
{
    var id = UUID()
    var game: GameData
    var team: TeamData
    var stats: StatsData
    
    private enum CodingKeys : String, CodingKey
    {
        case game = "game"
        case team = "team"
        case stats = "stats"
    }
}
