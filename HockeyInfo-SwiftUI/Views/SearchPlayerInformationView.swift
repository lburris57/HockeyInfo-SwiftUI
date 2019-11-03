//
//  SearchPlayerInformationView.swift
//  HockeyInfoSwiftUI
//
//  Created by Larry Burris on 6/25/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import SwiftUI
import Foundation
import UIKit

struct SearchPlayerInformationView : View
{
    @EnvironmentObject var settings: UserSettings
    
    @ObservedObject var model = RosterPlayersViewModel()
    
    @State var searchQuery: String = ""
    
    var body: some View
    {
        VStack
        {
            Text("Search Players")
            
            List
            {
                Section(header: SearchBar(text: self.$searchQuery))
                {
                    ForEach(model.playerNames.filter{searchQuery.count > 20 ? true : "\($0)".contains(searchQuery)}, id: \.self)
                    {
                        name in
                        
                        NavigationLink(destination: PlayerDetailView(playerDetail: DBManager().retrievePlayerDetail(name)))
                        {
                            Text(name)
                        }
                    }
                }
            }
        }
    }
}

func filterList(_ names: [String], _ searchQuery: String) -> [String]
{
    return names.filter{searchQuery.count > 20 ? true : "\($0)".contains(searchQuery)}
}

#if DEBUG
struct SearchPlayerInformationView_Previews : PreviewProvider
{
    static var previews: some View
    {
        SearchPlayerInformationView().environmentObject(UserSettings())
    }
}
#endif
