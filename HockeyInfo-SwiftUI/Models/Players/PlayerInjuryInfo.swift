//
//  PlayerInjuryInfo.swift
//  Hockey Info SwiftUI
//
//  Created by Larry Burris on 06/16/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation
import SwiftUI

struct PlayerInjuryInfo: Codable, Hashable, Identifiable
{
    var id = 0
    var firstName = ""
    var lastName = ""
    var position = ""
    var jerseyNumber = 0
    var currentTeamInfo = CurrentTeamData()
    var currentInjuryInfo = CurrentInjuryData()
    
    private enum CodingKeys : String, CodingKey
    {
        case id = "id"
        case firstName = "firstName"
        case lastName = "lastName"
        case position = "primaryPosition"
        case jerseyNumber = "jerseyNumber"
        case currentTeamInfo = "currentTeam"
        case currentInjuryInfo = "currentInjury"
    }
}
