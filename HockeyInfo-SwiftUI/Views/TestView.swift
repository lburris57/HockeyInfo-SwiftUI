//
//  TestView.swift
//  HockeyInfo-SwiftUI
//
//  Created by Larry Burris on 11/4/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import SwiftUI

struct TestView: View
{
    @State var isPresented = false  // not relevant for this example
    
    var rkManager1 = RKManager(calendar: Calendar.current,
                    minimumDate: Date().addingTimeInterval(-TimeAndDateUtils.calculateMinCalendarValues()),
                    maximumDate: Date().addingTimeInterval(TimeAndDateUtils.calculateMaxCalendarValues()),
                    mode: 0)
    
    var body: some View
    {
        Group
        {
            VStack
            {
                RKViewController(isPresented: self.$isPresented, rkManager: rkManager1)
            }
            
            
            
            List
            {
                Text("item1")
                Text("item2")
                Text("item3")
                Text("item4")
                Text("item5")
                Text("item6")
            }
        }
    }
}

struct TestView_Previews: PreviewProvider
{
    static var previews: some View
    {
        TestView()
    }
}
