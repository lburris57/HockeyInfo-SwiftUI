//
//  GameLogView.swift
//  HockeyInfoSwiftUI
//
//  Created by Larry Burris on 7/19/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import SwiftUI

struct GameLogView : View
{
    @EnvironmentObject var settings: UserSettings
    
    var teamItem: TeamItem
    
    @State var selectedGameType = 0
    @State var gameTypes = ["Remaining Games", "Completed Games"]
    
    var body: some View
    {
        VStack
        {
            Picker(selection: $selectedGameType, label: Text(""))
            {
                ForEach(0 ..< gameTypes.count)
                {
                    Text(self.gameTypes[$0]).tag($0)
                }
            }.pickerStyle(SegmentedPickerStyle())
            
            Spacer()
            
            getSelectedView(selectedGameType)
        }
    }
    
    func getSelectedView(_ selection: Int) -> AnyView
    {
        return selection == 0 ? AnyView(GamesRemainingView(teamItem: self.teamItem)) : AnyView(CompletedGamesView(teamItem: self.teamItem))
    }
}

#if DEBUG
struct GameLogView_Previews : PreviewProvider
{
    static var previews: some View
    {
        GameLogView(teamItem: TeamItem.allTeamItems()[5]).environmentObject(UserSettings())
    }
}
#endif
