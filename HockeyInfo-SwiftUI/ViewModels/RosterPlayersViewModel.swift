//
//  RosterPlayersViewModel.swift
//  HockeyInfoSwiftUI
//
//  Created by Larry Burris on 6/16/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation
import Combine
import SwiftUI

final class RosterPlayersViewModel: ObservableObject, Identifiable
{
    var willChange = PassthroughSubject<RosterPlayersViewModel, Never>()
    
    var playerNames = [String]()
    {
        willSet
        {
            willChange.send(self)
        }
    }
    
    var rosterPlayers = RosterPlayers()
    
    init()
    {
        //print("Season setting URL is: \(Constants.SEASON_SETTING_URL)")
        fetchRosterPlayers()
    }
    
    private func fetchRosterPlayers()
    {
        var playerNameArray = [String]()
        
        NetworkManager().retrieveRosters
        {
            for playerInfo in $0.playerInfoList
            {
                playerNameArray.append(playerInfo.player.firstName + " " + playerInfo.player.lastName)
            }
            
            self.rosterPlayers = $0
            
            //  Remove any duplicate names
            self.playerNames = Set(playerNameArray.map { $0 }).sorted()
        }
    }
}
