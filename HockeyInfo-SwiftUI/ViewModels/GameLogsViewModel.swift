//
//  GameLogsViewModel.swift
//  HockeyInfoSwiftUI
//
//  Created by Larry Burris on 6/16/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation
import Combine
import SwiftUI

final class GameLogsViewModel: ObservableObject
{
    @Published var gameLog = GameLog()
    
    init()
    {
        fetchGameLog()
    }
    
    private func fetchGameLog()
    {
        NetworkManager().retrieveGameLog
        {
            self.gameLog = $0
        }
    }
}
