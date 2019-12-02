//
//  UserDefaultTableModel.swift
//  HockeyInfo-SwiftUI
//
//  Created by Larry Burris on 12/1/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation

struct UserDefaultTableInformationModel: Codable
{
    var season: String = ""
    var isPlayoffs: Bool = false
    var isSeasonScheduleTableLoaded = false
    var isTeamTableLoaded = false
    var isPlayerTableLoaded = false
}
