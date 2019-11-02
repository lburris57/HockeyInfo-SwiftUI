//
//  DivisionStandingsView.swift
//  HockeyInfoSwiftUI
//
//  Created by Larry Burris on 6/24/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import SwiftUI

struct DivisionStandingsView : View
{
    @EnvironmentObject var settings: UserSettings
    
    @ObservedObject var model = NHLStandingsViewModel()
    
    var body: some View
    {
//        List
//        {
//            VStack(alignment: .leading)
//            {
//
//                Text("Atlantic Division")
//                    .fontWeight(.bold)
//                    .underline()
//                    .multilineTextAlignment(.leading)
//                    .padding(.horizontal)
//
//                ForEach(model.atlanticDivisionList)
//                {
//                    teamStandingsData in
//                    Text("\(teamStandingsData.teamInformation.city) \(teamStandingsData.teamInformation.name) has \(teamStandingsData.teamStats.standingsInfo.points) points")
//                        .font(.caption)
//                        .fontWeight(.regular)
//                        .multilineTextAlignment(.leading)
//                        .lineLimit(0)
//                        .padding(.horizontal, 5.0)
//                }
//
//                Text("Metropolitan Division")
//                    .fontWeight(.bold)
//                    .underline()
//                    .multilineTextAlignment(.leading)
//                    .padding(.horizontal)
//
//                ForEach(model.metroDivisionList)
//                {
//                    teamStandingsData in
//                    Text("\(teamStandingsData.teamInformation.city) \(teamStandingsData.teamInformation.name) has \(teamStandingsData.teamStats.standingsInfo.points) points")
//                        .font(.caption)
//                        .fontWeight(.regular)
//                        .multilineTextAlignment(.leading)
//                        .lineLimit(0)
//                        .padding(.horizontal, 5.0)
//                }
//
//                Text("Central Division")
//                    .fontWeight(.bold)
//                    .underline()
//                    .multilineTextAlignment(.leading)
//                    .padding(.horizontal)
//
//                ForEach(model.centralDivisionList)
//                {
//                    teamStandingsData in
//                    Text("\(teamStandingsData.teamInformation.city) \(teamStandingsData.teamInformation.name) has \(teamStandingsData.teamStats.standingsInfo.points) points")
//                        .font(.caption)
//                        .fontWeight(.regular)
//                        .multilineTextAlignment(.leading)
//                        .lineLimit(0)
//                        .padding(.horizontal, 5.0)
//                }
//
//                Text("Pacific Division")
//                    .fontWeight(.bold)
//                    .underline()
//                    .multilineTextAlignment(.leading)
//                    .padding(.horizontal)
//
//                ForEach(model.pacificDivisionList)
//                {
//                    teamStandingsData in
//                    Text("\(teamStandingsData.teamInformation.city) \(teamStandingsData.teamInformation.name) has \(teamStandingsData.teamStats.standingsInfo.points) points")
//                        .font(.caption)
//                        .fontWeight(.regular)
//                        .multilineTextAlignment(.leading)
//                        .lineLimit(0)
//                        .padding(.horizontal, 5.0)
//                }
//            }
//            .padding(.leading)
//        }
        List
        {
            VStack
            {
                StandingsHeaderRow(headerName: "Atlantic Division")
                
                ForEach(model.atlanticDivisionList)
                {
                    teamStandingsData in
                    StandingsRow(teamStandingsData: teamStandingsData)
                }
            }
        }
    }
}

#if DEBUG
struct DivisionStandingsView_Previews : PreviewProvider
{
    static var previews: some View
    {
        DivisionStandingsView().environmentObject(UserSettings())
    }
}
#endif
