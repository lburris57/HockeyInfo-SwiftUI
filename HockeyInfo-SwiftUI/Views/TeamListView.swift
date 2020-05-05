//
//  TeamListView.swift
//  HockeyInfoSwiftUI
//
//  Created by Larry Burris on 6/25/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import SwiftUI

struct CustomHeader: View
{
    let name: String
    let color: Color

    var body: some View
    {
        VStack
        {
            Spacer()
            
            HStack
            {
                Text(name)
                Spacer()
            }
            
            Spacer()
        }.background(color).edgesIgnoringSafeArea(.all)
    }
}

struct TeamListView : View
{
    @EnvironmentObject var settings: UserSettings
    
    var atlanticDivisionTeamItems = TeamItem.atlanticDivisionTeamItems()
    var metropolitanDivisionTeamItems = TeamItem.metropolitanDivisionTeamItems()
    var centralDivisionTeamItems = TeamItem.centralDivisionTeamItems()
    var pacificDivisionTeamItems = TeamItem.pacificDivisionTeamItems()
    
    var body: some View
    {
        VStack
        {
            List()
            {
                Section(header: Text("Atlantic Division").font(.headline).foregroundColor(.black))
                {
                    ForEach(atlanticDivisionTeamItems)
                    {
                        teamItem in NavigationLink(destination: TeamInformationView(teamItem: teamItem))
                        {
                            TeamRowView(teamItem: teamItem)
                        }
                    }
                }
                
                Section(header: Text("Metropolitan Division").font(.headline).foregroundColor(.black))
                {
                    ForEach(metropolitanDivisionTeamItems)
                    {
                        teamItem in NavigationLink(destination: TeamInformationView(teamItem: teamItem))
                        {
                            TeamRowView(teamItem: teamItem)
                        }
                    }
                }
                
                Section(header: Text("Central Division").font(.headline).foregroundColor(.black))
                {
                    ForEach(centralDivisionTeamItems)
                    {
                        teamItem in NavigationLink(destination: TeamInformationView(teamItem: teamItem))
                        {
                            TeamRowView(teamItem: teamItem)
                        }
                    }
                }
                
                Section(header: Text("Pacific Division").font(.headline).foregroundColor(.black))
                {
                    ForEach(pacificDivisionTeamItems)
                    {
                        teamItem in NavigationLink(destination: TeamInformationView(teamItem: teamItem))
                        {
                            TeamRowView(teamItem: teamItem)
                        }
                    }
                }
            }.navigationBarTitle(Text("Team Information List"), displayMode: .inline).listStyle(GroupedListStyle())
        }
    }
}

#if DEBUG
struct TeamListView_Previews : PreviewProvider
{
    static var previews: some View
    {
        TeamListView().environmentObject(UserSettings())
    }
}
#endif
