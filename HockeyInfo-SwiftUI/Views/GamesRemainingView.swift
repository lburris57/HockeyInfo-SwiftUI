//
//  GamesRemainingView.swift
//  HockeyInfoSwiftUI
//
//  Created by Larry Burris on 6/25/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import SwiftUI

struct GamesRemainingView : View
{
    var teamItem: TeamItem
    
    var body: some View
    {
        Text("Games Remaining View for \(teamItem.teamName)!").padding(40)
    }
}

#if DEBUG
struct GamesRemainingView_Previews : PreviewProvider
{
    static var previews: some View
    {
        GamesRemainingView(teamItem: TeamItem.allTeamItems()[27])
    }
}
#endif
