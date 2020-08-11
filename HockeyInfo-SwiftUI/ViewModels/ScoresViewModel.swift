//
//  ScoresViewModel.swift
//  HockeyInfo-SwiftUI
//
//  Created by Larry Burris on 11/6/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import SwiftUI

final class ScoresViewModel
{
    @Published var nhlScheduleList = [NHLSchedule]()
    
    func fetchScheduleForDate(date: String)
    {
        let startTime = Date().timeIntervalSince1970
        
        nhlScheduleList = DBManager().retrieveNHLScheduleForDate(date)
        
        print("Total elapsed time to retrieve NHL schedule scores for \(date) is: \((Date().timeIntervalSince1970 - startTime).rounded()) seconds.")
    }
}
