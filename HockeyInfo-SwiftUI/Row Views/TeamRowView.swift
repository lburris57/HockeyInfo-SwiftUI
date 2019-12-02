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
    var division = ""
}

extension TeamItem
{
    static func allTeamItems() -> [TeamItem]
    {
        return [
            TeamItem(teamIconName: "ANA", teamName: "Anaheim Ducks", division: "Pacific"),
            TeamItem(teamIconName: "ARI", teamName: "Arizona Coytotes", division: "Pacific"),
            TeamItem(teamIconName: "BOS", teamName: "Boston Bruins", division: "Atlantic"),
            TeamItem(teamIconName: "BUF", teamName: "Buffalo Sabres", division: "Atlantic"),
            TeamItem(teamIconName: "CGY", teamName: "Calgary Flames", division: "Pacific"),
            TeamItem(teamIconName: "CAR", teamName: "Carolina Hurricanes", division: "Metropolitan"),
            TeamItem(teamIconName: "CHI", teamName: "Chicago Blackhawks", division: "Central"),
            TeamItem(teamIconName: "COL", teamName: "Colorado Avalanche", division: "Central"),
            TeamItem(teamIconName: "CBJ", teamName: "Columbus Blue Jackets", division: "Metropolitan"),
            TeamItem(teamIconName: "DAL", teamName: "Dallas Stars", division: "Central"),
            TeamItem(teamIconName: "DET", teamName: "Detroit Red Wings", division: "Atlantic"),
            TeamItem(teamIconName: "EDM", teamName: "Edmonton Oilers", division: "Pacific"),
            TeamItem(teamIconName: "FLO", teamName: "Florida Panthers", division: "Atlantic"),
            TeamItem(teamIconName: "LAK", teamName: "Los Angeles Kings", division: "Pacific"),
            TeamItem(teamIconName: "MIN", teamName: "Minnesota Wild", division: "Central"),
            TeamItem(teamIconName: "MTL", teamName: "Montreal Canadiens", division: "Atlantic"),
            TeamItem(teamIconName: "NSH", teamName: "Nashville Predators", division: "Central"),
            TeamItem(teamIconName: "NJD", teamName: "New Jersey Devils", division: "Metropolitan"),
            TeamItem(teamIconName: "NYI", teamName: "New York Islanders", division: "Metropolitan"),
            TeamItem(teamIconName: "NYR", teamName: "New York Rangers", division: "Metropolitan"),
            TeamItem(teamIconName: "OTT", teamName: "Ottawa Senators", division: "Atlantic"),
            TeamItem(teamIconName: "PHI", teamName: "Philadelphia Flyers", division: "Metropolitan"),
            TeamItem(teamIconName: "PIT", teamName: "Pittsburgh Penguins", division: "Metropolitan"),
            TeamItem(teamIconName: "SJS", teamName: "San Jose Sharks", division: "Pacific"),
            TeamItem(teamIconName: "STL", teamName: "St. Louis Blues", division: "Central"),
            TeamItem(teamIconName: "TBL", teamName: "Tampa Bay Lightning", division: "Atlantic"),
            TeamItem(teamIconName: "TOR", teamName: "Toronto Maple Leafs", division: "Atlantic"),
            TeamItem(teamIconName: "VAN", teamName: "Vancouver Canucks", division: "Pacific"),
            TeamItem(teamIconName: "VGK", teamName: "Vegas Golden Knights", division: "Pacific"),
            TeamItem(teamIconName: "WSH", teamName: "Washington Capitals", division: "Metropolitan"),
            TeamItem(teamIconName: "WPJ", teamName: "Winnipeg Jets", division: "Central")
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
