//
//  GoalieLeadersView.swift
//  HockeyInfoSwiftUI
//
//  Created by Larry Burris on 7/16/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import SwiftUI

struct GoalieLeadersView : View
{
    @ObservedObject var model = PlayerLeadersViewModel()
    
    var body: some View
    {
        List
        {
            VStack
            {
                PlayerLeaderHeaderView(headerTitle: "Wins", headerAbbreviation: "W")
                
                List(model.winsLeaderList)
                {
                    playerLeaderModel in
//                    HStack
//                    {
                        PlayerLeaderDataView(playerLeaderModel: playerLeaderModel)
//                        Text("\(playerLeaderModel.shutouts)")
//                            .font(.caption)
//                            .fontWeight(.regular)
//                            .padding(5).padding(.trailing)
//                    }
                }
                
                PlayerLeaderHeaderView(headerTitle: "Shutouts", headerAbbreviation: "SO")
                
                List(model.shutoutsLeaderList)
                {
                    playerLeaderModel in
//                    HStack
//                    {
                        PlayerLeaderDataView(playerLeaderModel: playerLeaderModel)
//                        Text("\(playerLeaderModel.shutouts)")
//                            .font(.caption)
//                            .fontWeight(.regular)
//                            .padding(5).padding(.trailing)
//                    }
                }
                
                PlayerLeaderHeaderView(headerTitle: "Goals Against Average", headerAbbreviation: "GAA")

                List(model.goalsAgainstAverageLeaderList)
                {
                    playerLeaderModel in
//                    HStack
//                    {
                        PlayerLeaderDataView(playerLeaderModel: playerLeaderModel)
//                        Text("\(ConversionUtils.formatToSpecifiedDecimalPlaces(playerLeaderModel.goalsAgainstAverage, 2))")
//                            .font(.caption)
//                            .fontWeight(.regular)
//                            .padding(5).padding(.trailing)
//                    }
                }
                
                PlayerLeaderHeaderView(headerTitle: "Save Percentage", headerAbbreviation: "%")

                List(model.savePercentageLeaderList)
                {
                    playerLeaderModel in
//                    HStack
//                    {
                        PlayerLeaderDataView(playerLeaderModel: playerLeaderModel)
//                        Text("\(ConversionUtils.formatToSpecifiedDecimalPlaces(playerLeaderModel.savePercentage, 3))")
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
struct GoalieLeadersView_Previews : PreviewProvider
{
    static var previews: some View
    {
        GoalieLeadersView()
    }
}
#endif
