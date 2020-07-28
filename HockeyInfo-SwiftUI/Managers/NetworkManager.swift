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
    //func retrieveFullSeasonSchedule(completion: @escaping ([NHLSchedule]) -> ())
    func retrieveFullSeasonSchedule()
    {
        print("\nIn NetworkManager.retrieveFullSeasonSchedule method...")
        
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
                
//                DispatchQueue.main.async
//                {
//                    print("\nCalling completionhandler in NetworkManager.retrieveFullSeasonSchedule method...")
//                    
//                    completion(scheduledGames)
//                }
            }
        }.resume()
    }
    
    //func retrieveStandings(completion: @escaping ([TeamStandings]) -> ())
    func retrieveStandings()
    {
        print("\nIn NetworkManager.retrieveStandings method...")
        
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
                
//                DispatchQueue.main.async
//                {
//                    print("\nCalling completionhandler in NetworkManager.retrieveStandings method...")
//
//                    completion(self.dataExchangeHelper.convertNHLStandingsToTeamStandingsList(nhlStandings))
//                }
            }
        }.resume()
    }
    
    //func retrieveRosterList(completion: @escaping ([NHLPlayer]) -> ())
    func retrieveRosterList()
    {
        print("\nIn NetworkManager.retrieveRosters method...")
        
        if(!databaseManager.playersRequiresLoad())
        {
            print("Players have already been saved to the database...")
            
            return
        }
        
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
                
//                DispatchQueue.main.async
//                {
//                    print("\nCalling completionhandler in NetworkManager.retrieveRosters method...")
//
//                    completion(self.dataExchangeHelper.convertRosterPlayersToNHLPlayerList(rosterPlayers))
//                }
            }
        }.resume()
    }
    
    func retrievePlayerStatisticsDictionary(completion: @escaping ([Int: PlayerStatistics]) -> ())
    {
        print("\nIn NetworkManager.retrievePlayerStatisticsDictionary method...\n\nUsing URL: \(urlHelper.retrievePlayerStatsURL())")
        
        if(!databaseManager.playerStatisticsRequiresLoad())
        {
            print("Player statistics have already been saved to the database...")
            
            return
        }
        
        var playerStatisticsDictionary = [Int: PlayerStatistics]()
        var playerStats = PlayerStats()
        
        session.dataTask(with: createRequest(urlHelper.retrievePlayerStatsURL()))
        {
            data, response, err in
            
            if err != nil
            {
                fatalError(err!.localizedDescription)
            }
            else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200
            {
                print("\nData is: \(data)")
                
                do
                {
                    playerStats = try JSONDecoder().decode(PlayerStats.self, from: data)
                    
                    playerStatisticsDictionary = self.dataExchangeHelper.convertPlayerStatsToPlayerStatisticsDictionary(playerStats.playerStatsTotals)
                    
                    self.databaseManager.savePlayerStats(playerStats)
                }
                catch
                {
                    print(error.localizedDescription)
                }
                
                DispatchQueue.main.async
                {
                    print("\nCalling completionhandler in NetworkManager.retrievePlayerStatisticsDictionary method...")

                    completion(playerStatisticsDictionary)
                }
            }
        }.resume()
    }
    
    func retrievePlayerInjuries(completion: @escaping (PlayerInjuries) -> ())
    {
        print("\nIn NetworkManager.retrievePlayerInjuries method...")
        
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
                        print("\nCalling completionhandler in NetworkManager.retrievePlayerInjuries method...")
                        
                        completion(playerInjuries)
                    }
                }
                else
                {
                    print("\nNo injuries found in NetworkManager.retrievePlayerInjuries method...")
                }
            }
        }.resume()
    }
    
    func retrieveScoringSummary(forGameId gameId: Int, completion: @escaping (ScoringSummary) -> ())
    {
        print("\nIn NetworkManager.retrieveScoringSummary method...")
        
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
                    print("\nCalling completionhandler in NetworkManager.retrieveScoringSummary method...")
                    
                    completion(scoringSummary)
                }
            }
        }.resume()
    }
    
    func retrieveGameLog(completion: @escaping (GameLog) -> ())
    {
        print("\nIn NetworkManager.retrieveGameLog method...")
        
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
                    print("\nCalling completionhandler in NetworkManager.retrieveGameLog method...")
                    
                    completion(gameLog)
                }
            }
        }.resume()
    }
    
    //  Retrieve a list of the games since the last database update
    func retrieveLatestGameScheduleInfo(completion: @escaping ([ScheduledGame]) -> ())
    {
        print("\nIn NetworkManager.retrieveLatestGameScheduleInfo method...")
        
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
                    print("\nCalling completionhandler in NetworkManager.retrieveLatestGameScheduleInfo method...")
                    
                    completion(seasonSchedule.gameList)
                }
            }
        }.resume()
    }
    
    func retrieveScheduleForDate(_ date :Date, completion: @escaping ([ScheduledGame]) -> ())
    {
        print("\nIn NetworkManager.retrieveScheduleForDate method...")
        
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
                    print("\nCalling completionhandler in NetworkManager.retrieveLatestGameScheduleInfo method using \(scheduleDate)...")
                    
                    completion(seasonSchedule.gameList)
                }
            }
        }.resume()
    }
    
    func loadPlayerStats()
    {
        print("\nIn NetworkManager.loadPlayerStats method...")
        
        session.dataTask(with: createRequest(urlHelper.retrievePlayerStatsURL()))
        {
            data, response, err in
            
            if err != nil
            {
                fatalError(err!.localizedDescription)
            }
            else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200
            {
                print("\(data)")
                
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
