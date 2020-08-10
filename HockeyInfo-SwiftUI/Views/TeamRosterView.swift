//
//  TeamRosterView.swift
//  HockeyInfoSwiftUI
//
//  Created by Larry Burris on 6/25/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import SwiftUI

struct TeamRosterView : View
{
    @EnvironmentObject var settings: UserSettingsViewModel
    
    var teamItem: TeamItem
    
    var body: some View
    {
        Text("Team Roster View for \(teamItem.teamName)!")
    }
}

#if DEBUG
struct TeamRosterView_Previews : PreviewProvider
{
    static var previews: some View
    {
        TeamRosterView(teamItem: TeamItem.allTeamItems()[5]).environmentObject(UserSettingsViewModel())
    }
}
#endif
