//
//  LeaderRow.swift
//  HockeyInfoSwiftUI
//
//  Created by Larry Burris on 7/18/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import SwiftUI

struct LeaderRow : View
{
    var player: NHLPlayer
    var index: Int
    var category: String
    
    var body: some View
    {
        HStack
        {
            Text("\(index).  \(player.firstName) \(player.lastName), \(player.teamAbbreviation)").padding(5).padding(.leading)
            
            if(category == "points")
            {
                Text("\(player.playerStatisticsList[0].points)").padding(5).padding(.trailing)
            }
            else if(category == "goals")
            {
                Text("\(player.playerStatisticsList[0].goals)").padding(5).padding(.trailing)
            }
            else if(category == "assists")
            {
                Text("\(player.playerStatisticsList[0].assists)").padding(5).padding(.trailing)
            }
            else if(category == "plusMinus")
            {
                Text("\(player.playerStatisticsList[0].plusMinus)").padding(5).padding(.trailing)
            }
            else if(category == "goalsAgainstAverage")
            {
                Text("\(player.playerStatisticsList[0].goalsAgainstAverage)").padding(5).padding(.trailing)
            }
            else if(category == "savePercentage")
            {
                Text("\(player.playerStatisticsList[0].savePercentage)").padding(5).padding(.trailing)
            }
            else if(category == "wins")
            {
                Text("\(player.playerStatisticsList[0].wins)").padding(5).padding(.trailing)
            }
            else if(category == "shutouts")
            {
                Text("\(player.playerStatisticsList[0].shutouts)").padding(5).padding(.trailing)
            }
        }
    }
}

//#if DEBUG
//struct LeaderRow_Previews : PreviewProvider
//{
//    static var previews: some View
//    {
//        LeaderRow()
//    }
//}
//#endif
