//
//  TeamInformationView.swift
//  HockeyInfoSwiftUI
//
//  Created by Larry Burris on 6/25/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import SwiftUI

struct TeamInformationView : View
{
    @EnvironmentObject var settings: UserSettingsViewModel
    @EnvironmentObject var teamInfo: TeamInformationViewModel
    
    var teamItem: TeamItem
    
    var body: some View
    {
        TabView()
        {
            TeamRosterView(teamItem: teamItem).tabItem
            {
                Image("icons8-queue")
                Text("Roster")
            }
            TeamStatsView(teamItem: teamItem).tabItem
            {
                Image("icons8-pie_chart")
                Text("Stats")
            }
            PlayerInjuriesView(teamItem: teamItem).tabItem
            {
                Image("icons8-broken_bone")
                Text("Injuries")
            }
            GameLogView(teamItem: teamItem).tabItem
            {
                Image("icons8-gameLog")
                Text("Game Log")
            }
            VenueView(venue: TeamManager.getVenueByTeam(teamItem.teamIconName)).tabItem
            {
                Image("icons8-hockey")
                Text("Venue")
            }
        }
    }
}

#if DEBUG
struct TeamInformationView_Previews : PreviewProvider
{
    static var previews: some View
    {
        TeamInformationView(teamItem: TeamItem.allTeamItems()[26]).environmentObject(UserSettingsViewModel())
    }
}
#endif
