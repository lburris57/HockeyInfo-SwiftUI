//
//  PlayerInfo.swift
//  Hockey Info SwiftUI
//
//  Created by Larry Burris on 06/16/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation
import SwiftUI

struct PlayerInfo: Codable, Hashable, Identifiable
{
    var id = UUID()
    var player: PlayerData
    var currentTeamInfo: CurrentTeamData?
    
    private enum CodingKeys : String, CodingKey
    {
        case player = "player"
        case currentTeamInfo = "teamAsOfDate"
    }
}
