//
//  NHLStandingsViewModel.swift
//  HockeyInfoSwiftUI
//
//  Created by Larry Burris on 6/16/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Combine
import SwiftUI

final class NHLStandingsViewModel: ObservableObject
{
    @Published var atlanticDivisionList = [TeamStandings]()
    @Published var metroDivisionList = [TeamStandings]()
    @Published var centralDivisionList = [TeamStandings]()
    @Published var pacificDivisionList = [TeamStandings]()
    @Published var easternConferenceList = [TeamStandings]()
    @Published var westernConferenceList = [TeamStandings]()
    @Published var leagueList = [TeamStandings]()
    
    var teamStandingsList = [TeamStandings]()
    
    func fetchStandings()
    {
        teamStandingsList = DBManager().retrieveTeamStandings()
        
        //  Load the arrays with the appropriate data
        atlanticDivisionList = teamStandingsList.filter({$0.division == DivisionEnum.Atlantic.rawValue})
        metroDivisionList = teamStandingsList.filter({$0.division == DivisionEnum.Metropolitan.rawValue})
        centralDivisionList = teamStandingsList.filter({$0.division == DivisionEnum.Central.rawValue})
        pacificDivisionList = teamStandingsList.filter({$0.division == DivisionEnum.Pacific.rawValue})
        
        easternConferenceList = teamStandingsList.filter({$0.conference == ConferenceEnum.Eastern.rawValue})
        westernConferenceList = teamStandingsList.filter({$0.conference == ConferenceEnum.Western.rawValue})
        
        leagueList = teamStandingsList
        
        //  Sort the arrays
        atlanticDivisionList.sort {$0.divisionRank < $1.divisionRank}
        metroDivisionList.sort {$0.divisionRank < $1.divisionRank}
        centralDivisionList.sort {$0.divisionRank < $1.divisionRank}
        pacificDivisionList.sort {$0.divisionRank < $1.divisionRank}
        
        easternConferenceList.sort {$0.conferenceRank < $1.conferenceRank}
        westernConferenceList.sort {$0.conferenceRank < $1.conferenceRank}
        
        leagueList.sort {$0.points > $1.points}
    }
}
