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
    
    func fetchSeasonSchedule()
    {
        print("Fetching the entire season schedule...")
        
        let userDefaultsModel = UserDefaultManager.decodeDataFromUserDefaults(for: UserDefaultsHelper.constructSeasonString())
        
        let startTime = Date().timeIntervalSince1970
        
        nhlScheduleList = DBManager().retrieveFullSeasonSchedule()
        
        print("\(userDefaultsModel)")
        
        print("Total elapsed time to retrieve full season schedule model is: \((Date().timeIntervalSince1970 - startTime).rounded()) seconds.")
    }
}
