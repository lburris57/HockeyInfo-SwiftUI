//
//  RKManager.swift
//  RKCalendar
//
//  Created by Raffi Kian on 7/14/19.
//  Copyright © 2019 Raffi Kian. All rights reserved.
//
import SwiftUI

class RKManager : ObservableObject
{
    @Published var calendar = Calendar.current
    @Published var minimumDate: Date = Date()
    @Published var maximumDate: Date = Date()
    @Published var disabledDates: [Date] = [Date]()
    @Published var selectedDates: [Date] = [Date]()
    @Published var startDate: Date! = nil
    @Published var endDate: Date! = nil
    @Published var selectedDate: Date! = nil
    @Published var scheduledGameModelList = [ScheduledGameModel]()
    @Published var mode: Int = 0
    
    var colors = RKColorSettings()
  
    init(calendar: Calendar, minimumDate: Date, maximumDate: Date, selectedDates: [Date] = [Date](), mode: Int)
    {
        self.calendar = calendar
        self.minimumDate = minimumDate
        self.maximumDate = maximumDate
        self.selectedDates = selectedDates
        self.mode = mode
        //self.scheduledGameModelList = DBManager().retrieveScheduledGamesForDate(Date().getTextFromDate())
    }
    
    func selectedDatesContains(date: Date) -> Bool
    {
        if let _ = self.selectedDates.first(where: { calendar.isDate($0, inSameDayAs: date) })
        {
            return true
        }
        
        return false
    }
    
    func selectedDatesFindIndex(date: Date) -> Int?
    {
        return self.selectedDates.firstIndex(where: { calendar.isDate($0, inSameDayAs: date) })
    }
    
    func disabledDatesContains(date: Date) -> Bool
    {
        if let _ = self.disabledDates.first(where: { calendar.isDate($0, inSameDayAs: date) })
        {
            return true
        }
        
        return false
    }
    
    func disabledDatesFindIndex(date: Date) -> Int?
    {
        return self.disabledDates.firstIndex(where: { calendar.isDate($0, inSameDayAs: date) })
    }
}
