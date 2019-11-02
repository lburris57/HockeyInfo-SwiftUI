//
//  PlayerInjuriesView.swift
//  HockeyInfoSwiftUI
//
//  Created by Larry Burris on 6/25/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import SwiftUI

struct PlayerInjuriesView : View
{
    @EnvironmentObject var settings: UserSettings
    @ObservedObject var model = PlayerInjuriesViewModel()
    
    var teamItem: TeamItem
    
    var body: some View
    {
        Text("Player Injuries View for \(teamItem.teamName)!")
    }
}

#if DEBUG
struct PlayerInjuriesView_Previews : PreviewProvider
{
    static var previews: some View
    {
        PlayerInjuriesView(teamItem: TeamItem.allTeamItems()[17]).environmentObject(UserSettings())
    }
}
#endif
