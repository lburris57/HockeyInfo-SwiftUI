//
//  SeasonScheduleViewModel.swift
//  HockeyInfoSwiftUI
//
//  Created by Larry Burris on 6/16/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation
import Combine
import SwiftUI

final class SeasonScheduleViewModel: ObservableObject
{
    @Published var nhlScheduleList = [NHLSchedule]()
    
    init()
    {
        let startTime = Date().timeIntervalSince1970
        
        fetchSeasonSchedule()
        
        print("Total elapsed time to retrieve full season schedule model is: \((Date().timeIntervalSince1970 - startTime).rounded()) seconds.")
    }
    
    private func fetchSeasonSchedule()
    {
        NetworkManager().retrieveFullSeasonSchedule
        {
            self.nhlScheduleList = $0
        }
    }
}
