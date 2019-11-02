//
//  CompletedGamesView.swift
//  HockeyInfoSwiftUI
//
//  Created by Larry Burris on 6/25/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import SwiftUI

struct CompletedGamesView : View
{
    var teamItem: TeamItem
    
    var body: some View
    {
        Text("Completed Games View for \(teamItem.teamName)!").padding(40)
    }
}

#if DEBUG
struct CompletedGamesView_Previews : PreviewProvider
{
    static var previews: some View
    {
        CompletedGamesView(teamItem: TeamItem.allTeamItems()[22])
    }
}
#endif
