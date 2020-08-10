//
//  PlayerLeadersViewModel.swift
//  HockeyInfoSwiftUI
//
//  Created by Larry Burris on 7/16/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Combine
import SwiftUI

final class PlayerLeadersViewModel: ObservableObject
{
    @Published var pointsLeaderList = [PlayerLeaderModel]()
    @Published var goalsLeaderList = [PlayerLeaderModel]()
    @Published var assistsLeaderList = [PlayerLeaderModel]()
    @Published var plusMinusLeaderList = [PlayerLeaderModel]()
    @Published var winsLeaderList = [PlayerLeaderModel]()
    @Published var shutoutsLeaderList = [PlayerLeaderModel]()
    @Published var goalsAgainstAverageLeaderList = [PlayerLeaderModel]()
    @Published var savePercentageLeaderList = [PlayerLeaderModel]()
    
//    init()
//    {
//        fetchLeaderInformation()
//    }
    
    private func fetchLeaderInformation()
    {
        pointsLeaderList = DBManager().retrieveCategoryLeaders("points")
        goalsLeaderList = DBManager().retrieveCategoryLeaders("goals")
        assistsLeaderList = DBManager().retrieveCategoryLeaders("assists")
        plusMinusLeaderList = DBManager().retrieveCategoryLeaders("plusMinus")
        winsLeaderList = DBManager().retrieveCategoryLeaders("wins")
        shutoutsLeaderList = DBManager().retrieveGoalieCategoryLeaders("shutouts", false)
        goalsAgainstAverageLeaderList = DBManager().retrieveGoalieCategoryLeaders("goalsAgainstAverage", true)
        savePercentageLeaderList = DBManager().retrieveGoalieCategoryLeaders("savePercentage", false)
    }
}
