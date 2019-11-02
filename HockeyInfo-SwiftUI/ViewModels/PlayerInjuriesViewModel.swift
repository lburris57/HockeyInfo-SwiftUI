//
//  PlayerInjuriesViewModel.swift
//  HockeyInfoSwiftUI
//
//  Created by Larry Burris on 6/16/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation
import Combine
import SwiftUI

final class PlayerInjuriesViewModel: ObservableObject
{
    var willChange = PassthroughSubject<PlayerInjuriesViewModel, Never>()
    var playerInjuries = PlayerInjuries()
    {
        willSet
        {
            willChange.send(self)
        }
    }
    
    init()
    {
        fetchPlayerInjuries()
    }
    
    private func fetchPlayerInjuries()
    {
        NetworkManager().retrievePlayerInjuries
        {
            self.playerInjuries = $0
        }
    }
}
