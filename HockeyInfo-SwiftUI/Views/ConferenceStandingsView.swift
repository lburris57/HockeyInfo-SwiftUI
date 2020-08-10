//
//  ConferenceStandingsView.swift
//  HockeyInfoSwiftUI
//
//  Created by Larry Burris on 6/24/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import SwiftUI

struct ConferenceStandingsView : View
{
    @EnvironmentObject var settings: UserSettingsViewModel
    
    @ObservedObject var model = NHLStandingsViewModel()
    
    var body: some View
    {
        print("Size of team standings list is: \(model.teamStandingsList.count)")
        print("Size of Eastern Conference list is: \(model.easternConferenceList.count)")
        
        return List
        {
            VStack(alignment: .leading)
            {
                Text("Eastern Conference")
                    .fontWeight(.bold)
                    .underline()
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)
                
                ForEach(model.easternConferenceList, id: \.self)
                {
                    teamStandings in
                    Text("\(TeamManager.getFullTeamName(teamStandings.abbreviation)) has \(teamStandings.points) points")
                        .font(.caption)
                        .fontWeight(.regular)
                        .multilineTextAlignment(.leading)
                        .lineLimit(0)
                        .padding(.horizontal, 5.0)
                }
                
                Text("Western Conference")
                    .fontWeight(.bold)
                    .underline()
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)
                
                ForEach(model.westernConferenceList, id: \.self)
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
        }.onAppear(perform: model.fetchStandings)
    }
}

#if DEBUG
struct ConferenceStandingsView_Previews : PreviewProvider
{
    static var previews: some View
    {
        ConferenceStandingsView().environmentObject(UserSettingsViewModel())
    }
}
#endif
