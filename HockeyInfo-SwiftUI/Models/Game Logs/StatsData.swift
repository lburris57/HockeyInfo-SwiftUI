//
//  StatsData.swift
//  Hockey Info SwiftUI
//
//  Created by Larry Burris on 06/16/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation
import SwiftUI

struct StatsData: Codable, Hashable, Identifiable
{
    var id = UUID()
    var standings: StandingsData
    var faceoffs: FaceoffData
    var powerplay: PowerplayData
    var miscellaneous: MiscellaneousData
    
    private enum CodingKeys : String, CodingKey
    {
        case standings = "standings"
        case faceoffs = "faceoffs"
        case powerplay = "powerplay"
        case miscellaneous = "miscellaneous"
    }
}
