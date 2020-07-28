//
//  PlayerDetailView
//  HockeyInfoSwiftUI
//
//  Created by Larry Burris on 6/11/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import SwiftUI
import SDWebImageSwiftUI

struct PlayerDetailView : View
{
    var playerDetail: PlayerDetailModel
    
    @State private var showingSheet = false
    
    //@ObservedObject var model = PlayerStatisticsViewModel()
    
    var body: some View
    {
        ScrollView
        {
            VStack
            {
                //  Team image
                Image("\(playerDetail.teamAbbreviation)").resizable().frame(height: 200).minimumScaleFactor(0.25)
                
                //  Player Image
                if(playerDetail.imageUrl != "")
                {
                    WebImage(url: URL(string: "\(playerDetail.imageUrl)"))
                        .onSuccess
                        {
                            image, cacheType in
                            // Success
                        }
                        .resizable()
                        .frame(width: 200, height: 200, alignment: .center)
                        .scaledToFit()
                        .clipShape(Circle()).background(Circle().foregroundColor(.white))
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .shadow(radius: 15).offset(x: 0, y: -90).padding(.bottom, -90)
                }
                else
                {
                    Image("photo-not-available")
                    .resizable()
                    .frame(width: 200, height: 200, alignment: .center)
                    .scaledToFit()
                    .clipShape(Circle()).background(Circle().foregroundColor(.white))
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 15).offset(x: 0, y: -90).padding(.bottom, -90)
                }
                
                //  Player Name
                Text("\(playerDetail.fullName)")
                    .font(.system(size:30))
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
            
                //  Player Information
                VStack(alignment: .leading)
                {
                    Group
                    {
                        Text("Birth Date: " + "\(playerDetail.birthDate)")
                        Text("Age: " + "\(playerDetail.age)")
                        Text("Birth City: " + "\(playerDetail.birthCity)")
                        Text("Birth Country: " + "\(playerDetail.birthCountry)")
                        Text("Height: " + "\(playerDetail.height)")
                        Text("Weight: " + "\(playerDetail.weight)")
                        Text("Status: Available")
                        Text("Shoots: " + "\(playerDetail.shoots)")
                    }.padding(2)
                    
                    Spacer()
                    
//                    NavigationLink(destination: PlayerStatsView(playerDetail: playerDetail, playerStatistics: DBManager().retrievePlayerStatistics(playerDetail.playerId)))
//                    {
//                        Text("Display Player Statistics").padding(10).foregroundColor(.white)
//                    }.buttonStyle(NeumorphicButtonStyle()).padding(5)
                    
                    Button("    Display Player Statistics    ")
                    {
                        self.showingSheet.toggle()
                    }.buttonStyle(NeumorphicButtonStyle()).padding(5)
                    .sheet(isPresented: $showingSheet)
                    {
                        PlayerStatsView(playerDetail: self.playerDetail, playerStatistics: DBManager().retrievePlayerStatistics(self.playerDetail.playerId))
                    }.foregroundColor(.white).padding()
                }
                
                Spacer()
            }
        }
    }
}
