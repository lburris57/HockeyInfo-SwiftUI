//
//  PlayerLeaderDataView.swift
//  HockeyInfoSwiftUI
//
//  Created by Larry Burris on 7/18/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import SwiftUI

struct PlayerLeaderDataView : View
{
    let playerLeaderModel: PlayerLeaderModel
    
    var body: some View
    {
        HStack
        {
            Text("\(playerLeaderModel.index).  \(playerLeaderModel.firstName) \(playerLeaderModel.lastName), \(playerLeaderModel.teamAbbreviation)")
            .font(.caption)
            .fontWeight(.regular)
            .padding(.horizontal, 5.0)
            Spacer()
        }
    }
}

#if DEBUG
struct PlayerLeaderDataView_Previews : PreviewProvider
{
    static var previews: some View
    {
        PlayerLeaderDataView(playerLeaderModel: PlayerLeaderModel())
    }
}
#endif
