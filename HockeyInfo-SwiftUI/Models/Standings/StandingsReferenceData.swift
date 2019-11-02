//
//  StandingsReferenceData.swift
//  Hockey Info SwiftUI
//
//  Created by Larry Burris on 06/16/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation
import SwiftUI

struct StandingsReferenceData: Codable, Hashable, Identifiable
{
    var id = UUID()
    var standingsCategories: [StandingsCategory]
    
    private enum CodingKeys : String, CodingKey
    {
        case standingsCategories = "teamStatReferences"
    }
}
