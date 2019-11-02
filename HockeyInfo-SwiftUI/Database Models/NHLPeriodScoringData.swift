//
//  NHLPeriodScoringData.swift
//  HockeyInfoSwiftUI
//
//  Created by Larry Burris on 6/16/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation
import RealmSwift

class NHLPeriodScoringData: Object
{
    @objc dynamic var id : Int = 0
    @objc dynamic var gameId : Int = 0
    @objc dynamic var periodNumber : Int = 0
    @objc dynamic var teamAbbreviation : String = Constants.EMPTY_STRING
    @objc dynamic var periodSecondsElapsed: Int = 0
    @objc dynamic var playDescription: String = Constants.EMPTY_STRING
    @objc dynamic var dateCreated: String = Constants.EMPTY_STRING
    @objc dynamic var season: String = Constants.EMPTY_STRING
    @objc dynamic var seasonType = Constants.EMPTY_STRING
    
    var parentTeam = LinkingObjects(fromType: NHLScoringSummary.self, property: "periodScoringList")
    
    override static func primaryKey() -> String?
    {
        return "id"
    }
}
