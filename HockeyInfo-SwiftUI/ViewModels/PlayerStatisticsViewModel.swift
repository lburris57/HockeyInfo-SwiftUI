//
//  PlayerStatisticsViewModel.swift
//  HockeyInfoSwiftUI
//
//  Created by Larry Burris on 6/16/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation
import Combine
import SwiftUI

final class PlayerStatisticsViewModel: ObservableObject
{
    var willChange = PassthroughSubject<PlayerStatisticsViewModel, Never>()
    var playerStats = PlayerStats()
    {
        willSet
        {
            willChange.send(self)
        }
    }
    
    init()
    {
        fetchPlayerStats()
    }
    
    private func fetchPlayerStats()
    {
        NetworkManager().retrievePlayerStats
        {
            self.playerStats = $0
        }
    }
}
