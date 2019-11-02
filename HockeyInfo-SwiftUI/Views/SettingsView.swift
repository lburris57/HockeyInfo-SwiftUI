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
                Section
                {
                    Picker(selection: $selectedSeason, label: Text("Season"))
                    {
                        ForEach(0 ..< seasons.count)
                        {
                            Text(self.seasons[$0]).tag($0)
                        }
                    }
                }
                
                Section
                {
                    Toggle(isOn: $isPlayoffs)
                    {
                        Text("Playoffs")
                    }
                }
                
                Section
                {
                    Button(action:
                    {
                        self.settings.season = self.seasons[self.selectedSeason]
                        self.settings.playoffYear = self.playoffYears[self.selectedSeason]
                        self.settings.seasonType = self.seasonType[self.selectedSeasonType]
                    })
                    {
                        Text("Save settings")
                    }
                }
            }
        }.navigationBarTitle(Text("Settings"), displayMode: .inline)
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


