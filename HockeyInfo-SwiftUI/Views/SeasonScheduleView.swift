//
//  SeasonScheduleView.swift
//  HockeyInfoSwiftUI
//
//  Created by Larry Burris on 6/25/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import SwiftUI

struct SeasonScheduleView : View
{
    @ObservedObject var model = SeasonScheduleViewModel()
    
    @State var isPresented = true
    
    @ObservedObject var rkManager = RKManager(calendar: Calendar.current,
                    minimumDate: Date().addingTimeInterval(-TimeAndDateUtils.calculateMinCalendarValues()),
                    maximumDate: Date().addingTimeInterval(TimeAndDateUtils.calculateMaxCalendarValues()),
                    mode: 0)
    
    var body: some View
    {
        VStack
        {
            Group
            {
                VStack
                {
                    RKViewController(isPresented: self.$isPresented, rkManager: rkManager)
                }
                
                Divider()
                
                if(self.rkManager.selectedDate != nil)
                {
                    Text("Schedule for \(self.rkManager.selectedDate.getTextFromDate())")
                }
                
                List
                {
                    if(rkManager.scheduledGameModelList.count == 0)
                    {
                        Text("No Games Scheduled").font(.subheadline).padding(.leading, 100)
                    }
                    else
                    {
                        ForEach(rkManager.scheduledGameModelList)
                        {
                            scheduledGameModel in
                            
                            VStack(alignment: .leading)
                            {
                                HStack
                                {
                                    Text(scheduledGameModel.startTime).font(.caption)
                                    Text("|")
                                    Text(scheduledGameModel.gameInfo).font(.caption)
                                }
                                
                                HStack
                                {
                                    Text("|").padding(.leading, 62)
                                    Text(scheduledGameModel.venue).font(.caption).padding(.leading, 1)
                                }
                            }
                        }
                    }
                }
                
                Spacer()
            }
        }
    }
}

#if DEBUG
struct SeasonScheduleView_Previews : PreviewProvider
{
    static var previews: some View
    {
        SeasonScheduleView().environmentObject(UserSettings())
    }
}
#endif
