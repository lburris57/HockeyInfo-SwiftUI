//
//  StandingsData.swift
//  Hockey Info SwiftUI
//
//  Created by Larry Burris on 06/16/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation
import SwiftUI

struct StandingsData: Codable, Hashable, Identifiable
{
    var id = UUID()
    var wins = 0
    var losses: Int = 0
    var overtimeWins: Int = 0
    var overtimeLosses: Int = 0
    var points: Int = 0
    
    private enum CodingKeys : String, CodingKey
    {
        case wins = "wins"
        case losses = "losses"
        case overtimeWins = "overtimeWins"
        case overtimeLosses = "overtimeLosses"
        case points = "points"
    }
    
    func winsString() -> String
    {
        return wins < 10 ? " \(wins)" : "\(wins)"
    }
    
    func lossesString() -> String
    {
        return losses < 10 ? " \(losses)" : "\(losses)"
    }
    
    func overtimeLossesString() -> String
    {
        return overtimeLosses < 10 ? " \(overtimeLosses)" : "\(overtimeLosses)"
    }
    
    func pointsString() -> String
    {
        if points < 10
        {
            return "  \(points)"
        }
        else if points > 10 && points < 100
        {
            return " \(points)"
        }
        else
        {
            return "\(points)"
        }
    }
}
