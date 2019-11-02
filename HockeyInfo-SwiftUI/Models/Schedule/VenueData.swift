//
//  VenueData.swift
//  Hockey Info SwiftUI
//
//  Created by Larry Burris on 06/16/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation
import SwiftUI

struct VenueData: Codable, Hashable, Identifiable
{
    var id = 0
    var name: String
    
    private enum CodingKeys : String, CodingKey
    {
        case id = "id"
        case name = "name"
    }
}
