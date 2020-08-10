//
//  ScoresView.swift
//  HockeyInfoSwiftUI
//
//  Created by Larry Burris on 6/25/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import SwiftUI

struct ScoresView : View
{
    @EnvironmentObject var settings: UserSettingsViewModel
    
    var body: some View
    {
        VStack
        {
            Text("Scores View!")
        }.navigationBarTitle(Text("Scores"), displayMode: .inline)
    }
}

#if DEBUG
struct ScoresView_Previews : PreviewProvider
{
    static var previews: some View
    {
        ZStack
        {
            Color.gray
            ScoresView().environmentObject(UserSettingsViewModel()).foregroundColor(.white)
        }.navigationBarTitle(Text("Scores"), displayMode: .inline)
    }
}
#endif
