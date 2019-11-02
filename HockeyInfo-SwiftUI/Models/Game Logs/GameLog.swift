//
//  GameLog.swift
//  Hockey Info SwiftUI
//
//  Created by Larry Burris on 06/16/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation
import SwiftUI

struct GameLog: Codable, Hashable, Identifiable
{
    var id = UUID()
    var lastUpdatedOn = ""
    var gameLogDataList = [GameLogData]()
    
    private enum CodingKeys : String, CodingKey
    {
        case lastUpdatedOn = "lastUpdatedOn"
        case gameLogDataList = "gamelogs"
    }
}
