//
//  PlayerStatsView.swift
//  HockeyInfoSwiftUI
//
//  Created by Larry Burris on 7/9/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import SwiftUI
import SDWebImageSwiftUI

struct PlayerStatsView : View
{
    var playerDetail: PlayerDetailModel
    var playerStatistics: PlayerStatisticsModel
    
    var body: some View
    {
        VStack
        {
            //  Team image
            Image("\(playerDetail.teamAbbreviation)").resizable().frame(height: 200).minimumScaleFactor(0.25)
            
            Spacer()
            
            if(playerDetail.imageUrl != "")
            {
                WebImage(url: URL(string: "\(playerDetail.imageUrl)"))
                    .onSuccess
                    {
                        image, cacheType in
                        // Success
                    }
                    .resizable()
                    .frame(width: 225, height: 200, alignment: .center)
                    .scaledToFit()
                    .clipShape(Circle()).background(Circle().foregroundColor(.white))
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 15).offset(x: 0, y: -90).padding(.bottom, -90)
            }
            else
            {
                Image("photo-not-available")
                .resizable()
                .frame(width: 225, height: 225, alignment: .center)
                .scaledToFit()
                .clipShape(Circle()).background(Circle().foregroundColor(.white))
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 15).offset(x: 0, y: -90).padding(.bottom, -90)
            }
            
            VStack
            {
                //  Player Name
               Text("\(playerDetail.fullName)")
                   .font(.system(size:50))
                   .fontWeight(.bold)
                   .padding(.horizontal)
                   .minimumScaleFactor(0.50)
               
               //  Player Jersey Number and Position
               Text("\(playerDetail.jerseyNumber)" + "   " + "\(playerDetail.position)")
                   .font(.system(size:30))
                   .fontWeight(.bold)
                   .padding(.horizontal)
                   .minimumScaleFactor(0.75)
                
                Spacer()
            }
            
            VStack(alignment: .leading)
            {
                HStack
                {
                    Text("Games Played: \(playerStatistics.gamesPlayed)").padding(.leading)
                    Spacer()
                    Text("Plus/Minus: \(playerStatistics.plusMinus)").padding(.trailing)
                }
                
                HStack
                {
                    Text("Goals: \(playerStatistics.goals)").padding(.leading)
                    Spacer()
                    Text("Short Handed Goals: \(playerStatistics.shortHandedGoals)").padding(.trailing)
                }
                
                HStack
                {
                    Text("Assists: \(playerStatistics.assists)").padding(.leading)
                    Spacer()
                    Text("Short Handed Assists: \(playerStatistics.shortHandedAssists)").padding(.trailing)
                }
                
                HStack
                {
                    Text("Points: \(playerStatistics.points)").padding(.leading)
                    Spacer()
                    Text("Short Handed Points: \(playerStatistics.shortHandedPoints)").padding(.trailing)
                }
                
                HStack
                {
                    Text("Hat Tricks: \(playerStatistics.hatTricks)").padding(.leading)
                    Spacer()
                    Text("Game Winning Goals: \(playerStatistics.gameWinningGoals)").padding(.trailing)
                }
                
                HStack
                {
                    Text("Power Play Goals: \(playerStatistics.powerplayGoals)").padding(.leading)
                    Spacer()
                    Text("Game Tying Goals: \(playerStatistics.gameTyingGoals)").padding(.trailing)
                }
                
                HStack
                {
                    Text("Power Play Goals: \(playerStatistics.powerplayAssists)").padding(.leading)
                    Spacer()
                    Text("Penalties: \(playerStatistics.penalties)").padding(.trailing)
                }
                
                HStack
                {
                    Text("Power Play Points: \(playerStatistics.powerplayPoints)").padding(.leading)
                    Spacer()
                    Text("Penalty Minutes: \(playerStatistics.penaltyMinutes)").padding(.trailing)
                }
            }
            
                HStack
                {
                    Text("Shots: \(playerStatistics.shots)").padding(.leading)
                    Spacer()
                    Text("Faceoffs: \(playerStatistics.faceoffs)").padding(.trailing)
                }
                
                HStack
                {
                    Text("Shot Percentage: \(ConversionUtils.formatToSpecifiedDecimalPlaces(playerStatistics.shotPercentage, 2))%").padding(.leading)
                    Spacer()
                    Text("Faceoff Wins: \(playerStatistics.faceoffWins)").padding(.trailing)
                }
                
                HStack
                {
                    Text("Blocked Shots: \(playerStatistics.blockedShots)").padding(.leading)
                    Spacer()
                    Text("Faceoff Losses: \(playerStatistics.faceoffLosses)").padding(.trailing)
                }
                
                HStack
                {
                    Text("Hits: \(playerStatistics.hits)").padding(.leading)
                    Spacer()
                    Text("Faceoff Percentage: \(ConversionUtils.formatToSpecifiedDecimalPlaces(playerStatistics.faceoffPercent, 2))%").padding(.trailing)
                }
            
            Spacer(minLength: 60)
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
