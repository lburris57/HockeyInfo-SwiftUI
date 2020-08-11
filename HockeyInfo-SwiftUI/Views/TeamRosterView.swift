//
//  TeamRosterView.swift
//  HockeyInfoSwiftUI
//
//  Created by Larry Burris on 6/25/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import SwiftUI

struct TeamRosterView : View
{
    @EnvironmentObject var settings: UserSettingsViewModel
    @EnvironmentObject var teamInfo: TeamInformationViewModel
    
    var teamItem: TeamItem
    
    var body: some View
    {
        VStack
        {
            List
            {
                if let players = teamInfo.teamDictionary[teamItem.teamId]?.players
                {
                    Section(header: Text("Forwards").font(.headline).foregroundColor(.black))
                    {
                        ForEach(players, id:\.self)
                        {
                            player in
                            
                            if player.position == PositionEnum.leftWing.rawValue || player.position == PositionEnum.center.rawValue || player.position == PositionEnum.rightWing.rawValue
                            {
                                NavigationLink(destination: PlayerDetailView(playerDetail: DBManager().retrievePlayerDetail("\(player.firstName) \(player.lastName)")))
                                {
                                    HStack
                                    {
                                        Text("\(player.position)")
                                        Text("\(player.jerseyNumber)")
                                        Text("\(player.firstName) \(player.lastName)")
                                    }
                                }
                            }
                        }
                    }.padding(.top)
                    
                    Section(header: Text("Defensemen").font(.headline).foregroundColor(.black))
                    {
                        ForEach(players, id:\.self)
                        {
                            player in
                            
                            if player.position == PositionEnum.defenseman.rawValue
                            {
                                NavigationLink(destination: PlayerDetailView(playerDetail: DBManager().retrievePlayerDetail("\(player.firstName) \(player.lastName)")))
                                {
                                    HStack
                                    {
                                        Text("\(player.position)")
                                        Text("\(player.jerseyNumber)")
                                        Text("\(player.firstName) \(player.lastName)")
                                    }
                                }
                            }
                        }
                    }
                    
                    Section(header: Text("Goalies").font(.headline).foregroundColor(.black))
                    {
                        ForEach(players, id:\.self)
                        {
                            player in
                            
                            if player.position == PositionEnum.goalie.rawValue
                            {
                                NavigationLink(destination: PlayerDetailView(playerDetail: DBManager().retrievePlayerDetail("\(player.firstName) \(player.lastName)")))
                                {
                                    HStack
                                    {
                                        Text("\(player.position)")
                                        Text("\(player.jerseyNumber)")
                                        Text("\(player.firstName) \(player.lastName)")
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }.navigationBarTitle(Text("Roster Players for \(teamItem.teamName)"), displayMode: .inline)
    }
}

#if DEBUG
struct TeamRosterView_Previews : PreviewProvider
{
    static var previews: some View
    {
        TeamRosterView(teamItem: TeamItem.allTeamItems()[5]).environmentObject(UserSettingsViewModel())
    }
}
#endif
