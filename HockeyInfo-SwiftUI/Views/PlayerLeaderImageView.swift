//
//  PlayerLeaderImageView.swift
//  HockeyInfoSwiftUI
//
//  Created by Larry Burris on 7/19/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import SwiftUI
//import ImageWithActivityIndicator

struct PlayerLeaderImageView : View
{
    let playerLeaderModel: PlayerLeaderModel
    
    var body: some View
    {
        VStack
        {
            //ImageWithActivityIndicator(imageURL: playerLeaderModel.imageURL, placeHolder: "photo-not-available").frame(width: 30.0, height: 30.0)
            Text(playerLeaderModel.firstName).font(.caption)
            Text(playerLeaderModel.lastName).font(.caption)
        }
    }
}

#if DEBUG
struct PlayerLeaderImageView_Previews : PreviewProvider
{
    static var previews: some View
    {
        PlayerLeaderImageView(playerLeaderModel: PlayerLeaderModel())
    }
}
#endif
