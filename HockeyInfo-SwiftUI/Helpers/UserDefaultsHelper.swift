//
//  UserDefaultsHelper.swift
//  HockeyInfoSwiftUI
//
//  Created by Larry Burris on 10/20/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation

struct UserDefaultsHelper
{
    let userDefaults = UserDefaults.standard
    
    static func loadUserDefaultsTableInformationData()
    {
        let seasonKeys = ["tableModel2008-2009", "tableModel2009-2010", "tableModel2010-2011", "tableModel2011-2012", "tableModel2012-2013", "tableModel2013-2014", "tableModel2014-2015", "tableModel2015-2016", "tableModel2016-2017", "tableModel2017-2018", "tableModel2018-2019", "tableModel2019-2020", "tableModel2021-2022", "tableModel2022-2023", "tableModel2023-2024", "tableModel2024-2025", "tableModel2025-2026", "tableModel2026-2027", "tableModel2027-2028", "tableModel2028-2029", "tableModel2029-2030"]
        
        let playoffSeasonKeys = ["tableModel2008-2009P", "tableModel2009-2010P", "tableModel2010-2011P", "tableModel2011-2012P", "tableModel2012-2013P", "tableModel2013-2014P", "tableModel2014-2015P", "tableModel2015-2016P", "tableModel2016-2017P", "tableModel2017-2018P", "tableModel2018-2019P", "tableModel2019-2020P", "tableModel2021-2022P", "tableModel2022-2023P", "tableModel2023-2024P", "tableModel2024-2025P", "tableModel2025-2026P", "tableModel2026-2027P", "tableModel2027-2028P", "tableModel2028-2029P", "tableModel2029-2030P"]
        
        let encoder = JSONEncoder()
        
        for season in seasonKeys
        {
            var userDefaultTableInformationModel = UserDefaultTableInformationModel()
            
            userDefaultTableInformationModel.season = season.replacingOccurrences(of: "tableModel", with: "")
            
            if let encoded = try? encoder.encode(userDefaultTableInformationModel)
            {
                UserDefaults.standard.set(encoded, forKey: season)
            }
        }
        
        for season in playoffSeasonKeys
        {
            var userDefaultTableInformationModel = UserDefaultTableInformationModel()
            
            userDefaultTableInformationModel.season = season.replacingOccurrences(of: "tableModel", with: "")
            userDefaultTableInformationModel.isPlayoffs = true
            
            if let encoded = try? encoder.encode(userDefaultTableInformationModel)
            {
                UserDefaults.standard.set(encoded, forKey: season)
            }
        }
    }
    
    static func retrieveUserDefaultsTableInformationData(for season: String) -> UserDefaultTableInformationModel?
    {
        if let savedSeasonDefaultData = UserDefaults.standard.object(forKey: season) as? Data
        {
            let decoder = JSONDecoder()
            
            if let loadedSeasonDefaultData = try? decoder.decode(UserDefaultTableInformationModel.self, from: savedSeasonDefaultData)
            {
                return loadedSeasonDefaultData
            }
        }
        
        return nil
    }
}
