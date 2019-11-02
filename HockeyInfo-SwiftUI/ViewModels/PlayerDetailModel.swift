//
//  PlayerDetailModel.swift
//  HockeyInfo-SwiftUI
//
//  Created by Larry Burris on 11/2/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation

class PlayerDetailModel
{
    var id = UUID()
    var playerId: Int = 0
    var firstName: String = Constants.EMPTY_STRING
    var lastName: String = Constants.EMPTY_STRING
    var position: String = Constants.EMPTY_STRING
    var jerseyNumber: String = Constants.EMPTY_STRING
    var height: String = Constants.EMPTY_STRING
    var weight: String = Constants.EMPTY_STRING
    var birthDate: String = Constants.EMPTY_STRING
    var age: String = Constants.EMPTY_STRING
    var birthCity: String = Constants.EMPTY_STRING
    var birthCountry: String = Constants.EMPTY_STRING
    var imageUrl: String = Constants.EMPTY_STRING
    var shoots: String = Constants.EMPTY_STRING
    var teamAbbreviation: String = Constants.EMPTY_STRING
}
