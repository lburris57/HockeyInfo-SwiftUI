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
    @Published var playerNames = [String]()
    @Published var players = [NHLPlayer]()
    
    func fetchPlayers()
    {
//        var userDefaultsModel = UserDefaultManager.decodeDataFromUserDefaults(for: UserDefaultsHelper.constructSeasonString())
//
//        if userDefaultsModel.isPlayerTableLoaded
//        {
            print("Fetching the roster players from the database...")
            
            self.players = DBManager().retrieveAllPlayers()
            
            self.loadPlayerNameArray()
//        }
//        else
//        {
//            print("Fetching the roster players from the sports web service using the following URL:\n\(URLHelper().retrieveRosterPlayersURL())")
//
//            NetworkManager().retrieveRosterList
//            {
//                self.players = $0
//
//                self.loadPlayerNameArray()
//
//                userDefaultsModel.isPlayerTableLoaded = true
//
//                UserDefaultManager.encodeDataToUserDefaults(for: UserDefaultsHelper.constructSeasonString(), userDefaultsModel)
//            }
//        }
    }
    
    func loadPlayerNameArray()
    {
        var playerNameArray = [String]()
        
        for player in self.players
        {
            playerNameArray.append(player.firstName + " " + player.lastName)
        }
        
        //  Remove any duplicate names
        self.playerNames = Set(playerNameArray.map { $0 }).sorted()
    }
}
