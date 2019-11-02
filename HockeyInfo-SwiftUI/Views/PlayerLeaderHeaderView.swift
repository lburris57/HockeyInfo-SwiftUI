//
//  PlayerLeaderHeaderView.swift
//  HockeyInfoSwiftUI
//
//  Created by Larry Burris on 7/18/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import SwiftUI

struct PlayerLeaderHeaderView : View
{
    var headerTitle: String
    var headerAbbreviation: String
    
    var body: some View
    {
        HStack
        {
            Text(headerTitle)
                .font(.body)
                .fontWeight(.regular)
                .underline()
                .padding(.horizontal, 5.0)
            Spacer()
            Text(headerAbbreviation)
                .font(.body)
                .fontWeight(.regular)
                .underline()
                .padding(5).padding(.trailing)
        }
    }
}

#if DEBUG
struct PlayerLeaderHeaderView_Previews : PreviewProvider
{
    static var previews: some View
    {
        PlayerLeaderHeaderView(headerTitle: "Goals", headerAbbreviation: "G")
    }
}
#endif
