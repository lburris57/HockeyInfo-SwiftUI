//
//  DBManager.swift
//  HockeyInfoSwiftUI
//
//  Created by Larry Burris on 7/3/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation
import RealmSwift

class DBManager
{
    let today = Date()
    let season = UserSettings().season
    let seasonType = UserSettings().seasonType
    let userDefaults = UserDefaults.standard
    
    //  Need to update user defaults code
    
    // MARK: Create methods
    
    //  Creates a new Realm schema and saves main menu categories and team information
    func createDatabase()
    {
        print("Season is: \(season)")
        print("Season type is: \(seasonType)")
            
        //saveMainMenuCategories()
        //saveTeams()
    }
    
    //  Returns an a list of populated NHLTeam objects
    func createTeamArray() -> [NHLTeam]
    {
        let teamAbbreviations = Constants.TEAM_ABBREVIATION_ARRAY
        
        var teamArray = [NHLTeam]()
        
        let dateString = TimeAndDateUtils.getCurrentDateAsString()
        
        for teamAbbreviation in teamAbbreviations
        {
            let nhlTeam = NHLTeam()
            
            nhlTeam.id = TeamManager.getIDByTeam(teamAbbreviation)
            nhlTeam.abbreviation = teamAbbreviation
            nhlTeam.city = TeamManager.getTeamCityName(teamAbbreviation)
            nhlTeam.name = TeamManager.getTeamName(teamAbbreviation)
            nhlTeam.division = TeamManager.getDivisionByTeam(teamAbbreviation)
            nhlTeam.conference = TeamManager.getConferenceByTeam(teamAbbreviation)
            nhlTeam.dateCreated = dateString
            nhlTeam.season = self.season
            nhlTeam.seasonType = self.seasonType
            
            teamArray.append(nhlTeam)
        }
        
        return teamArray
    }
    
