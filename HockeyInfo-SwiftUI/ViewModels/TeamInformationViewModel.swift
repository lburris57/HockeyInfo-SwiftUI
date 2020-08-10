//
//  TeamInformationViewModel.swift
//  HockeyInfo-SwiftUI
//
//  Created by Larry Burris on 12/4/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation
import Combine
import SwiftUI

final class TeamInformationViewModel: ObservableObject
{
    @Published var team = NHLTeam()

//    init()
//    {
//        fetchTeam()
//    }

    public func fetchTeam()
    {
//        NetworkManager().retrieveTeam
//        {
//            self.team = $0
//        }
    }
}
