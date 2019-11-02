//
//  NHLStandings.swift
//  Hockey Info SwiftUI
//
//  Created by Larry Burris on 06/16/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation
import SwiftUI

struct NHLStandings: Codable, Hashable, Identifiable
{
    var id = UUID()
    var lastUpdatedOn: String
    var references: StandingsReferenceData
    var teamList: [TeamStandingsData]
    
    private enum CodingKeys : String, CodingKey
    {
        case lastUpdatedOn = "lastUpdatedOn"
        case references = "references"
        case teamList = "teams"
    }
}
