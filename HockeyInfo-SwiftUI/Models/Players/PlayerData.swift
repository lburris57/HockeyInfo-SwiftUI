//
//  PlayerData.swift
//  Hockey Info SwiftUI
//
//  Created by Larry Burris on 06/16/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation
import SwiftUI

struct PlayerData: Codable, Hashable, Identifiable
{
    var id = 0
    var firstName: String
    var lastName: String
    var position: String?
    var jerseyNumber: Int?
    var currentRosterStatus: String?
    var height: String?
    var weight: Int?
    var birthDate: String?
    var age: Int?
    var birthCity: String?
    var birthCountry: String?
    var rookie: Bool?
    var officialImageSource: URL?
    var currentInjuryInfo: CurrentInjuryData?
    var handednessInfo: HandednessData?
    
    private enum CodingKeys : String, CodingKey
    {
        case id = "id"
        case firstName = "firstName"
        case lastName = "lastName"
        case position = "primaryPosition"
        case jerseyNumber = "jerseyNumber"
        case currentRosterStatus = "currentRosterStatus"
        case height = "height"
        case weight = "weight"
        case birthDate = "birthDate"
        case age = "age"
        case birthCity = "birthCity"
        case birthCountry = "birthCountry"
        case rookie = "rookie"
        case officialImageSource = "officialImageSrc"
        case currentInjuryInfo = "currentInjury"
        case handednessInfo = "handedness"
    }
}
