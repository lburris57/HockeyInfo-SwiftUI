//
//  PlayerDetailView
//  HockeyInfoSwiftUI
//
//  Created by Larry Burris on 6/11/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import SwiftUI

struct PlayerDetailView : View
{
    @EnvironmentObject var settings: UserSettings
    
    @State var model = PlayerDetailModel()
    
    var name: String
    
    var body: some View
    {
        VStack
        {
            //  Team image
            Image("\($model.teamAbbreviation)").resizable().frame(height: 225).minimumScaleFactor(0.25)
            
            //  Player Image
            Image("Ovechkin").resizable().scaledToFit()
                .clipShape(Circle()).background(Circle().foregroundColor(.white))
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 15).offset(x: 0, y: -90).padding(.bottom, -90)
            
            //  Player Name
            Text("\($model.firstName)" + " " + "\($model.lastName)")
                //Text("Alexander Ovechkin")
                .font(.system(size:50))
                .fontWeight(.bold)
                .padding(.horizontal)
                .minimumScaleFactor(0.50)
            
            //  Player Jersey Number and Position
            Text("\($model.jerseyNumber)" + " " + "\($model.position)")
                //Text("8 LW")
                .font(.system(size:30))
                .fontWeight(.bold)
                .padding(.horizontal)
                .minimumScaleFactor(0.75)
            
            Spacer()
        
            //  Player Information
            VStack(alignment: .leading)
            {
                Text("Birth Date: " + "\($model.birthDate)")
                Text("Age: " + "\($model.age)")
                Text("Birth City: " + "\($model.birthCity)")
                Text("Birth Country: " + "\($model.birthCountry)")
                Text("Height: " + "\($model.height)")
                Text("Weight: " + "\($model.weight)")
                Text("Status: Available")
                Text("Shoots: " + "\($model.shoots)")
                
//                Text("Birth Date: 09/17/1985")
//                Text("Age: 33")
//                Text("Birth City: Moscow")
//                Text("Birth Country: Russia")
//                Text("Height: 6' 3\"")
//                Text("Weight: 235")
//                Text("Status: Available")
//                Text("Shoots: Right")
            }
            
            Spacer()
            
            Button(action: {})
            {
                Text("Display Player Statistics")
                    .padding(.bottom, 20.0)
            }
        }.onAppear{self.model = DBManager().retrievePlayerDetail(self.name)}
    }
}

#if DEBUG
struct PlayerDetailView_Previews : PreviewProvider
{
    static var previews: some View
    {
        Group
        {
            PlayerDetailView(name: "Alex Ovechkin").previewDevice("iPhone 8+").environmentObject(UserSettings())
        }
    }
}
#endif
