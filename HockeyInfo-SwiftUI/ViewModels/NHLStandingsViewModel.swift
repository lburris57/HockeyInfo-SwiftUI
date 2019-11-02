//
//  NHLStandingsViewModel.swift
//  HockeyInfoSwiftUI
//
//  Created by Larry Burris on 6/16/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation
import Combine
import SwiftUI

final class NHLStandingsViewModel: ObservableObject
{
    var willChange = PassthroughSubject<NHLStandingsViewModel, Never>()
    
    var atlanticDivisionList = [TeamStandingsData]()
    var metroDivisionList = [TeamStandingsData]()
    var centralDivisionList = [TeamStandingsData]()
    var pacificDivisionList = [TeamStandingsData]()
    var easternConferenceList = [TeamStandingsData]()
    var westernConferenceList = [TeamStandingsData]()
    var leagueList = [TeamStandingsData]()
    
    var standings: NHLStandings?
    {
        willSet
        {
            willChange.send(self)
        }
    }
    
    init()
    {
        fetchStandings()
    }
    
    private func fetchStandings()
    {
        NetworkManager().retrieveStandings
        {
            //  Load the arrays with the appropriate data
            self.atlanticDivisionList = $0.teamList.filter({$0.divisionRankInfo.divisionName == DivisionEnum.Atlantic.rawValue})
            self.metroDivisionList = $0.teamList.filter({$0.divisionRankInfo.divisionName == DivisionEnum.Metropolitan.rawValue})
            self.centralDivisionList = $0.teamList.filter({$0.divisionRankInfo.divisionName == DivisionEnum.Central.rawValue})
            self.pacificDivisionList = $0.teamList.filter({$0.divisionRankInfo.divisionName == DivisionEnum.Pacific.rawValue})
            
            self.easternConferenceList = $0.teamList.filter({$0.conferenceRankInfo.conferenceName == ConferenceEnum.Eastern.rawValue})
            self.westernConferenceList = $0.teamList.filter({$0.conferenceRankInfo.conferenceName == ConferenceEnum.Western.rawValue})
            
            self.leagueList = $0.teamList
            
            //  Sort the arrays
            self.atlanticDivisionList.sort {$0.divisionRankInfo.rank < $1.divisionRankInfo.rank}
            self.metroDivisionList.sort {$0.divisionRankInfo.rank < $1.divisionRankInfo.rank}
            self.centralDivisionList.sort {$0.divisionRankInfo.rank < $1.divisionRankInfo.rank}
            self.pacificDivisionList.sort {$0.divisionRankInfo.rank < $1.divisionRankInfo.rank}
            
            self.easternConferenceList.sort {$0.conferenceRankInfo.rank < $1.conferenceRankInfo.rank}
            self.westernConferenceList.sort {$0.conferenceRankInfo.rank < $1.conferenceRankInfo.rank}
            
            self.leagueList.sort {$0.overallRankInfo.rank < $1.overallRankInfo.rank}
            
            self.standings = $0
        }
    }
}