    // MARK: Save methods
    func saveMainMenuCategories()
    {
        let categories = Constants.CATEGORY_ARRAY
        
        let categoryList = List<MainMenuCategory>()
        
        let dateString = TimeAndDateUtils.getCurrentDateAsString()
        
        var id = 0
        
        for category in categories
        {
            let mainMenuCategory = MainMenuCategory()
            
            mainMenuCategory.id = id
            mainMenuCategory.category = category
            mainMenuCategory.dateCreated = dateString
            
            id = id + 1
            
            categoryList.append(mainMenuCategory)
        }
        
        do
        {
            let realm = try! Realm()
            
            try realm.write
            {
                realm.add(categoryList, update: .modified)
            }
        }
        catch
        {
            print("Error saving main menu categories to the database: \(error.localizedDescription)")
        }
        
        userDefaults.set("Y", forKey: Constants.MENU_CATEGORY_TABLE)
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    func saveTeams()
    {
        let teamArray = createTeamArray()
        
        do
        {
            let realm = try! Realm()
            
            try realm.write
            {
                realm.add(teamArray, update: .modified)
            }
        }
        catch
        {
            print("Error saving teams to the database: \(error.localizedDescription)")
        }
        
        userDefaults.set("Y", forKey: Constants.TEAM_TABLE)
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    func saveFullSeasonScheduleGameData(_ scheduledGames: [NHLSchedule])
    {
        let startTime = Date().timeIntervalSince1970
        
        let dispatchQueue = DispatchQueue(label: "FullSeasonScheduleQueue", qos: .background)
        
        dispatchQueue.async
        {
            do
            {
                let realm = try! Realm()
                
                try realm.write
                {
                    realm.add(scheduledGames, update: .modified)
                }
            }
            catch
            {
                print("Error saving scheduled games to the database: \(error.localizedDescription)")
            }
            
            self.linkSchedulesToTeams()
            
            self.userDefaults.set("Y", forKey: Constants.SCHEDULE_TABLE)
            
            print("\n\nTotal elapsed time to save full season schedule is: \((Date().timeIntervalSince1970 - startTime).rounded()) seconds.\n\n")
            print(Realm.Configuration.defaultConfiguration.fileURL!)
        }
    }
    
    func saveRosters(_ rosterPlayers: RosterPlayers)
    {
        let startTime = Date().timeIntervalSince1970
        
        let playerList = List<NHLPlayer>()
        
        let dispatchQueue = DispatchQueue(label: "PlayerRosterQueue", qos: .background)
        
        dispatchQueue.async
        {
            for playerInfo in rosterPlayers.playerInfoList
            {
                let nhlPlayer = NHLPlayer()
                
                nhlPlayer.dateCreated = TimeAndDateUtils.getCurrentDateAsString()
                nhlPlayer.id = playerInfo.player.id
                nhlPlayer.firstName = playerInfo.player.firstName
                nhlPlayer.lastName = playerInfo.player.lastName
                nhlPlayer.age = String(playerInfo.player.age ?? 0)
                nhlPlayer.birthDate = playerInfo.player.birthDate ?? Constants.EMPTY_STRING
                nhlPlayer.birthCity = playerInfo.player.birthCity ?? Constants.EMPTY_STRING
                nhlPlayer.birthCountry = playerInfo.player.birthCountry ?? Constants.EMPTY_STRING
                nhlPlayer.height = playerInfo.player.height ?? Constants.EMPTY_STRING
                nhlPlayer.weight = String(playerInfo.player.weight ?? 0)
                nhlPlayer.jerseyNumber = String(playerInfo.player.jerseyNumber ?? 0)
                nhlPlayer.imageURL = playerInfo.player.officialImageSource?.absoluteString ?? Constants.EMPTY_STRING
                nhlPlayer.position = playerInfo.player.position ?? Constants.EMPTY_STRING
                nhlPlayer.shoots = playerInfo.player.handednessInfo?.shoots ?? Constants.EMPTY_STRING
                nhlPlayer.teamId = playerInfo.currentTeamInfo?.id ?? 0
                nhlPlayer.teamAbbreviation = playerInfo.currentTeamInfo?.abbreviation ?? Constants.EMPTY_STRING
                nhlPlayer.season = self.season
                nhlPlayer.seasonType = self.seasonType
                
                playerList.append(nhlPlayer)
            }
            
            do
            {
                let realm = try! Realm()
                
                try realm.write
                {
                    realm.add(playerList, update: .modified)
                }
            }
            catch
            {
                print("Error saving roster players to the database: \(error.localizedDescription)")
            }
            self.linkPlayersToTeams()
            self.linkSchedulesToTeams()
            self.linkStatisticsAndInjuriesToPlayers()
            
            self.userDefaults.set("Y", forKey: Constants.PLAYER_TABLE)
            
            print("\n\nTotal elapsed time to save roster players is: \((Date().timeIntervalSince1970 - startTime).rounded()) seconds.\n\n")
            print(Realm.Configuration.defaultConfiguration.fileURL!)
        }
    }
    
    func savePlayerStats(_ playerStats: PlayerStats)
    {
        let startTime = Date().timeIntervalSince1970

        let dispatchQueue = DispatchQueue(label: "PlayerStatsQueue", qos: .background)

        dispatchQueue.async
        {
            let realm = try! Realm()
            
            if let playerResultList: Results<NHLPlayer> = self.retrieveAllPlayers()
            {
                var playerDictionary = [Int:NHLPlayer]()

                //  Create a player dictionary with id as the key
                for player in playerResultList
                {
                    playerDictionary[player.id] = player
                }

                try! realm.write
                {
                    for playerStatsTotal in playerStats.playerStatsTotals
                    {
                        let playerStatistics = PlayerStatistics()
                        let playerId = playerStatsTotal.player.id
                        let nhlPlayer = playerDictionary[playerId]

                        playerStatistics.id = playerId
                        playerStatistics.dateCreated = TimeAndDateUtils.getCurrentDateAsString()
                        playerStatistics.gamesPlayed = playerStatsTotal.playerStats.gamesPlayed
                        playerStatistics.goals = playerStatsTotal.playerStats.scoringData.goals
                        playerStatistics.assists = playerStatsTotal.playerStats.scoringData.assists
                        playerStatistics.points = playerStatsTotal.playerStats.scoringData.points
                        playerStatistics.hatTricks = playerStatsTotal.playerStats.scoringData.hatTricks
                        playerStatistics.powerplayGoals = playerStatsTotal.playerStats.scoringData.powerplayGoals
                        playerStatistics.powerplayAssists = playerStatsTotal.playerStats.scoringData.powerplayAssists
                        playerStatistics.powerplayPoints = playerStatsTotal.playerStats.scoringData.powerplayPoints
                        playerStatistics.shortHandedGoals = playerStatsTotal.playerStats.scoringData.shorthandedGoals
                        playerStatistics.shortHandedAssists = playerStatsTotal.playerStats.scoringData.shorthandedAssists
                        playerStatistics.shortHandedPoints = playerStatsTotal.playerStats.scoringData.shorthandedPoints
                        playerStatistics.gameWinningGoals = playerStatsTotal.playerStats.scoringData.gameWinningGoals
                        playerStatistics.gameTyingGoals = playerStatsTotal.playerStats.scoringData.gameTyingGoals
                        playerStatistics.plusMinus = playerStatsTotal.playerStats.skatingData?.plusMinus ?? 0
                        playerStatistics.shots = playerStatsTotal.playerStats.skatingData?.shots ?? 0
                        playerStatistics.shotPercentage = playerStatsTotal.playerStats.skatingData?.shotPercentage ?? 0.0
                        playerStatistics.blockedShots = playerStatsTotal.playerStats.skatingData?.blockedShots ?? 0
                        playerStatistics.hits = playerStatsTotal.playerStats.skatingData?.hits ?? 0
                        playerStatistics.faceoffs = playerStatsTotal.playerStats.skatingData?.faceoffs ?? 0
                        playerStatistics.faceoffWins = playerStatsTotal.playerStats.skatingData?.faceoffWins ?? 0
                        playerStatistics.faceoffLosses = playerStatsTotal.playerStats.skatingData?.faceoffLosses ?? 0
                        playerStatistics.faceoffPercent = playerStatsTotal.playerStats.skatingData?.faceoffPercent ?? 0.0
                        playerStatistics.penalties = playerStatsTotal.playerStats.penaltyData.penalties
                        playerStatistics.penaltyMinutes = playerStatsTotal.playerStats.penaltyData.penaltyMinutes
                        playerStatistics.wins = playerStatsTotal.playerStats.goaltendingData?.wins ?? 0
                        playerStatistics.losses = playerStatsTotal.playerStats.goaltendingData?.losses ?? 0
                        playerStatistics.overtimeWins = playerStatsTotal.playerStats.goaltendingData?.overtimeWins ?? 0
                        playerStatistics.overtimeLosses = playerStatsTotal.playerStats.goaltendingData?.overtimeLosses ?? 0
                        playerStatistics.goalsAgainst = playerStatsTotal.playerStats.goaltendingData?.goalsAgainst ?? 0
                        playerStatistics.shotsAgainst = playerStatsTotal.playerStats.goaltendingData?.shotsAgainst ?? 0
                        playerStatistics.saves = playerStatsTotal.playerStats.goaltendingData?.saves ?? 0
                        playerStatistics.goalsAgainstAverage = playerStatsTotal.playerStats.goaltendingData?.goalsAgainstAverage ?? 0.0
                        playerStatistics.savePercentage = playerStatsTotal.playerStats.goaltendingData?.savePercentage ?? 0.0
                        playerStatistics.shutouts = playerStatsTotal.playerStats.goaltendingData?.shutouts ?? 0
                        playerStatistics.gamesStarted = playerStatsTotal.playerStats.goaltendingData?.gamesStarted ?? 0
                        playerStatistics.creditForGame = playerStatsTotal.playerStats.goaltendingData?.creditForGame ?? 0
                        playerStatistics.minutesPlayed = playerStatsTotal.playerStats.goaltendingData?.minutesPlayed ?? 0
                        playerStatistics.season = self.season
                        playerStatistics.seasonType = self.seasonType

                        realm.create(PlayerStatistics.self, value: playerStatistics, update: .modified)

                        //  Get the playerStatistics reference from the database
                        if let realmPlayerStatistics = realm.object(ofType: PlayerStatistics.self, forPrimaryKey: playerId)
                        {
                            nhlPlayer?.playerStatisticsList.append(realmPlayerStatistics)
                        }
                    }
                }
            }
            else
            {
                print("Player statistics were NOT saved because there were no players found in the database for \(self.season)/\(self.seasonType)")
            }

            self.userDefaults.set("Y", forKey: Constants.PLAYER_STATISTICS_TABLE)
            
            print("\n\nTotal elapsed time to save player stats is: \((Date().timeIntervalSince1970 - startTime).rounded()) seconds.\n\n")
            print(Realm.Configuration.defaultConfiguration.fileURL!)
        }
    }
    
    func saveStandings(_ nhlStandings: NHLStandings)
    {
        let startTime = Date().timeIntervalSince1970
        
        let teamStandingsList = List<TeamStandings>()
        let teamStatisticsList = List<TeamStatistics>()
        let teamList = List<NHLTeam>()
        
        let dispatchQueue = DispatchQueue(label: "PlayerStandingsQueue", qos: .background)
        
        dispatchQueue.async
        {
            let realm = try! Realm()
            
            for teamStandingsData in nhlStandings.teamList
            {
                let teamStandings = TeamStandings()
                let teamStatistics = TeamStatistics()
                let nhlTeam = NHLTeam()
                
                //  Populate the Team Standings table
                teamStandings.id = teamStandingsData.teamInformation.id
                teamStandings.abbreviation = teamStandingsData.teamInformation.abbreviation
                teamStandings.division = teamStandingsData.divisionRankInfo.divisionName
                teamStandings.divisionRank = teamStandingsData.divisionRankInfo.rank
                teamStandings.conference = teamStandingsData.conferenceRankInfo.conferenceName
                teamStandings.conferenceRank = teamStandingsData.conferenceRankInfo.rank
                teamStandings.gamesPlayed = teamStandingsData.teamStats.gamesPlayed
                teamStandings.wins = teamStandingsData.teamStats.standingsInfo.wins
                teamStandings.losses = teamStandingsData.teamStats.standingsInfo.losses
                teamStandings.overtimeLosses = teamStandingsData.teamStats.standingsInfo.overtimeLosses
                teamStandings.points = teamStandingsData.teamStats.standingsInfo.points
                teamStandings.dateCreated = TimeAndDateUtils.getCurrentDateAsString()
                teamStandings.season = self.season
                teamStandings.seasonType = self.seasonType
                
                //  Populate the Team Statistics table
                teamStatistics.id = teamStandingsData.teamInformation.id
                teamStatistics.abbreviation = teamStandingsData.teamInformation.abbreviation
                teamStatistics.gamesPlayed = teamStandingsData.teamStats.gamesPlayed
                teamStatistics.wins = teamStandingsData.teamStats.standingsInfo.wins
                teamStatistics.losses = teamStandingsData.teamStats.standingsInfo.losses
                teamStatistics.overtimeLosses = teamStandingsData.teamStats.standingsInfo.overtimeLosses
                teamStatistics.points = teamStandingsData.teamStats.standingsInfo.points
                teamStatistics.powerplays = teamStandingsData.teamStats.powerplayInfo.powerplays
                teamStatistics.powerplayGoals = teamStandingsData.teamStats.powerplayInfo.powerplayGoals
                teamStatistics.powerplayPercent = teamStandingsData.teamStats.powerplayInfo.powerplayPercent
                teamStatistics.penaltyKills = teamStandingsData.teamStats.powerplayInfo.penaltyKills
                teamStatistics.penaltyKillGoalsAllowed = teamStandingsData.teamStats.powerplayInfo.penaltyKillGoalsAllowed
                teamStatistics.penaltyKillPercent = teamStandingsData.teamStats.powerplayInfo.penaltyKillPercent
                teamStatistics.goalsFor = teamStandingsData.teamStats.miscellaneousInfo.goalsFor
                teamStatistics.goalsAgainst = teamStandingsData.teamStats.miscellaneousInfo.goalsAgainst
                teamStatistics.shots = teamStandingsData.teamStats.miscellaneousInfo.shots
                teamStatistics.penalties = teamStandingsData.teamStats.miscellaneousInfo.penalties
                teamStatistics.penaltyMinutes = teamStandingsData.teamStats.miscellaneousInfo.penaltyMinutes
                teamStatistics.hits = teamStandingsData.teamStats.miscellaneousInfo.hits
                teamStatistics.faceoffWins = teamStandingsData.teamStats.faceoffInfo.faceoffWins
                teamStatistics.faceoffLosses = teamStandingsData.teamStats.faceoffInfo.faceoffLosses
                teamStatistics.faceoffPercent = teamStandingsData.teamStats.faceoffInfo.faceoffPercent
                teamStatistics.dateCreated = TimeAndDateUtils.getCurrentDateAsString()
                teamStatistics.season = self.season
                teamStatistics.seasonType = self.seasonType
                
                //  Populate the NHLTeam table
                nhlTeam.dateCreated = TimeAndDateUtils.getCurrentDateAsString()
                nhlTeam.id = teamStandingsData.teamInformation.id
                nhlTeam.abbreviation = teamStandingsData.teamInformation.abbreviation
                nhlTeam.city = teamStandingsData.teamInformation.city
                nhlTeam.name = teamStandingsData.teamInformation.name
                nhlTeam.division = teamStandingsData.divisionRankInfo.divisionName
                nhlTeam.conference = teamStandingsData.conferenceRankInfo.conferenceName
                nhlTeam.season = self.season
                nhlTeam.seasonType = self.seasonType
                
                teamStandingsList.append(teamStandings)
                teamStatisticsList.append(teamStatistics)
                teamList.append(nhlTeam)
            }
            
            do
            {
                try realm.write
                {
                    realm.add(teamList, update: .modified)
                    realm.add(teamStatisticsList, update: .modified)
                    realm.add(teamStandingsList, update: .modified)
                }
            }
            catch
            {
                print("Error saving team data to the database: \(error.localizedDescription)")
            }
            
            self.linkStandingsToTeams()
            self.linkStatisticsToTeams()
            
            self.userDefaults.set("Y", forKey: Constants.TEAM_STANDINGS_TABLE)
            
            print("\n\nTotal elapsed time to save team standings data is: \((Date().timeIntervalSince1970 - startTime).rounded()) seconds.\n\n")
            print(Realm.Configuration.defaultConfiguration.fileURL!)
        }
    }
    
    func savePlayerInjuries(_ playerInjuries: PlayerInjuries)
    {
        let startTime = Date().timeIntervalSince1970
        
        let dispatchQueue = DispatchQueue(label: "PlayerInjuriesQueue", qos: .background)
        
        dispatchQueue.async
        {
            let realm = try! Realm()
            
            if let playerResultList: Results<NHLPlayer> = self.retrieveAllPlayers()
            {
                var playerDictionary = [Int:NHLPlayer]()
                
                //  Create a player dictionary with id as the key
                for player in playerResultList
                {
                    playerDictionary[player.id] = player
                }
            
                try! realm.write
                {
                    //  Delete any existing records in the injury table so that only players who are currently injured are loaded
                    realm.delete(realm.objects(NHLPlayerInjury.self))
                    
                    for playerInfo in playerInjuries.playerInfoList
                    {
                        let playerInjury = NHLPlayerInjury()
                        let playerId = playerInfo.id
                        let nhlPlayer = playerDictionary[playerId]
                        
                        playerInjury.id = playerId
                        playerInjury.dateCreated = TimeAndDateUtils.getCurrentDateAsString()
                        playerInjury.teamId = playerInfo.currentTeamInfo.id
                        playerInjury.teamAbbreviation = playerInfo.currentTeamInfo.abbreviation
                        playerInjury.firstName = playerInfo.firstName
                        playerInjury.lastName = playerInfo.lastName
                        playerInjury.position = playerInfo.position
                        playerInjury.jerseyNumber = String(playerInfo.jerseyNumber)
                        playerInjury.injuryDescription = playerInfo.currentInjuryInfo.description
                        playerInjury.playingProbablity = playerInfo.currentInjuryInfo.playingProbability
                        playerInjury.season = self.season
                        playerInjury.seasonType = self.seasonType
                        
                        realm.create(NHLPlayerInjury.self, value: playerInjury, update: .modified)
                        
                        //  Get the playerInjury reference from the database and save it to the player
                        if let realmPlayerInjury = realm.object(ofType: NHLPlayerInjury.self, forPrimaryKey: playerId)
                        {
                            nhlPlayer?.playerInjuries.append(realmPlayerInjury)
                        }
                    }
                }
                
                self.linkPlayerInjuriesToTeams()
            }
            else
            {
                print("Player statistics were NOT saved because there were no players found in the database for \(self.season)/\(self.seasonType)")
            }
            
            self.userDefaults.set("Y", forKey: Constants.PLAYER_INJURY_TABLE)
            
            print("\n\nTotal elapsed time to save player injury data is: \((Date().timeIntervalSince1970 - startTime).rounded()) seconds.\n\n")
            print(Realm.Configuration.defaultConfiguration.fileURL!)
        }
    }
    
    func saveGameLog(_ gameLog: GameLog)
    {
        let startTime = Date().timeIntervalSince1970
        
        let lastUpdatedOn = gameLog.lastUpdatedOn
        
        var gameLogDictionary = [Int:NHLGameLog]()
        
        var gameLogList = [NHLGameLog]()
        
        let dispatchQueue = DispatchQueue(label: "GameLogsQueue", qos: .background)
        
        dispatchQueue.async
        {
            let realm = try! Realm()
            
            try! realm.write
            {
                for gameLogData in gameLog.gameLogDataList
                {
                    var nhlGameLog: NHLGameLog
                    
                    var found = false
                    
                    let gameId = gameLogData.game.id
                    let teamAbbreviation = gameLogData.team.abbreviation
                    
                    //  If game id is found in the dictionary, update that object,
                    //  otherwise, create a new one to be inserted
                    if gameLogDictionary.keys.contains(gameId)
                    {
                        found = true
                        
                        nhlGameLog = gameLogDictionary[gameId]!
                    }
                    else
                    {
                        nhlGameLog = NHLGameLog()
                        nhlGameLog.id = gameId
                    }
                    
                    let timeString = gameLogData.game.startTime
                    
                    nhlGameLog.dateCreated = TimeAndDateUtils.getCurrentDateAsString()
                    nhlGameLog.lastUpdatedOn = lastUpdatedOn
                    nhlGameLog.date = TimeAndDateUtils.getDate(timeString)
                    nhlGameLog.time = TimeAndDateUtils.getTime(timeString)
                    nhlGameLog.playedStatus = PlayedStatusEnum.completed.rawValue
                    nhlGameLog.season = self.season
                    nhlGameLog.seasonType = self.seasonType
                    
                    //  If the game log is the home team, update the home team information,
                    //  otherwise, update the away team information
                    if gameLogData.game.homeTeamAbbreviation == teamAbbreviation
                    {
                        nhlGameLog.homeTeamId = gameLogData.team.id
                        nhlGameLog.homeTeamAbbreviation = gameLogData.game.homeTeamAbbreviation
                        nhlGameLog.homeWins = gameLogData.stats.standings.wins
                        nhlGameLog.homeLosses = gameLogData.stats.standings.losses
                        nhlGameLog.homeOvertimeWins = gameLogData.stats.standings.overtimeWins
                        nhlGameLog.homeOvertimeLosses = gameLogData.stats.standings.overtimeLosses
                        nhlGameLog.homePoints = gameLogData.stats.standings.points
                        nhlGameLog.homeFaceoffWins = gameLogData.stats.faceoffs.faceoffWins
                        nhlGameLog.homeFaceoffLosses = gameLogData.stats.faceoffs.faceoffLosses
                        nhlGameLog.homeFaceoffPercent = gameLogData.stats.faceoffs.faceoffPercent
                        nhlGameLog.homePowerplays = gameLogData.stats.powerplay.powerplays
                        nhlGameLog.homePowerplayGoals = gameLogData.stats.powerplay.powerplayGoals
                        nhlGameLog.homePowerplayPercent = gameLogData.stats.powerplay.powerplayPercent
                        nhlGameLog.homePenaltyKills = gameLogData.stats.powerplay.penaltyKills
                        nhlGameLog.homePenaltyKillGoalsAllowed = gameLogData.stats.powerplay.penaltyKillGoalsAllowed
                        nhlGameLog.homePenaltyKillPercent = gameLogData.stats.powerplay.penaltyKillPercent
                        nhlGameLog.homeGoalsFor = gameLogData.stats.miscellaneous.goalsFor
                        nhlGameLog.homeGoalsAgainst = gameLogData.stats.miscellaneous.goalsAgainst
                        nhlGameLog.homeShots = gameLogData.stats.miscellaneous.shots
                        nhlGameLog.homePenalties = gameLogData.stats.miscellaneous.penalties
                        nhlGameLog.homePenaltyMinutes = gameLogData.stats.miscellaneous.penaltyMinutes
                        nhlGameLog.homeHits = gameLogData.stats.miscellaneous.hits
                    }
                    else if gameLogData.game.awayTeamAbbreviation == teamAbbreviation
                    {
                        nhlGameLog.awayTeamId = gameLogData.team.id
                        nhlGameLog.awayTeamAbbreviation = gameLogData.game.awayTeamAbbreviation
                        nhlGameLog.awayWins = gameLogData.stats.standings.wins
                        nhlGameLog.awayLosses = gameLogData.stats.standings.losses
                        nhlGameLog.awayOvertimeWins = gameLogData.stats.standings.overtimeWins
                        nhlGameLog.awayOvertimeLosses = gameLogData.stats.standings.overtimeLosses
                        nhlGameLog.awayPoints = gameLogData.stats.standings.points
                        nhlGameLog.awayFaceoffWins = gameLogData.stats.faceoffs.faceoffWins
                        nhlGameLog.awayFaceoffLosses = gameLogData.stats.faceoffs.faceoffLosses
                        nhlGameLog.awayFaceoffPercent = gameLogData.stats.faceoffs.faceoffPercent
                        nhlGameLog.awayPowerplays = gameLogData.stats.powerplay.powerplays
                        nhlGameLog.awayPowerplayGoals = gameLogData.stats.powerplay.powerplayGoals
                        nhlGameLog.awayPowerplayPercent = gameLogData.stats.powerplay.powerplayPercent
                        nhlGameLog.awayPenaltyKills = gameLogData.stats.powerplay.penaltyKills
                        nhlGameLog.awayPenaltyKillGoalsAllowed = gameLogData.stats.powerplay.penaltyKillGoalsAllowed
                        nhlGameLog.awayPenaltyKillPercent = gameLogData.stats.powerplay.penaltyKillPercent
                        nhlGameLog.awayGoalsFor = gameLogData.stats.miscellaneous.goalsFor
                        nhlGameLog.awayGoalsAgainst = gameLogData.stats.miscellaneous.goalsAgainst
                        nhlGameLog.awayShots = gameLogData.stats.miscellaneous.shots
                        nhlGameLog.awayPenalties = gameLogData.stats.miscellaneous.penalties
                        nhlGameLog.awayPenaltyMinutes = gameLogData.stats.miscellaneous.penaltyMinutes
                        nhlGameLog.awayHits = gameLogData.stats.miscellaneous.hits
                    }
                    
                    //  If object was not found, add the created object to the dictionary
                    if !found
                    {
                        gameLogDictionary[gameId] = nhlGameLog
                    }
                    
                    //  Add the game log to the gameLogList
                    gameLogList.append(nhlGameLog)
                }
                
                realm.add(gameLogList, update: .modified)
            }
            
            self.linkGameLogsToTeams()
            
            self.userDefaults.set("Y", forKey: Constants.GAME_LOG_TABLE)
            
            print("\n\nTotal elapsed time to save game log data is: \((Date().timeIntervalSince1970 - startTime).rounded()) seconds.\n\n")
            print(Realm.Configuration.defaultConfiguration.fileURL!)
        }
    }
    
    func saveScoringSummary(_ scoringSummary: ScoringSummary)
    {
        let startTime = Date().timeIntervalSince1970
        
        let nhlScoringSummary = NHLScoringSummary()
        
        let gameId = scoringSummary.game.id
        
        var maxValue = 0
        
        let dispatchQueue = DispatchQueue(label: "ScoringSummaryQueue", qos: .background)
        
        dispatchQueue.async
        {
            let realm = try! Realm()
            
            nhlScoringSummary.dateCreated = TimeAndDateUtils.getCurrentDateAsString()
            nhlScoringSummary.id = gameId
            nhlScoringSummary.gameId = gameId
            nhlScoringSummary.playedStatus = scoringSummary.game.playedStatus
            nhlScoringSummary.homeTeamAbbreviation = scoringSummary.game.homeTeam.abbreviation
            nhlScoringSummary.awayTeamAbbreviation = scoringSummary.game.awayTeam.abbreviation
            nhlScoringSummary.homeScoreTotal = scoringSummary.scoringInfo.homeScoreTotal
            nhlScoringSummary.awayScoreTotal = scoringSummary.scoringInfo.awayScoreTotal
            nhlScoringSummary.numberOfPeriods = scoringSummary.scoringInfo.periodList.count
            nhlScoringSummary.season = self.season
            nhlScoringSummary.seasonType = self.seasonType
            
            do
            {
                try realm.write
                {
                    realm.add(nhlScoringSummary, update: .modified)
                }
            }
            catch
            {
                print("Error saving period scoring data to the database: \(error.localizedDescription)")
            }
            
            do
            {
                try realm.write
                {
                    let realmNHLPeriodScoringSummary = realm.object(ofType: NHLScoringSummary.self, forPrimaryKey: nhlScoringSummary.id)
                    
                    maxValue = realm.objects(NHLPeriodScoringData.self).max(ofProperty: "id") as Int? ?? 0
                    
                    for periodScoringData in scoringSummary.scoringInfo.periodList
                    {
                        for scoringPlay in periodScoringData.scoringPlays
                        {
                            let nhlPeriodScoringData = NHLPeriodScoringData()
                            
                            nhlPeriodScoringData.dateCreated = TimeAndDateUtils.getCurrentDateAsString()
                            nhlPeriodScoringData.id = maxValue + 1
                            nhlPeriodScoringData.gameId = gameId
                            nhlPeriodScoringData.periodNumber = periodScoringData.periodNumber
                            nhlPeriodScoringData.teamAbbreviation = scoringPlay.team.abbreviation
                            nhlPeriodScoringData.periodSecondsElapsed = scoringPlay.periodSecondsElapsed
                            nhlPeriodScoringData.playDescription = scoringPlay.playDescription
                            nhlPeriodScoringData.season = self.season
                            nhlPeriodScoringData.seasonType = self.seasonType
                            
                            maxValue += 1
                            
                            realm.create(NHLPeriodScoringData.self, value: nhlPeriodScoringData, update: .modified)
                            
                            //  Get the playerStatistics reference from the database
                            if let realmNHLPeriodScoringData = realm.object(ofType: NHLPeriodScoringData.self, forPrimaryKey: nhlPeriodScoringData.id)
                            {
                                realmNHLPeriodScoringSummary?.periodScoringList.append(realmNHLPeriodScoringData)
                            }
                        }
                    }
                }
            }
            catch
            {
                print("Error saving period scoring data to the database: \(error.localizedDescription)")
            }
            
            self.userDefaults.set("Y", forKey: Constants.SCORING_SUMMARY_TABLE)
            
            print("\n\nTotal elapsed time to save scoring summary for gameId \(scoringSummary.game.id) is: \((Date().timeIntervalSince1970 - startTime).rounded()) seconds.\n\n")
            print(Realm.Configuration.defaultConfiguration.fileURL!)
        }
    }
    
    func saveScheduledGameData(_ seasonSchedule: SeasonSchedule)
    {
        let startTime = Date().timeIntervalSince1970
        
        let scheduledGames = List<NHLSchedule>()
        
        let lastUpdatedOn = seasonSchedule.lastUpdatedOn
        
        let dispatchQueue = DispatchQueue(label: "ScheduledGameQueue", qos: .background)
        
        dispatchQueue.async
        {
            let realm = try! Realm()
            
            for scheduledGame in seasonSchedule.gameList
            {
                let nhlSchedule = NHLSchedule()
                
                let startTime = scheduledGame.scheduleInfo.startTime
                
                nhlSchedule.id = scheduledGame.scheduleInfo.id
                nhlSchedule.dateCreated = TimeAndDateUtils.getCurrentDateAsString()
                nhlSchedule.lastUpdatedOn = "\(TimeAndDateUtils.getDate(lastUpdatedOn)) at \(TimeAndDateUtils.getTime(lastUpdatedOn))"
                nhlSchedule.date = TimeAndDateUtils.getDate(startTime)
                nhlSchedule.time = TimeAndDateUtils.getTime(startTime)
                nhlSchedule.homeTeam = scheduledGame.scheduleInfo.homeTeamInfo.abbreviation
                nhlSchedule.awayTeam = scheduledGame.scheduleInfo.awayTeamInfo.abbreviation
                nhlSchedule.homeScoreTotal = scheduledGame.scoreInfo.homeScoreTotal ?? 0
                nhlSchedule.awayScoreTotal = scheduledGame.scoreInfo.awayScoreTotal ?? 0
                nhlSchedule.homeShotsTotal = scheduledGame.scoreInfo.homeShotsTotal ?? 0
                nhlSchedule.awayShotsTotal = scheduledGame.scoreInfo.awayShotsTotal ?? 0
                nhlSchedule.playedStatus = scheduledGame.scheduleInfo.playedStatus
                nhlSchedule.scheduleStatus = scheduledGame.scheduleInfo.scheduleStatus
                nhlSchedule.numberOfPeriods = scheduledGame.scoreInfo.periodList?.count ?? 0
                nhlSchedule.currentPeriod = scheduledGame.scoreInfo.currentPeriod ?? 0
                nhlSchedule.currentTimeRemaining = scheduledGame.scoreInfo.currentPeriodSecondsRemaining ?? 0
                nhlSchedule.season = self.season
                nhlSchedule.seasonType = self.seasonType
                
                scheduledGames.append(nhlSchedule)
            }
            
            do
            {
                try realm.write
                {
                    realm.add(scheduledGames, update: .modified)
                }
            }
            catch
            {
                print("Error saving scheduled games data to the database: \(error.localizedDescription)")
            }
            
            self.userDefaults.set("Y", forKey: Constants.SCHEDULE_TABLE)
            
            print("\n\nTotal elapsed time to save scheduled games data is: \((Date().timeIntervalSince1970 - startTime).rounded()) seconds.\n\n")
            print(Realm.Configuration.defaultConfiguration.fileURL!)
        }
    }
    
    // MARK: Retrieve methods
    
    //  Returns a populated list of all players for the season/type settings
    func retrieveAllPlayers() -> Results<NHLPlayer>?
    {
        var rosterResult: Results<NHLPlayer>?
        
        do
        {
            let realm = try! Realm()
            
            try realm.write
            {
                rosterResult = realm.objects(NHLPlayer.self).filter("season =='\(season)' AND seasonType =='\(seasonType)'")
            }
        }
        catch
        {
            print("Error retrieving roster: \(error.localizedDescription)")
        }
        
        return rosterResult
    }
    
    //  Returns a populated list of all teams for the season/type settings
    func retrieveAllTeams() -> Results<NHLTeam>?
    {
        var teamResult: Results<NHLTeam>?
        
        do
        {
            let realm = try! Realm()
            
            try realm.write
            {
                teamResult = realm.objects(NHLTeam.self).filter("season =='\(season)' AND seasonType =='\(seasonType)'")
            }
        }
        catch
        {
            print("Error retrieving teams: \(error.localizedDescription)")
        }
        
        return teamResult
    }
    
    // MARK: Link methods
    func linkStatisticsAndInjuriesToPlayers()
    {
        let realm = try! Realm()
        
        //  Get all the players
        let playerResults = realm.objects(NHLPlayer.self).filter("season =='\(season)' AND seasonType =='\(seasonType)'")
        
        if(playerResults[0].playerStatisticsList.count > 0)
        {
            return
        }
        
        //  Spin through the player and retrieve the statistics based on the player id
        for player in playerResults
        {
            do
            {
                try realm.write
                {
                    //  Get all statistics for that particular player
                    let statisticsResults = realm.objects(PlayerStatistics.self).filter("id ==\(player.id) AND season =='\(season)' AND seasonType =='\(seasonType)'")
                    
                    for statistics in statisticsResults
                    {
                        //  Set the statistics in the parent player
                        player.playerStatisticsList.append(statistics)
                    }
                    
                    //  Get all injuries for that particular player
                    let injuryResults = realm.objects(NHLPlayerInjury.self).filter("id ==\(player.id) AND season =='\(season)' AND seasonType =='\(seasonType)'")
                    
                    for injury in injuryResults
                    {
                        //  Set the injuries in the parent player
                        player.playerInjuries.append(injury)
                    }
                    
                    //  Save the player to the database
                    realm.add(player)
                }
            }
            catch
            {
                print("Error linking statistics and injuries to players: \(error.localizedDescription)")
            }
        }
    }
    
    func linkPlayersToTeams()
    {
        let realm = try! Realm()
        
        //  Get all the teams
        let teamResults = realm.objects(NHLTeam.self).filter("season =='\(season)' AND seasonType =='\(seasonType)'")
        
        if(teamResults[0].players.count > 0)
        {
            return
        }
        
        //  Spin through the teams and retrieve the players based on the team id and season/type
        for team in teamResults
        {
            do
            {
                try realm.write
                {
                    //  Get all players for that particular team
                    let playerResults = realm.objects(NHLPlayer.self).filter("teamId ==\(team.id) AND season =='\(season)' AND seasonType =='\(seasonType)'")
                    
                    for player in playerResults
                    {
                        //  Set the players in the parent team
                        team.players.append(player)
                    }
                    
                    //  Save the team to the database
                    realm.add(team)
                }
            }
            catch
            {
                print("Error saving teams to the database: \(error.localizedDescription)")
            }
        }
    }
    
    func linkStandingsToTeams()
    {
        let realm = try! Realm()
        
        //  Get all the teams
        let teamResults = realm.objects(NHLTeam.self).filter("season =='\(season)' AND seasonType =='\(seasonType)'")
        
        if(teamResults[0].standings.count > 0)
        {
            return
        }
        
        //  Spin through the teams and retrieve the standings based on the team abbreviation
        for team in teamResults
        {
            do
            {
                try realm.write
                {
                    //  Get all standings for that particular team
                    let standingsResults = realm.objects(TeamStandings.self).filter("abbreviation =='\(team.abbreviation)' AND season =='\(season)' AND seasonType =='\(seasonType)'")
                    
                    for standings in standingsResults
                    {
                        //  Set the standings in the parent team
                        team.standings.append(standings)
                    }
                    
                    //  Save the team to the database
                    realm.add(team)
                }
            }
            catch
            {
                print("Error saving teams to the database: \(error.localizedDescription)")
            }
        }
    }
    
    func linkStatisticsToTeams()
    {
        let realm = try! Realm()
        
        //  Get all the teams
        let teamResults = realm.objects(NHLTeam.self).filter("season =='\(season)' AND seasonType =='\(seasonType)'")
        
        if(teamResults[0].statistics.count > 0)
        {
            return
        }
        
        //  Spin through the teams and retrieve the statistics based on the team abbreviation
        for team in teamResults
        {
            do
            {
                try realm.write
                {
                    //  Get all statistics for that particular team
                    let statisticsResults = realm.objects(TeamStatistics.self).filter("abbreviation =='\(team.abbreviation)' AND season =='\(season)' AND seasonType =='\(seasonType)'")
                    
                    for statistics in statisticsResults
                    {
                        //  Set the statistics in the parent team
                        team.statistics.append(statistics)
                    }
                    
                    //  Save the team to the database
                    realm.add(team)
                }
            }
            catch
            {
                print("Error saving teams to the database: \(error.localizedDescription)")
            }
        }
    }
    
    func linkPlayerInjuriesToTeams()
    {
        let realm = try! Realm()
        
        //  Get all the teams
        let teamResults = realm.objects(NHLTeam.self).filter("season =='\(season)' AND seasonType =='\(seasonType)'")
        
        if(teamResults[0].playerInjuries.count > 0)
        {
            return
        }
        
        //  Spin through the teams and retrieve the player injuries based on the team abbreviation
        for team in teamResults
        {
            do
            {
                try realm.write
                {
                    //  Get all player injuries for that particular team
                    let injuryResults = realm.objects(NHLPlayerInjury.self).filter("teamAbbreviation =='\(team.abbreviation)' AND season =='\(season)' AND seasonType =='\(seasonType)'").sorted(byKeyPath: "playingProbablity", ascending: false)
                    
                    for injuries in injuryResults
                    {
                        //  Set the player injuries in the parent team
                        team.playerInjuries.append(injuries)
                    }
                    
                    //  Save the team to the database
                    realm.add(team)
                }
            }
            catch
            {
                print("Error saving teams to the database: \(error.localizedDescription)")
            }
        }
    }
    
    func linkSchedulesToTeams()
    {
        let realm = try! Realm()
        
        //  Get all the teams
        let teamResults = realm.objects(NHLTeam.self).filter("season =='\(season)' AND seasonType =='\(seasonType)'")
        
        if(teamResults[0].schedules.count > 0)
        {
            return
        }
        
        //  Spin through the teams and retrieve the schedules based on the team abbreviation
        for team in teamResults
        {
            do
            {
                try realm.write
                {
                    //  Get all schedules for that particular team
                    let scheduleResults = realm.objects(NHLSchedule.self).filter("homeTeam =='\(team.abbreviation)' OR " + "awayTeam =='\(team.abbreviation)' AND season =='\(season)' AND seasonType =='\(seasonType)'")
                    
                    for schedule in scheduleResults
                    {
                        //  Set the schedule in the parent team
                        team.schedules.append(schedule)
                    }
                    
                    //  Save the team to the database
                    realm.add(team)
                }
            }
            catch
            {
                print("Error saving teams to the database: \(error.localizedDescription)")
            }
        }
    }
    
    func linkGameLogsToTeams()
    {
        let realm = try! Realm()
        
        //  Get all the teams
        let teamResults = realm.objects(NHLTeam.self).filter("season =='\(season)' AND seasonType =='\(seasonType)'")
        
        if(teamResults[0].gameLogs.count > 0)
        {
            return
        }
        
        //  Spin through the teams and retrieve the schedules based on the team abbreviation
        for team in teamResults
        {
            do
            {
                try realm.write
                {
                    //  Get all game logs for that particular team
                    let gameLogResults = realm.objects(NHLGameLog.self).filter("homeTeamAbbreviation =='\(team.abbreviation)' OR " + "awayTeamAbbreviation =='\(team.abbreviation)' AND season =='\(season)' AND seasonType =='\(seasonType)'")
                    
                    for gameLog in gameLogResults
                    {
                        //  Set the gameLog in the parent team
                        team.gameLogs.append(gameLog)
                    }
                    
                    //  Save the team to the database
                    realm.add(team)
                }
            }
            catch
            {
                print("Error saving teams to the database: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: Load/Reload methods
    func loadTeamRecords() -> [String:String]
    {
        let realm = try! Realm()
        
        var records = [String:String]()
        
        do
        {
            try realm.write
            {
                let teamStandings = realm.objects(TeamStandings.self).filter("season =='\(season)' AND seasonType =='\(seasonType)'")
                
                for teamStanding in teamStandings
                {
                    let record = String(teamStanding.wins) + "-" + String(teamStanding.losses) + "-" + String(teamStanding.overtimeLosses)
                    
                    records[teamStanding.abbreviation] = record
                }
            }
        }
        catch
        {
            print("Error loading team records: \(error.localizedDescription)")
        }
        
        return records
    }
    
    func tablesRequireReload() -> Bool
    {
        let realm = try! Realm()
        
        let dateString = TimeAndDateUtils.getCurrentDateAsString()
        
        let playerInjuryResult = realm.objects(NHLPlayerInjury.self).filter("season =='\(season)' AND seasonType =='\(seasonType)'").first
        
        let dateCreated = playerInjuryResult?.dateCreated
        
        if dateString != dateCreated
        {
            return true
        }
        
        return false
    }
    
    func fullScheduleRequiresLoad() -> Bool
    {
        let realm = try! Realm()
        
        let seasonScheduleResult = realm.objects(NHLSchedule.self).filter("season =='\(season)' AND seasonType =='\(seasonType)'").first
        
        return seasonScheduleResult != nil ? false : true
    }
    
    // MARK: Delete methods
    func deleteTeamLinks()
    {
        let realm = try! Realm()
        
        do
        {
            try realm.write
            {
                let teamResults = realm.objects(NHLTeam.self).filter("season =='\(season)' AND seasonType =='\(seasonType)'")
                
                for team in teamResults
                {
                    team.players.removeAll()
                    team.playerInjuries.removeAll()
                    team.standings.removeAll()
                    team.statistics.removeAll()
                    team.schedules.removeAll()
                    team.gameLogs.removeAll()
                    
                    realm.add(team, update: .modified)
                }
            }
        }
        catch
        {
            print("Error deleting team links: \(error.localizedDescription)")
        }
    }
    
    func deleteScoringSummaryData()
    {
        let realm = try! Realm()
        
        do
        {
            try realm.write
            {
                let scoringSummaryResults = realm.objects(NHLScoringSummary.self).filter("season =='\(season)' AND seasonType =='\(seasonType)'")
                let periodScoringDataResults = realm.objects(NHLPeriodScoringData.self).filter("season =='\(season)' AND seasonType =='\(seasonType)'")
                
                realm.delete(scoringSummaryResults)
                realm.delete(periodScoringDataResults)
            }
        }
        catch
        {
            print("Error deleting scoring summary data: \(error.localizedDescription)")
        }
    }
    
    func deletePlayerStatisticsData()
    {
        let realm = try! Realm()
        
        do
        {
            try realm.write
            {
                let playerStatisticsResults = realm.objects(PlayerStatistics.self).filter("season =='\(season)' AND seasonType =='\(seasonType)'")
                
                realm.delete(playerStatisticsResults)
            }
        }
        catch
        {
            print("Error deleting player statistics data: \(error.localizedDescription)")
        }
    }
    
    // MARK: Get latest date methods
    
    //  Returns the latest date played in the schedule table in String format
    func getLatestDatePlayed() -> String
    {
        let realm = try! Realm()
        
        let scheduleResult = realm.objects(NHLSchedule.self).filter("playedStatus == '\(PlayedStatusEnum.completed.rawValue)' AND season =='\(season)' AND seasonType =='\(seasonType)'")
        let sortedScheduleResult = scheduleResult.sorted(byKeyPath: "id", ascending: false)
        
        return sortedScheduleResult[0].date
    }
    
    //  Returns the latest date in the game log table in String format
    func getLatestGameLogDate() -> String
    {
        let realm = try! Realm()
        
        let maxValue =  realm.objects(NHLGameLog.self).filter("season =='\(season)' AND seasonType =='\(seasonType)'").max(ofProperty: "id") as Int?
        let gameLogResult = realm.objects(NHLGameLog.self).filter("id == \(maxValue ?? 0) AND season =='\(season)' AND seasonType =='\(seasonType)'")
        
        return gameLogResult[0].date
    }
    
    // MARK: Retrieve NHL player by name
    func retrievePlayerDetail(_ name: String) -> PlayerDetailModel
    {
        let realm = try! Realm()

        let playerDetailModel = PlayerDetailModel()
        
        let names = name.components(separatedBy: " ")
        
        let firstName = names[0].contains("'") ? ConversionUtils.escapeApostrophe(names[0]) : names[0]
        let lastName = names[1].contains("'") ? ConversionUtils.escapeApostrophe(names[1]) : names[1]
        
        let nhlPlayer = realm.objects(NHLPlayer.self).filter("firstName =='\(firstName)' AND lastName =='\(lastName)' AND season =='\(season)' AND seasonType =='\(seasonType)'")
        
        if let player = nhlPlayer.last
        {
            playerDetailModel.playerId = player.id
            playerDetailModel.firstName = player.firstName
            playerDetailModel.lastName = player.lastName
            playerDetailModel.fullName = player.firstName + " " + player.lastName
            playerDetailModel.position = player.position
            playerDetailModel.jerseyNumber = player.jerseyNumber
            playerDetailModel.height = player.height
            playerDetailModel.weight = player.weight
            playerDetailModel.birthDate = TimeAndDateUtils.formattedYYYYMMDDDateStringToDDMMYYYY(dateString: player.birthDate)! 
            playerDetailModel.age = player.age
            playerDetailModel.birthCity = player.birthCity
            playerDetailModel.birthCountry = player.birthCountry
            playerDetailModel.imageUrl = player.imageURL
            playerDetailModel.shoots = player.shoots != "" ? player.shoots : "N/A"
            playerDetailModel.teamAbbreviation = player.teamAbbreviation
        }
        
        return playerDetailModel
    }
    
    // MARK: Retrieve NHL player statistics by id
    func retrievePlayerStatistics(_ id: Int) -> PlayerStatisticsModel
    {
        let realm = try! Realm()

        let playerStatisticsModel = PlayerStatisticsModel()
        
        print("id ==\(id) AND season =='\(season)' AND seasonType =='\(seasonType)'")
        
        let playerStatistics = realm.objects(PlayerStatistics.self).filter("id ==\(id) AND season =='\(season)' AND seasonType =='\(seasonType)'")
        
        if let playerStatistics = playerStatistics.first
        {
            playerStatisticsModel.id = UUID()
            playerStatisticsModel.playerId = playerStatistics.id
            playerStatisticsModel.gamesPlayed = playerStatistics.gamesPlayed
            playerStatisticsModel.goals = playerStatistics.goals
            playerStatisticsModel.assists = playerStatistics.assists
            playerStatisticsModel.points = playerStatistics.points
            playerStatisticsModel.hatTricks = playerStatistics.hatTricks
            playerStatisticsModel.powerplayGoals = playerStatistics.powerplayGoals
            playerStatisticsModel.powerplayAssists = playerStatistics.powerplayAssists
            playerStatisticsModel.powerplayPoints = playerStatistics.powerplayPoints
            playerStatisticsModel.shortHandedGoals = playerStatistics.shortHandedGoals
            playerStatisticsModel.shortHandedAssists = playerStatistics.shortHandedAssists
            playerStatisticsModel.shortHandedPoints = playerStatistics.shortHandedPoints
            playerStatisticsModel.gameWinningGoals = playerStatistics.gameWinningGoals
            playerStatisticsModel.gameTyingGoals = playerStatistics.gameTyingGoals
            playerStatisticsModel.penalties = playerStatistics.penalties
            playerStatisticsModel.penaltyMinutes = playerStatistics.penaltyMinutes
             
            //  Skater Data
            playerStatisticsModel.plusMinus = playerStatistics.plusMinus
            playerStatisticsModel.shots = playerStatistics.shots
            playerStatisticsModel.shotPercentage = playerStatistics.shotPercentage
            playerStatisticsModel.blockedShots = playerStatistics.blockedShots
            playerStatisticsModel.hits = playerStatistics.hits
            playerStatisticsModel.faceoffs = playerStatistics.faceoffs
            playerStatisticsModel.faceoffWins = playerStatistics.faceoffWins
            playerStatisticsModel.faceoffLosses = playerStatistics.faceoffLosses
            playerStatisticsModel.faceoffPercent = playerStatistics.faceoffPercent
             
            //  Goaltending data
            playerStatisticsModel.wins = playerStatistics.wins
            playerStatisticsModel.losses = playerStatistics.losses
            playerStatisticsModel.overtimeWins = playerStatistics.overtimeWins
            playerStatisticsModel.overtimeLosses = playerStatistics.overtimeLosses
            playerStatisticsModel.goalsAgainst = playerStatistics.goalsAgainst
            playerStatisticsModel.shotsAgainst = playerStatistics.shotsAgainst
            playerStatisticsModel.saves = playerStatistics.saves
            playerStatisticsModel.goalsAgainstAverage = playerStatistics.goalsAgainstAverage
            playerStatisticsModel.savePercentage = playerStatistics.savePercentage
            playerStatisticsModel.shutouts = playerStatistics.shutouts
            playerStatisticsModel.gamesStarted = playerStatistics.gamesStarted
            playerStatisticsModel.creditForGame = playerStatistics.creditForGame
            playerStatisticsModel.minutesPlayed = playerStatistics.minutesPlayed
        }
        
        return playerStatisticsModel
    }
    
    // MARK: Retrieve schedule information for date
    func retrieveScheduledGamesForDate(_ selectedDate: String) -> [ScheduledGameModel]
    {
        let realm = try! Realm()
        
        var scheduledGameList = [ScheduledGameModel]()
        
        let nhlScheduleList = realm.objects(NHLSchedule.self).filter("date == '\(selectedDate)' AND season == '\(season)' AND seasonType == '\(seasonType)'")
        
        for nhlSchedule in nhlScheduleList
        {
            let scheduledGameModel = ScheduledGameModel()
            
            scheduledGameModel.startTime = nhlSchedule.time
            scheduledGameModel.venue = TeamManager.getVenueNameByTeam(nhlSchedule.parentTeam.first?.abbreviation ?? "")
            scheduledGameModel.gameInfo = TeamManager.getFullTeamName(nhlSchedule.awayTeam) + " @ " + TeamManager.getFullTeamName(nhlSchedule.homeTeam)
            
            scheduledGameList.append(scheduledGameModel)
        }
        
        return scheduledGameList
    }
    
    // MARK: Retrieve scoring and goalie leaders
    func retrieveCategoryLeaders(_ category: String) -> [PlayerLeaderModel]
    {
        let realm = try! Realm()

        var playerList = [PlayerLeaderModel]()
        
        let playerStatisticsList = realm.objects(PlayerStatistics.self).filter("season =='\(season)' AND seasonType =='\(seasonType)'").sorted(byKeyPath: category, ascending: false)

        for index in 0..<5
        {
            let playerStatistics = playerStatisticsList[index]
            
            var playerLeaderModel = PlayerLeaderModel()
            
            if let parentPlayer = playerStatistics.parentPlayer.first
            {
                playerLeaderModel.index = index+1
                playerLeaderModel.firstName = parentPlayer.firstName
                playerLeaderModel.lastName = parentPlayer.lastName
                playerLeaderModel.teamAbbreviation = parentPlayer.teamAbbreviation
                playerLeaderModel.imageURL = parentPlayer.imageURL
                playerLeaderModel.season = parentPlayer.season
                playerLeaderModel.seasonType = parentPlayer.seasonType
                
                switch(category)
                {
                    case "points": playerLeaderModel.points = playerStatistics.points
                    case "goals": playerLeaderModel.goals = playerStatistics.goals
                    case "assists": playerLeaderModel.assists = playerStatistics.assists
                    case "plusMinus": playerLeaderModel.plusMinus = playerStatistics.plusMinus
                    default: playerLeaderModel.wins = playerStatistics.wins
                }
                
                playerList.append(playerLeaderModel)
            }
        }
            
        return playerList
    }
    
    func retrieveGoalieCategoryLeaders(_ category: String, _ ascending: Bool) -> [PlayerLeaderModel]
    {
        let realm = try! Realm()
        
        var playerList = [PlayerLeaderModel]()
        var filteredPlayerList = [NHLPlayer]()
        
        let playerStatisticsList = realm.objects(PlayerStatistics.self).filter("season =='\(season)' AND seasonType =='\(seasonType)'").sorted(byKeyPath: category, ascending: ascending)
        
        for playerStats in playerStatisticsList
        {
            if(playerStats.parentPlayer.first?.position == "G" && playerStats.gamesPlayed > 5)
            {
                filteredPlayerList.append(playerStats.parentPlayer.first!)
            }
        }
        
        for index in 0..<5
        {
            let player = filteredPlayerList[index]
            
            var playerLeaderModel = PlayerLeaderModel()
            
            playerLeaderModel.index = index+1
            playerLeaderModel.firstName = player.firstName
            playerLeaderModel.lastName = player.lastName
            playerLeaderModel.teamAbbreviation = player.teamAbbreviation
            playerLeaderModel.imageURL = player.imageURL
            playerLeaderModel.season = player.season
            playerLeaderModel.seasonType = player.seasonType
            
            if(category == "shutouts")
            {
                playerLeaderModel.shutouts = player.playerStatisticsList[0].shutouts
            }
            else if(category == "goalsAgainstAverage")
            {
                playerLeaderModel.goalsAgainstAverage = player.playerStatisticsList[0].goalsAgainstAverage
            }
            else
            {
                playerLeaderModel.savePercentage = player.playerStatisticsList[0].savePercentage
            }
            
            playerList.append(playerLeaderModel)
        }
        
        return playerList
    }
    
    // MARK: Set initial table loaded values in UserDefaults
    func setInitialUserDefaultTableLoadedValues()
    {
        userDefaults.set("N", forKey: Constants.MENU_CATEGORY_TABLE)
        userDefaults.set("N", forKey: Constants.GAME_LOG_TABLE)
        userDefaults.set("N", forKey: Constants.PERIOD_SCORING_DATA_TABLE)
        userDefaults.set("N", forKey: Constants.PLAYER_TABLE)
        userDefaults.set("N", forKey: Constants.PLAYER_INJURY_TABLE)
        userDefaults.set("N", forKey: Constants.SCHEDULE_TABLE)
        userDefaults.set("N", forKey: Constants.SCORING_SUMMARY_TABLE)
        userDefaults.set("N", forKey: Constants.TEAM_TABLE)
        userDefaults.set("N", forKey: Constants.PLAYER_STATISTICS_TABLE)
        userDefaults.set("N", forKey: Constants.TEAM_STANDINGS_TABLE)
        userDefaults.set("N", forKey: Constants.TEAM_STATISTICS_TABLE)
    }
}
