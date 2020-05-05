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
    
    var body: some View
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
                    .frame(width: 225, height: 225, alignment: .center)
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
        
            //  Player Information
            VStack(alignment: .leading)
            {
                Text("Birth Date: " + "\(playerDetail.birthDate)")
                Text("Age: " + "\(playerDetail.age)")
                Text("Birth City: " + "\(playerDetail.birthCity)")
                Text("Birth Country: " + "\(playerDetail.birthCountry)")
                Text("Height: " + "\(playerDetail.height)")
                Text("Weight: " + "\(playerDetail.weight)")
                Text("Status: Available")
                Text("Shoots: " + "\(playerDetail.shoots)")
                
                Spacer()
                
                NavigationLink(destination: PlayerStatsView(playerDetail: playerDetail, playerStatistics: DBManager().retrievePlayerStatistics(playerDetail.playerId)))
                {
                    Text("Display Player Statistics").padding()
                }
                   
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .clipShape(Capsule())
                    .cornerRadius(20)
                    .padding(.bottom, 20.0)
            }
        }
    }
}

//#if DEBUG
//struct PlayerDetailView_Previews : PreviewProvider
//{
//    static var previews: some View
//    {
//        Group
//        {
//            PlayerDetailView(name: "Alex Ovechkin").previewDevice("iPhone 8+").environmentObject(UserSettings())
//        }
//    }
//}
//#endif
