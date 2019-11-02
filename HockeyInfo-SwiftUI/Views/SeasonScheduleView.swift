//
//  SeasonScheduleView.swift
//  HockeyInfoSwiftUI
//
//  Created by Larry Burris on 6/25/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import SwiftUI

struct SeasonScheduleView : View
{
    @EnvironmentObject var settings: UserSettings
    
    @ObservedObject var model = SeasonScheduleViewModel()
    
    var body: some View
    {
       Text("Number of games in season schedule is: \(model.nhlScheduleList.count)")
    }
}

#if DEBUG
struct SeasonScheduleView_Previews : PreviewProvider
{
    static var previews: some View
    {
        SeasonScheduleView().environmentObject(UserSettings())
    }
}
#endif
