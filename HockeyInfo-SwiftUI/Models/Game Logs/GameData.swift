//
//  GameData.swift
//  Hockey Info SwiftUI
//
//  Created by Larry Burris on 06/16/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation
import SwiftUI

struct GameData: Codable, Hashable, Identifiable
{
    var id = 0
    var startTime: String
    var awayTeamAbbreviation: String
    var homeTeamAbbreviation: String
    
    private enum CodingKeys : String, CodingKey
    {
        case id = "id"
        case startTime = "startTime"
        case awayTeamAbbreviation = "awayTeamAbbreviation"
        case homeTeamAbbreviation = "homeTeamAbbreviation"
    }
}
