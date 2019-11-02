//
//  PlayerStatsView.swift
//  HockeyInfoSwiftUI
//
//  Created by Larry Burris on 7/9/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import SwiftUI

struct PlayerStatsView : View
{
    var model: PlayerStatisticsModel
    
    var name: String
    
    var body: some View
    {
        VStack
        {
            Text("Player stats for \(name)")
            Text("Goals: \(model.goals)")
            Text("Assists: \(model.assists)")
            Text("Points: \(model.points)")
        }
    }
}

//#if DEBUG
//struct PlayerStatsView_Previews : PreviewProvider
//{
//    static var previews: some View
//    {
//        PlayerStatsView(name: "name")
//    }
//}
//#endif
