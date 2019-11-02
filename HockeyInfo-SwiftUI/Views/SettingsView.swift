//
//  SettingsView.swift
//  HockeyInfoSwiftUI
//
//  Created by Larry Burris on 7/9/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import SwiftUI

struct SettingsView : View
{
    var seasons = ["2007-2008", "2008-2009", "2009-2010", "2010-2011", "2011-2012", "2012-2013", "2013-2014", "2014-2015", "2015-2016", "2016-2017", "2017-2018", "2018-2019", "2019-2020"]
    var playoffYears = ["2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015", "2016", "2017", "2018", "2019", "2020"]
    
    @EnvironmentObject var settings: UserSettings
    
    @State var selectedSeason = 12
    @State var selectedSeasonType = 0
    @State var seasonType = ["Regular Season", "Playoffs"]
    
    @State private var showAlert = false
    
    func evaluateAlertStatus() -> Bool
    {
        showAlert = !TimeAndDateUtils.isValidSetting(seasons[selectedSeason], seasonType[selectedSeasonType])
        print("Value of showAlert is \(showAlert)")
        
        return showAlert
    }

    var body: some View
    {
        NavigationView
        {
            Form
            {
//                Section
//                {
//                    Picker(selection: $selectedSeason, label: Text("Season"))
//                    {
//                        ForEach(0 ..< seasons.count)
//                        {
//                            Text(self.seasons[$0]).tag($0)
//                        }
//                    }
//                }
                
//                Section(footer: showAlert == false ? Text("") : Text("\(alertText)"))
//                {
//                    Picker(selection: $selectedSeasonType)
//                    {
//                        ForEach(0 ..< seasonType.count)
//                        {
//                            Text(self.seasonType[$0]).tag($0)
//                        }
//                    }
//                }
                
                Section
                {
                    Button(action:
                    {
                        if(!self.evaluateAlertStatus())
                        {
                            self.settings.season = self.seasons[self.selectedSeason]
                            self.settings.playoffYear = self.playoffYears[self.selectedSeason]
                            self.settings.seasonType = self.seasonType[self.selectedSeasonType]
                        }
                        else
                        {
                            self.showAlert = true
                            //print("\(self.alertText)")
                        }
                    })
                    {
                        Text("Save settings")
                    }//.presentation($showAlert) {Alert(title: Text("Playoffs not valid for 2020"), message: Text("\(alertText)"))}
                    //.alert(isPresented: $isAlert, content: {
                                //alert
                            //})
                }
            }//.navigationBarTitle(Text("Settings"))
        }
    }
}

#if DEBUG
struct SettingsView_Previews : PreviewProvider
{
    static var previews: some View
    {
        SettingsView().environmentObject(UserSettings())
    }
}
#endif


