//
//  TeamInformation.swift
//  Hockey Info SwiftUI
//
//  Created by Larry Burris on 06/16/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation
import SwiftUI

struct TeamInformation: Codable, Hashable, Identifiable
{
    var id = 0
    var city: String
    var name: String
    var abbreviation: String
    var venueInfo: VenueData
    
    private enum CodingKeys : String, CodingKey
    {
        case id = "id"
        case city = "city"
        case name = "name"
        case abbreviation = "abbreviation"
        case venueInfo = "homeVenue"
    }
}
