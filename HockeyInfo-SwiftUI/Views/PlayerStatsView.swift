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
    @EnvironmentObject var settings: UserSettings
    @ObservedObject var model = PlayerStatisticsViewModel()
    
    var body: some View
    {
        Text("Last updated on \(model.playerStats.lastUpdatedOn)")
    }
}

#if DEBUG
struct PlayerStatsView_Previews : PreviewProvider
{
    static var previews: some View
    {
        PlayerStatsView().environmentObject(UserSettings())
    }
}
#endif
