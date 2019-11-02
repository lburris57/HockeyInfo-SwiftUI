//
//  StandingsRow.swift
//  HockeyInfoSwiftUI
//
//  Created by Larry Burris on 7/19/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import SwiftUI

struct StandingsRow : View
{
    var teamStandingsData: TeamStandingsData
    
    var body: some View
    {
        Text("\(teamStandingsData.teamInformation.city)            \(teamStandingsData.teamStats.gamesPlayed)        \(teamStandingsData.teamStats.standingsInfo.wins)       \(teamStandingsData.teamStats.standingsInfo.losses)          \(teamStandingsData.teamStats.standingsInfo.overtimeLosses)           \(teamStandingsData.teamStats.standingsInfo.points)")
            .font(.custom("Monospaced", size: 15)).multilineTextAlignment(.leading).padding(.top)
    }
}

//#if DEBUG
//struct StandingsRow_Previews : PreviewProvider
//{
//    static var previews: some View
//    {
//        StandingsRow()
//    }
//}
//#endif
