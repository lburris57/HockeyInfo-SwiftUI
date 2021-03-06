//
//  MainMenuView.swift
//  HockeyInfoSwiftUI
//
//  This view displays the main menu items in a list format
//
//  Created by Larry Burris on 6/9/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import SwiftUI

struct MainMenuView : View
{
    @EnvironmentObject var settings: UserSettingsViewModel
    @EnvironmentObject var teamInfo: TeamInformationViewModel
    
    var body: some View
    {
        //print("\n\nIn main menu view......\n\n")
        
        return NavigationView
        {
            List
            {
                NavigationLink(destination: SeasonScheduleView())
                {
                    HStack
                    {
                        Image("scheduleCategory2").resizable().frame(width: 20, height: 20).aspectRatio(contentMode: .fit)
                        MainMenuRow(mainMenuItem: MainMenuItem(description: "Season Schedule"))
                    }
                }
                
                NavigationLink(destination: StandingsTabView())
                {
                    HStack
                    {
                        Image("NHL").resizable().frame(width: 25, height: 20).aspectRatio(contentMode: .fit)
                        MainMenuRow(mainMenuItem: MainMenuItem(description: "Standings"))
                    }
                }

                NavigationLink(destination: ScoresView())
                {
                    HStack
                    {
                        Image("scoreCategory").resizable().frame(width: 20, height: 20).aspectRatio(contentMode: .fit)
                        MainMenuRow(mainMenuItem: MainMenuItem(description: "Scores"))
                    }
                }
                
                NavigationLink(destination: TeamListView())
                {
                    HStack
                    {
                        Image("teamInformationCategory").resizable().frame(width: 20, height: 20).aspectRatio(contentMode: .fit)
                        MainMenuRow(mainMenuItem: MainMenuItem(description: "Team Information List"))
                    }
                }

                NavigationLink(destination: SearchPlayerInformationView())
                {
                    HStack
                    {
                        Image("searchPlayersCategory").resizable().frame(width: 20, height: 20).aspectRatio(contentMode: .fit)
                        MainMenuRow(mainMenuItem: MainMenuItem(description: "Search Players"))
                    }
                }
                
                NavigationLink(destination: PlayerLeadersView())
                {
                    HStack
                    {
                        Image("Hockey_IceSkate").resizable().frame(width: 20, height: 20).aspectRatio(contentMode: .fit)
                        MainMenuRow(mainMenuItem: MainMenuItem(description: "Skater Leaders"))
                    }
                }
                
                NavigationLink(destination: GoalieLeadersView())
                {
                    HStack
                    {
                        Image("ice-hockey-helmet-icon").resizable().frame(width: 20, height: 20).aspectRatio(contentMode: .fit)
                        MainMenuRow(mainMenuItem: MainMenuItem(description: "Goalie Leaders"))
                    }
                }
                
                NavigationLink(destination: SettingsView())
                {
                    HStack
                    {
                        Image("settingsCategory").resizable().frame(width: 20, height: 20).aspectRatio(contentMode: .fit)
                        MainMenuRow(mainMenuItem: MainMenuItem(description: "Season Settings"))
                    }
                }
            }.navigationBarTitle(Text("Main Menu"), displayMode: .inline)
        }
    }
}
    

#if DEBUG
struct MainMenuView_Previews : PreviewProvider
{
    static var previews: some View
    {
        MainMenuView().environmentObject(UserSettingsViewModel())
    }
}
#endif
