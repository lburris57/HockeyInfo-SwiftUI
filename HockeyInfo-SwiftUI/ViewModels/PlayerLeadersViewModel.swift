//
//  PlayerLeadersViewModel.swift
//  HockeyInfoSwiftUI
//
//  Created by Larry Burris on 7/16/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation
import Combine
import SwiftUI

final class PlayerLeadersViewModel: ObservableObject
{
    var willChange = PassthroughSubject<PlayerLeadersViewModel, Never>()
    
    var pointsLeaderList = [PlayerLeaderModel]()
    {
        willSet
        {
            willChange.send(self)
        }
    }
    
    var goalsLeaderList = [PlayerLeaderModel]()
    {
        willSet
        {
            willChange.send(self)
        }
    }
    
    var assistsLeaderList = [PlayerLeaderModel]()
    {
        willSet
        {
            willChange.send(self)
        }
    }
    
    var plusMinusLeaderList = [PlayerLeaderModel]()
    {
        willSet
        {
            willChange.send(self)
        }
    }
    
    var winsLeaderList = [PlayerLeaderModel]()
    {
        willSet
        {
            willChange.send(self)
        }
    }
    
    var shutoutsLeaderList = [PlayerLeaderModel]()
    {
        willSet
        {
            willChange.send(self)
        }
    }
    
    var goalsAgainstAverageLeaderList = [PlayerLeaderModel]()
    {
        willSet
        {
            willChange.send(self)
        }
    }
    
    var savePercentageLeaderList = [PlayerLeaderModel]()
    {
        willSet
        {
            willChange.send(self)
        }
    }
    
    init()
    {
        fetchLeaderInformation()
    }
    
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
