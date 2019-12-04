//
//  StandingsTabView.swift
//  HockeyInfoSwiftUI
//
//  Created by Larry Burris on 6/24/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import SwiftUI

struct StandingsTabView : View
{
    @EnvironmentObject var settings: UserSettings
    
    @ObservedObject var model = NHLStandingsViewModel()
    
    var body: some View
    {
        TabView()
        {
            DivisionStandingsView(model: model).tabItem
            {
                Image("text-align-left-7")
                Text("Division")
            }
            ConferenceStandingsView().tabItem
            {
                Image("text-align-justify-7")
                Text("Conference")
            }
            LeagueStandingsView().tabItem
            {
                Image("text-align-right-7")
                Text("League")
            }
        }.navigationBarTitle(Text("\(settings.season) Standings"))
    }
}

#if DEBUG
struct StandingsTabView_Previews : PreviewProvider
{
    static var previews: some View
    {
        StandingsTabView().environmentObject(UserSettings())
    }
}
#endif
