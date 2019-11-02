//
//  CurrentTeamData.swift
//  Hockey Info SwiftUI
//
//  Created by Larry Burris on 06/16/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation
import SwiftUI

struct CurrentTeamData: Codable, Hashable, Identifiable
{
    var id = 0
    var abbreviation = ""
}

private enum CodingKeys : String, CodingKey
{
    case id = "id"
    case abbreviation = "abbreviation"
}
