//
//  ScoringPlay.swift
//  Hockey Info SwiftUI
//
//  Created by Larry Burris on 06/16/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation
import SwiftUI

struct ScoringPlay: Codable, Hashable, Identifiable
{
    var id = UUID()
    var team: TeamData
    var periodSecondsElapsed: Int
    var playDescription: String
    
    private enum CodingKeys : String, CodingKey
    {
        case team = "team"
        case periodSecondsElapsed = "periodSecondsElapsed"
        case playDescription = "playDescription"
    }
}
