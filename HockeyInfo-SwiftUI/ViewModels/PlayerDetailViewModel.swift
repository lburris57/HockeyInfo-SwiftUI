//
//  PlayerDetailViewModel.swift
//  HockeyInfo-SwiftUI
//
//  Created by Larry Burris on 11/2/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation

class PlayerDetailViewModel: ObservableObject
{
    @Published var playerDetail = PlayerDetailModel()
    
    var name: String = Constants.EMPTY_STRING
    
//    init()
//    {
//        fetchPlayerDetail(name)
//    }
    
    public func fetchPlayerDetail(_ name: String)
    {
        self.playerDetail = DBManager().retrievePlayerDetail(name)
    }
}
