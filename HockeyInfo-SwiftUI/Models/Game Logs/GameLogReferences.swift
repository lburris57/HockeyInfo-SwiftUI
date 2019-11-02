//
//  GameLogReferences.swift
//  Hockey Info SwiftUI
//
//  Created by Larry Burris on 06/16/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation
import SwiftUI

struct GameLogReferences: Codable, Hashable, Identifiable
{
    var id = UUID()
    var gameReferences: [GameReference]
    
    private enum CodingKeys : String, CodingKey
    {
        case gameReferences = "gameReferences"
    }
}
