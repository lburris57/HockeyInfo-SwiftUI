//
//  NHLPlayerInjury.swift
//  HockeyInfoSwiftUI
//
//  Created by Larry Burris on 6/16/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation
import RealmSwift

class NHLPlayerInjury : Object
{
    @objc dynamic var id : Int = 0
    @objc dynamic var teamId : Int = 0
    @objc dynamic var teamAbbreviation : String = Constants.EMPTY_STRING
    @objc dynamic var firstName : String = Constants.EMPTY_STRING
    @objc dynamic var lastName : String = Constants.EMPTY_STRING
    @objc dynamic var position : String = Constants.EMPTY_STRING
    @objc dynamic var jerseyNumber : String = Constants.EMPTY_STRING
    @objc dynamic var injuryDescription : String = Constants.EMPTY_STRING
    @objc dynamic var playingProbablity : String = Constants.EMPTY_STRING
    @objc dynamic var dateCreated: String = Constants.EMPTY_STRING
    @objc dynamic var season: String = Constants.EMPTY_STRING
    @objc dynamic var seasonType = Constants.EMPTY_STRING
    
    var parentPlayer = LinkingObjects(fromType: NHLPlayer.self, property: "playerInjuries")
    var parentTeam = LinkingObjects(fromType: NHLTeam.self, property: "playerInjuries")
    
    override static func primaryKey() -> String?
    {
        return "id"
    }
}
