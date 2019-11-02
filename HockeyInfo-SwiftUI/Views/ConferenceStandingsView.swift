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
    @EnvironmentObject var settings: UserSettings
    
    @ObservedObject var model = NHLStandingsViewModel()
    
    var body: some View
    {
        List
        {
            VStack(alignment: .leading)
            {
                Text("Eastern Conference")
                    .fontWeight(.bold)
                    .underline()
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)
                
                ForEach(model.westernConferenceList)
                {
                    teamStandingsData in
                    Text("\(teamStandingsData.teamInformation.city) \(teamStandingsData.teamInformation.name) has \(teamStandingsData.teamStats.standingsInfo.points) points")
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
                
                ForEach(model.westernConferenceList)
                {
                    teamStandingsData in
                    Text("\(teamStandingsData.teamInformation.city) \(teamStandingsData.teamInformation.name) has \(teamStandingsData.teamStats.standingsInfo.points) points")
                        .font(.caption)
                        .fontWeight(.regular)
                        .multilineTextAlignment(.leading)
                        .lineLimit(0)
                        .padding(.horizontal, 5.0)
                }
            }
        }
    }
}

#if DEBUG
struct ConferenceStandingsView_Previews : PreviewProvider
{
    static var previews: some View
    {
        ConferenceStandingsView().environmentObject(UserSettings())
    }
}
#endif
