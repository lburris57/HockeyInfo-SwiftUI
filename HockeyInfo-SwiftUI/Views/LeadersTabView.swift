//
//  LeadersTabView.swift
//  HockeyInfoSwiftUI
//
//  Created by Larry Burris on 7/16/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import SwiftUI

struct LeadersTabView : View
{
    @EnvironmentObject var settings: UserSettings
    
    var body: some View
    {
        TabView()
        {
            PlayerLeadersView().tabItem
            {
                Image("icons8-ice_skate_2")
                Text("Skaters")
            }
            GoalieLeadersView().tabItem
            {
                Image("icons8-hockey")
                Text("Goalies")
            }
        }
    }
}

#if DEBUG
struct LeadersTabView_Previews : PreviewProvider
{
    static var previews: some View
    {
        LeadersTabView()
    }
}
#endif
