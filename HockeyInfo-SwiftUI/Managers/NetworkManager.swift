//
//  NetworkManager.swift
//  HockeyInfoSwiftUI
//
//  Created by Larry Burris on 6/16/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation
import RealmSwift

class NetworkManager
{
    let session = URLSession.shared
    
    let databaseManager = DBManager()
    
    let urlHelper = URLHelper()
    
    let dataExchangeHelper = DataExchangeHelper()
    
    /*
     On load...
     -----------
     - Load/update full season schedule
     
     - Load Teams
        - Link schedules to teams
        - Load and link team standings
        - Load and link team statistics
        - Load and link players
        - Load players
            - Load and link player statistics
            - Load and link player injuries to players and teams
     
     */
    
    // MARK: Retrieve methods
    
    //  Retrieve full season schedule for all 31 teams
    func retrieveFullSeasonSchedule(completion: @escaping ([NHLSchedule]) -> ())
    {
        print("\n\nIn NetworkManager.retrieveFullSeasonSchedule method...\n\n")
        
        if(!databaseManager.fullScheduleRequiresLoad())
        {
            print("Full season schedule has already been saved to the database...")
            
            return
        }
        
        session.dataTask(with: createRequest(urlHelper.retrieveFullSeasonURL()))
        {
            data, response, err in
            
            if let response = response as? HTTPURLResponse
            {
                print("Response code is \(response.statusCode)")
            }
            
            if err != nil
            {
                fatalError(err!.localizedDescription + "\nfor " + self.urlHelper.retrieveFullSeasonURL())
            }
            else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200
            {
                let seasonSchedule = try! JSONDecoder().decode(SeasonSchedule.self, from: data)
                
                let scheduledGames = self.dataExchangeHelper.convertSeasonScheduleToNHLScheduleList(seasonSchedule)
                
                self.databaseManager.saveFullSeasonScheduleGameData(scheduledGames)
                
                DispatchQueue.main.async
                {
                    completion(scheduledGames)
                }
            }
        }.resume()
    }
    
    func retrieveStandings(completion: @escaping (NHLStandings) -> ())
    {
        print("\n\nIn NetworkManager.retrieveStandings method...\n\n")
        
        session.dataTask(with: createRequest(urlHelper.retrieveStandingsURL()))
        {
            data, response, err in
            
            if err != nil
            {
                fatalError(err!.localizedDescription + "\nfor " + self.urlHelper.retrieveStandingsURL())
            }
            else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200
            {
                let nhlStandings = try! JSONDecoder().decode(NHLStandings.self, from: data)
                
                self.databaseManager.saveStandings(nhlStandings)
                
                DispatchQueue.main.async
                {
                    completion(nhlStandings)
                }
            }
        }.resume()
    }
    
    func retrieveRosters(completion: @escaping (RosterPlayers) -> ())
    {
        print("\n\nIn NetworkManager.retrieveRosters method...\n\n")
        
        session.dataTask(with: createRequest(urlHelper.retrieveRosterPlayersURL()))// https://api.mysportsfeeds.com/v2.1/pull/nhl/players.json?rosterstatus=assigned-to-roster&season=2018-2019-regular
        {
            data, response, err in
            
            if err != nil
            {
                fatalError(err!.localizedDescription + "\nfor " + self.urlHelper.retrieveRosterPlayersURL())
            }
            else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200
            {
                let rosterPlayers = try! JSONDecoder().decode(RosterPlayers.self, from: data)
                
                self.databaseManager.saveRosters(rosterPlayers)
                
                DispatchQueue.main.async
                {
                    completion(rosterPlayers)
                }
            }
        }.resume()
    }
    
    func retrievePlayerStats(completion: @escaping (PlayerStats) -> ())
    {
        print("\n\nIn NetworkManager.retrievePlayerStats method...\n\n")
        
        session.dataTask(with: createRequest(urlHelper.retrievePlayerStatsURL()))
        {
            data, response, err in
            
            if err != nil
            {
                fatalError(err!.localizedDescription)
            }
            else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200
            {
                let playerStats = try! JSONDecoder().decode(PlayerStats.self, from: data)
                
                self.databaseManager.savePlayerStats(playerStats)
                
                DispatchQueue.main.async
                {
                    completion(playerStats)
                }
            }
        }.resume()
    }
    
    func retrievePlayerInjuries(completion: @escaping (PlayerInjuries) -> ())
    {
        print("\n\nIn NetworkManager.retrievePlayerInjuries method...\n\n")
        
        session.dataTask(with: createRequest(urlHelper.retrievePlayerInjuriesURL()))
        {
            data, response, err in
            
            if err != nil
            {
                fatalError(err!.localizedDescription)
            }
            else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200
            {
                if let playerInjuries = try? JSONDecoder().decode(PlayerInjuries.self, from: data)
                {
                    self.databaseManager.savePlayerInjuries(playerInjuries)
                    
                    DispatchQueue.main.async
                    {
                        completion(playerInjuries)
                    }
                }
            }
        }.resume()
    }
    
