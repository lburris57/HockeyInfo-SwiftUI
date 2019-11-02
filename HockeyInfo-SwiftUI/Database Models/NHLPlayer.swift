//
//  NHLPlayer.swift
//  HockeyInfoSwiftUI
//
//  Created by Larry Burris on 6/16/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation
import RealmSwift

class NHLPlayer : Object
{
    @objc dynamic var id : Int = 0
    @objc dynamic var teamId : Int = 0
    @objc dynamic var teamAbbreviation : String = Constants.EMPTY_STRING
    @objc dynamic var firstName : String = Constants.EMPTY_STRING
    @objc dynamic var lastName : String = Constants.EMPTY_STRING
    @objc dynamic var position : String = Constants.EMPTY_STRING
    @objc dynamic var jerseyNumber : String = Constants.EMPTY_STRING
    @objc dynamic var height : String = Constants.EMPTY_STRING
    @objc dynamic var weight : String = Constants.EMPTY_STRING
    @objc dynamic var birthDate : String = Constants.EMPTY_STRING
    @objc dynamic var age : String = Constants.EMPTY_STRING
    @objc dynamic var birthCity : String = Constants.EMPTY_STRING
    @objc dynamic var birthCountry : String = Constants.EMPTY_STRING
    @objc dynamic var imageURL : String = Constants.EMPTY_STRING
    @objc dynamic var shoots : String = Constants.EMPTY_STRING
    @objc dynamic var dateCreated: String = Constants.EMPTY_STRING
    @objc dynamic var season: String = Constants.EMPTY_STRING
    @objc dynamic var seasonType = Constants.EMPTY_STRING
    
    var playerStatisticsList = List<PlayerStatistics>()
    var playerInjuries = List<NHLPlayerInjury>()
    
    var parentTeam = LinkingObjects(fromType: NHLTeam.self, property: "players")
    
    override static func primaryKey() -> String?
    {
        return "id"
    }
}
