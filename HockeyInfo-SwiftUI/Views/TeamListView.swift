//
//  TeamListView.swift
//  HockeyInfoSwiftUI
//
//  Created by Larry Burris on 6/25/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import SwiftUI

struct TeamListView : View
{
    @EnvironmentObject var settings: UserSettings
    
    var teamItemList = TeamItem.allTeamItems()
    
    var body: some View
    {
        List(teamItemList)
        {
            teamItem in NavigationLink(destination: TeamInformationView(teamItem: teamItem))
            {
                VStack
                {
                    TeamRowView(teamItem: teamItem)
                }
            }
        }
    }
}

#if DEBUG
struct TeamListView_Previews : PreviewProvider
{
    static var previews: some View
    {
        TeamListView().environmentObject(UserSettings())
    }
}
#endif
