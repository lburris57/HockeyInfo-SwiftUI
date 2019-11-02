//
//  TeamRowView.swift
//  HockeyInfoSwiftUI
//
//  Created by Larry Burris on 6/25/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import SwiftUI

struct TeamRowView : View
{
    var teamItem: TeamItem
    
    var body: some View
    {
        HStack()
        {
            Image(teamItem.teamIconName).resizable().frame(width: 30, height: 20).aspectRatio(contentMode: .fit).padding(.leading)
            Text(teamItem.teamName)
            Spacer()
        }
    }
}

struct TeamItem : Identifiable
{
    var id = UUID()
    var teamIconName = ""
    var teamName = ""
}

extension TeamItem
{
    static func allTeamItems() -> [TeamItem]
    {
        return [
            TeamItem(teamIconName: "ANA", teamName: "Anaheim Ducks"),
            TeamItem(teamIconName: "ARI", teamName: "Arizona Coytotes"),
            TeamItem(teamIconName: "BOS", teamName: "Boston Bruins"),
            TeamItem(teamIconName: "BUF", teamName: "Buffalo Sabres"),
            TeamItem(teamIconName: "CGY", teamName: "Calgary Flames"),
            TeamItem(teamIconName: "CAR", teamName: "Carolina Hurricanes"),
            TeamItem(teamIconName: "CHI", teamName: "Chicago Blackhawks"),
            TeamItem(teamIconName: "COL", teamName: "Colorado Avalanche"),
            TeamItem(teamIconName: "CBJ", teamName: "Columbus Blue Jackets"),
            TeamItem(teamIconName: "DAL", teamName: "Dallas Stars"),
            TeamItem(teamIconName: "DET", teamName: "Detroit Red Wings"),
            TeamItem(teamIconName: "EDM", teamName: "Edmonton Oilers"),
            TeamItem(teamIconName: "FLO", teamName: "Florida Panthers"),
            TeamItem(teamIconName: "LAK", teamName: "Los Angeles Kings"),
            TeamItem(teamIconName: "MIN", teamName: "Minnesota Wild"),
            TeamItem(teamIconName: "MTL", teamName: "Montreal Canadiens"),
            TeamItem(teamIconName: "NSH", teamName: "Nashville Predators"),
            TeamItem(teamIconName: "NJD", teamName: "New Jersey Devils"),
            TeamItem(teamIconName: "NYI", teamName: "New York Islanders"),
            TeamItem(teamIconName: "NYR", teamName: "New York Rangers"),
            TeamItem(teamIconName: "OTT", teamName: "Ottawa Senators"),
            TeamItem(teamIconName: "PHI", teamName: "Philadelphia Flyers"),
            TeamItem(teamIconName: "PIT", teamName: "Pittsburgh Penguins"),
            TeamItem(teamIconName: "SJS", teamName: "San Jose Sharks"),
            TeamItem(teamIconName: "STL", teamName: "St. Louis Blues"),
            TeamItem(teamIconName: "TBL", teamName: "Tampa Bay Lightning"),
            TeamItem(teamIconName: "TOR", teamName: "Toronto Maple Leafs"),
            TeamItem(teamIconName: "VAN", teamName: "Vancouver Canucks"),
            TeamItem(teamIconName: "VGK", teamName: "Vegas Golden Knights"),
            TeamItem(teamIconName: "WSH", teamName: "Washington Capitals"),
            TeamItem(teamIconName: "WPJ", teamName: "Winnipeg Jets")
        ]
    }
}


#if DEBUG
struct TeamRowView_Previews : PreviewProvider
{
    static var previews: some View
    {
        TeamRowView(teamItem: TeamItem(teamIconName: "BUF", teamName: "Buffalo Sabres"))
    }
}
#endif
