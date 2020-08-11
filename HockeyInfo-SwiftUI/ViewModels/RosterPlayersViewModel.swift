//
//  RosterPlayersViewModel.swift
//  HockeyInfoSwiftUI
//
//  Created by Larry Burris on 6/16/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Combine
import SwiftUI

final class RosterPlayersViewModel: ObservableObject, Identifiable
{
    @Published var playerNames = [String]()
    @Published var players = [NHLPlayer]()
    
    func fetchPlayers()
    {
        print("Fetching the roster players from the database...")
            
        self.players = DBManager().retrieveAllPlayers()
        
        self.loadPlayerNameArray()
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
