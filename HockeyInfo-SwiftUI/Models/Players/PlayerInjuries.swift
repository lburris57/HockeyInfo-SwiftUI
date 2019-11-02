//
//  PlayerInjuries.swift
//  Hockey Info SwiftUI
//
//  Created by Larry Burris on 06/16/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation
import SwiftUI

struct PlayerInjuries: Codable, Hashable, Identifiable
{
    var id = UUID()
    var lastUpdatedOn = ""
    var playerInfoList = [PlayerInjuryInfo]()
    
    private enum CodingKeys : String, CodingKey
    {
        case lastUpdatedOn = "lastUpdatedOn"
        case playerInfoList = "players"
    }
}