    func retrieveScoringSummary(forGameId gameId: Int, completion: @escaping (ScoringSummary) -> ())
    {
        print("\n\nIn NetworkManager.retrieveScoringSummary method...\n\n")
        
        session.dataTask(with: createRequest(urlHelper.retrieveScoringSummaryURL(gameId)))
        {
            data, response, err in
            
            if err != nil
            {
                fatalError(err!.localizedDescription)
            }
            else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200
            {
                let scoringSummary = try! JSONDecoder().decode(ScoringSummary.self, from: data)
                
                self.databaseManager.saveScoringSummary(scoringSummary)
                
                DispatchQueue.main.async
                {
                    completion(scoringSummary)
                }
            }
        }.resume()
    }
    
    func retrieveGameLog(completion: @escaping (GameLog) -> ())
    {
        print("\n\nIn NetworkManager.retrieveGameLog method...\n\n")
        
        session.dataTask(with: createRequest(urlHelper.retrieveGameLogsURL()))
        {
            data, response, err in
            
            if err != nil
            {
                fatalError(err!.localizedDescription)
            }
            else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200
            {
                let gameLog = try! JSONDecoder().decode(GameLog.self, from: data)
                
                self.databaseManager.saveGameLog(gameLog)
                
                DispatchQueue.main.async
                {
                    completion(gameLog)
                }
            }
        }.resume()
    }
    
    //  Retrieve a list of the games since the last database update
    func retrieveLatestGameScheduleInfo(completion: @escaping ([ScheduledGame]) -> ())
    {
        print("\n\nIn NetworkManager.retrieveLatestGameScheduleInfo method...\n\n")
        
        print("Last date played value is \(databaseManager.getLatestDatePlayed())")

        guard let dateCreated = TimeAndDateUtils.getDate(fromString: databaseManager.getLatestDatePlayed(), dateFormat: Constants.LONG_DATE_FORMAT) else { return }

        if(dateCreated >= Date())
        {
            return
        }

        let dateRange = TimeAndDateUtils.createUpdateDateStringInWebServiceFormat(from: dateCreated)

        session.dataTask(with: createRequest(urlHelper.retrieveLatestScheduleInfoURL(dateRange)))
        {
            data, response, err in
            
            if err != nil
            {
                fatalError(err!.localizedDescription)
            }
            else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200
            {
                let seasonSchedule = try! JSONDecoder().decode(SeasonSchedule.self, from: data)
                
                self.databaseManager.saveScheduledGameData(seasonSchedule)
                
                DispatchQueue.main.async
                {
                    completion(seasonSchedule.gameList)
                }
            }
        }.resume()
    }
    
    func retrieveScheduleForDate(_ date :Date, completion: @escaping ([ScheduledGame]) -> ())
    {
        print("\n\nIn NetworkManager.retrieveScheduleForDate method...\n\n")
        
        let shortDateFormatter = DateFormatter()
        
        shortDateFormatter.dateFormat = Constants.SHORT_DATE_FORMAT
        
        let scheduleDate = shortDateFormatter.string(from: date)
        
        session.dataTask(with: createRequest(urlHelper.retrieveScheduleForDateURL(scheduleDate)))
        {
            data, response, err in
            
            if err != nil
            {
                print("\n\n\(err!.localizedDescription)\n\n")
                fatalError(err!.localizedDescription)
            }
            else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200
            {
                let seasonSchedule = try! JSONDecoder().decode(SeasonSchedule.self, from: data)
                
                self.databaseManager.saveScheduledGameData(seasonSchedule)
                
                DispatchQueue.main.async
                {
                    completion(seasonSchedule.gameList)
                }
            }
        }.resume()
    }
    
    func loadPlayerStats()
    {
        print("\n\nIn NetworkManager.loadPlayerStats method...\n\n")
        
        session.dataTask(with: createRequest(urlHelper.retrievePlayerStatsURL()))
        {
            data, response, err in
            
            if err != nil
            {
                fatalError(err!.localizedDescription)
            }
            else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200
            {
                let playerStats = try? JSONDecoder().decode(PlayerStats.self, from: data)
                
                self.databaseManager.savePlayerStats(playerStats ?? PlayerStats())
            }
        }.resume()
    }
    
    //  Return a request populated with the URL and authorization information
    private func createRequest(_ urlString: String) -> URLRequest
    {
        let url = URL(string: urlString)
        
        var request = URLRequest(url: url!)
        
        request.addValue(Constants.AUTHORIZATION_VALUE + Constants.USER_ID.toBase64()!, forHTTPHeaderField: Constants.AUTHORIZATION)
        
        return request
    }
}
