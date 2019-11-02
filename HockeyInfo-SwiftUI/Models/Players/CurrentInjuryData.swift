//
//  CurrentInjuryData.swift
//  Hockey Info SwiftUI
//
//  Created by Larry Burris on 06/16/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation
import SwiftUI

struct CurrentInjuryData: Codable, Hashable, Identifiable
{
    var id = UUID()
    var description = ""
    var playingProbability = ""
    
    private enum CodingKeys : String, CodingKey
    {
        case description = "description"
        case playingProbability = "playingProbability"
    }
}
