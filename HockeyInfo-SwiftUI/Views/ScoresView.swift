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
    @EnvironmentObject var settings: UserSettings
    
    var body: some View
    {
        Text("Scores View!")
    }
}

#if DEBUG
struct ScoresView_Previews : PreviewProvider
{
    static var previews: some View
    {
        ScoresView().environmentObject(UserSettings())
    }
}
#endif
