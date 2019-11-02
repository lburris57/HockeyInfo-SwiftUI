//
//  PlayerLeadersView.swift
//  HockeyInfoSwiftUI
//
//  Created by Larry Burris on 7/16/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import SwiftUI

struct PlayerLeadersView : View
{
    @ObservedObject var model = PlayerLeadersViewModel()
    
    var body: some View
    {
        List
        {
            VStack
            {
                PlayerLeaderHeaderView(headerTitle: "Points", headerAbbreviation: "PTS")
                
                List(model.pointsLeaderList)
                {
                    playerLeaderModel in
//                    HStack
//                    {
                        PlayerLeaderDataView(playerLeaderModel: playerLeaderModel)
//                        Text("\(playerLeaderModel.points)")
//                            .font(.caption)
//                            .fontWeight(.regular)
//                            .padding(5).padding(.trailing)
//                    }
                }

                PlayerLeaderHeaderView(headerTitle: "Goals", headerAbbreviation: "G")

                List(model.goalsLeaderList)
                {
                    playerLeaderModel in
//                    HStack
//                    {
                        PlayerLeaderDataView(playerLeaderModel: playerLeaderModel)
//                        Text("\(playerLeaderModel.goals)")
//                            .font(.caption)
//                            .fontWeight(.regular)
//                            .padding(5).padding(.trailing)
//                    }
                }
                
                PlayerLeaderHeaderView(headerTitle: "Assists", headerAbbreviation: "A")

                List(model.assistsLeaderList)
                {
                    playerLeaderModel in
//                    HStack
//                    {
                        PlayerLeaderDataView(playerLeaderModel: playerLeaderModel)
//                        Text("\(playerLeaderModel.assists)")
//                            .font(.caption)
//                            .fontWeight(.regular)
//                            .padding(5).padding(.trailing)
//                    }
                }
                
                PlayerLeaderHeaderView(headerTitle: "Plus/Minus", headerAbbreviation: "+/-")

                List(model.plusMinusLeaderList)
                {
                    playerLeaderModel in
//                    HStack
//                    {
                        PlayerLeaderDataView(playerLeaderModel: playerLeaderModel)
//                        Text("\(playerLeaderModel.plusMinus)")
//                            .font(.caption)
//                            .fontWeight(.regular)
//                            .padding(5).padding(.trailing)
//                    }
                }
            }
        }.listStyle(GroupedListStyle())
    }
}

#if DEBUG
struct PlayerLeadersView_Previews : PreviewProvider
{
    static var previews: some View
    {
        PlayerLeadersView()
    }
}
#endif
