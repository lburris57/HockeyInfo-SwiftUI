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
    var model: PlayerDetailModel
    
    var body: some View
    {
        VStack
        {
            //  Team image
            Image("\(model.teamAbbreviation)").resizable().frame(height: 225).minimumScaleFactor(0.25)
            
            //  Player Image
            if(model.imageUrl != "")
            {
                WebImage(url: URL(string: "\(model.imageUrl)"))
                    .onSuccess
                    {
                        image, cacheType in
                        // Success
                    }
                    .resizable()
                    .indicator(.activity) // Activity Indicator
                    .scaledToFit()
                    .clipShape(Circle()).background(Circle().foregroundColor(.white))
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 15).offset(x: 0, y: -90).padding(.bottom, -90)
            }
            else
            {
                Image("photo-not-available")
                .resizable()
                .scaledToFit()
                .clipShape(Circle()).background(Circle().foregroundColor(.white))
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 15).offset(x: 0, y: -90).padding(.bottom, -90)
            }
            
            //  Player Name
            Text("\(model.firstName)" + " " + "\(model.lastName)")
                .font(.system(size:50))
                .fontWeight(.bold)
                .padding(.horizontal)
                .minimumScaleFactor(0.50)
            
            //  Player Jersey Number and Position
            Text("\(model.jerseyNumber)" + "   " + "\(model.position)")
                .font(.system(size:30))
                .fontWeight(.bold)
                .padding(.horizontal)
                .minimumScaleFactor(0.75)
            
            Spacer()
        
            //  Player Information
            VStack(alignment: .leading)
            {
                Text("Birth Date: " + "\(model.birthDate)")
                Text("Age: " + "\(model.age)")
                Text("Birth City: " + "\(model.birthCity)")
                Text("Birth Country: " + "\(model.birthCountry)")
                Text("Height: " + "\(model.height)")
                Text("Weight: " + "\(model.weight)")
                Text("Status: Available")
                Text("Shoots: " + "\(model.shoots)")
                
                Spacer()
                
                NavigationLink(destination: PlayerStatsView(model: DBManager().retrievePlayerStatistics(model.playerId), name: "\(model.firstName)" + " " + "\(model.lastName)"))
                {
                    Text("Display Player Statistics").padding(.bottom, 20.0)
                }
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
