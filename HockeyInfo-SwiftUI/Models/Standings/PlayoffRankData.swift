//
//  PlayoffRankData.swift
//  Hockey Info SwiftUI
//
//  Created by Larry Burris on 06/16/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation
import SwiftUI

struct PlayoffRankData: Codable, Hashable, Identifiable
{
    var id = UUID()
    var conferenceName: String
    var divisionName: String?
    var appliesTo: String
    var rank: Int = 0
    
    private enum CodingKeys : String, CodingKey
    {
        case conferenceName = "conferenceName"
        case divisionName = "divisionName"
        case appliesTo = "appliesTo"
        case rank = "rank"
    }
}
