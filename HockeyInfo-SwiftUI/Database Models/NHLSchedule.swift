//
//  NHLSchedule.swift
//  HockeyInfoSwiftUI
//
//  Created by Larry Burris on 6/16/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation
import RealmSwift

class NHLSchedule: Object
{
    @objc dynamic var id : Int = 0
    @objc dynamic var date : String = Constants.EMPTY_STRING
    @objc dynamic var time : String = Constants.EMPTY_STRING
    @objc dynamic var homeTeam : String = Constants.EMPTY_STRING
    @objc dynamic var awayTeam : String = "No games scheduled"
    @objc dynamic var playedStatus : String = Constants.EMPTY_STRING
    @objc dynamic var homeScoreTotal : Int = 0
    @objc dynamic var awayScoreTotal : Int = 0
    @objc dynamic var numberOfPeriods : Int = 0
    @objc dynamic var homeShotsTotal : Int = 0
    @objc dynamic var awayShotsTotal : Int = 0
    @objc dynamic var scheduleStatus : String = Constants.EMPTY_STRING
    @objc dynamic var currentTimeRemaining : Int = 0
    @objc dynamic var currentPeriod : Int = 0
    @objc dynamic var lastUpdatedOn: String = Constants.EMPTY_STRING
    @objc dynamic var dateCreated: String = Constants.EMPTY_STRING
    @objc dynamic var season: String = Constants.EMPTY_STRING
    @objc dynamic var seasonType = Constants.EMPTY_STRING
    
    var parentTeam = LinkingObjects(fromType: NHLTeam.self, property: "schedules")
    
    override static func primaryKey() -> String?
    {
        return "id"
    }
}
