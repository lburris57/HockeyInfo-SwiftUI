//
//  PlayerStatId.swift
//  Hockey Info SwiftUI
//
//  Created by Larry Burris on 06/16/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation
import SwiftUI

struct PlayerStatId: Codable, Hashable, Identifiable
{
    var id: Int = 0
    var firstName = ""
    var lastName = ""
    var currentTeam = CurrentTeamData()
    
    private enum CodingKeys : String, CodingKey
    {
        case id = "id"
        case firstName = "firstName"
        case lastName = "lastName"
        case currentTeam = "currentTeam"
    }
}
