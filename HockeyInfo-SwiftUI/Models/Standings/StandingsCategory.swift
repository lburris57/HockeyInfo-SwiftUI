//
//  StandingsCategory.swift
//  Hockey Info SwiftUI
//
//  Created by Larry Burris on 06/16/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation
import SwiftUI

struct StandingsCategory: Codable, Hashable, Identifiable
{
    var id = UUID()
    var category: String
    var fullName: String
    var description: String
    var abbreviation: String
    var type: String
    
    private enum CodingKeys : String, CodingKey
    {
        case category = "category"
        case fullName = "fullName"
        case description = "description"
        case abbreviation = "abbreviation"
        case type = "type"
    }
}
