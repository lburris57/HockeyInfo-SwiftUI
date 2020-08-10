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
    @Published var playerInjuries = PlayerInjuries()
    
//    init()
//    {
//        fetchPlayerInjuries()
//    }
    
    private func fetchPlayerInjuries()
    {
//        NetworkManager().retrievePlayerInjuries
//        {
//            //self.playerInjuries = $0
//
//        }
        
        print("Ignoring player injuries...")
    }
}
