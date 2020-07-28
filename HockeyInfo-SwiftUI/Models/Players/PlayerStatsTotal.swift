//
//  PlayerStatsTotal.swift
//  Hockey Info SwiftUI
//
//  Created by Larry Burris on 06/16/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation
import SwiftUI

struct PlayerStatsTotal: Codable, Hashable, Identifiable
{
    var id = UUID()
    var player: PlayerStatId?
    var playerStats: PlayerStatData?
    
    private enum CodingKeys : String, CodingKey
    {
        case player = "player"
        case playerStats = "stats"
    }
}
