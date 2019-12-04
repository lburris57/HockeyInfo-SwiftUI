//
//  SettingsView.swift
//  HockeyInfoSwiftUI
//
//  Created by Larry Burris on 7/9/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import SwiftUI

struct SettingsView : View
{
    let currentSeason = TimeAndDateUtils.getCurrentSeason()
    
    var seasons = ["2007-2008", "2008-2009", "2009-2010", "2010-2011", "2011-2012", "2012-2013", "2013-2014", "2014-2015", "2015-2016", "2016-2017", "2017-2018", "2018-2019", "2019-2020"]
    var playoffYears = ["2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015", "2016", "2017", "2018", "2019", "2020"]
    
    @EnvironmentObject var settings: UserSettings
    
    @State private var selectedSeason = 12
    @State private var selectedSeasonType = 0
    @State private var seasonType = ["Regular Season", "Playoffs"]
    @State private var isPlayoffs = false

    var body: some View
    {
        NavigationView
        {
            Form
            {
                Section(header: (Text("Please select a season:")))
                {
                    Picker(selection: $selectedSeason, label: Text("Season"))
                    {
                        ForEach(0 ..< seasons.count)
                        {
                            Text(self.seasons[$0]).tag($0)
                        }
                    }
                }
                
                Section(header: Text("Please select whether to view playoff information:"))
                {
                    Toggle(isOn: $isPlayoffs)
                    {
                        Text("Playoffs")
                    }
                }
                
                Section(header: Text("NOTE:  Invalid settings will not be saved."))
                {
                    Button(action:
                    {
                        self.settings.season = self.seasons[self.selectedSeason]
                        self.settings.playoffYear = self.playoffYears[self.selectedSeason]
                        self.settings.seasonType = self.seasonType[self.selectedSeasonType]
                        self.settings.isPlayoffs = self.isPlayoffs
                    })
                    {
                        Text("Save settings")
                    }.disabled(!TimeAndDateUtils.isValidSetting(self.seasons[self.selectedSeason], isPlayoffs))
                }
            }.navigationBarTitle(Text("Season Settings"), displayMode: .inline)
            
            Spacer()
        }
    }
}

#if DEBUG
struct SettingsView_Previews : PreviewProvider
{
    static var previews: some View
    {
        SettingsView().environmentObject(UserSettings())
    }
}
#endif


