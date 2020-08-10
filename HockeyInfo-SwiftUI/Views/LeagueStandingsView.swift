//
//  LeagueStandingsView.swift
//  HockeyInfoSwiftUI
//
//  Created by Larry Burris on 6/24/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import SwiftUI

struct LeagueStandingsView : View
{
    @EnvironmentObject var settings: UserSettingsViewModel
    
    @ObservedObject var model = NHLStandingsViewModel()
    
    var body: some View
    {
        List
        {
            VStack(alignment: .leading)
            {
                Text("League Standings")
                    .fontWeight(.bold)
                    .underline()
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)
                
                ForEach(model.leagueList, id: \.self)
                {
                    teamStandings in
                    Text("\(TeamManager.getFullTeamName(teamStandings.abbreviation)) has \(teamStandings.points) points")
                        .font(.caption)
                        .fontWeight(.regular)
                        .multilineTextAlignment(.leading)
                        .lineLimit(0)
                        .padding(.horizontal, 5.0)
                }
            }
        }//.onAppear(perform: model.fetchStandings)
    }
}

#if DEBUG
struct LeagueStandingsView_Previews : PreviewProvider
{
    static var previews: some View
    {
        LeagueStandingsView().environmentObject(UserSettingsViewModel())
    }
}
#endif
