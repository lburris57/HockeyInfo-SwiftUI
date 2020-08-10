//
//  SceneDelegate.swift
//  HockeyInfoSwiftUI
//
//  Created by Larry Burris on 6/9/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate
{
    var window: UIWindow?
    
    let userDefaults = UserDefaults.standard
    
    let userSettings = UserSettingsViewModel()
    
    let databaseManager = DBManager()
    
    let dataManager = DataManager()
    
    let currentSeason = TimeAndDateUtils.getCurrentSeason()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions)
    {
        print("\n\nIn scene delegate......\n\n")
        
        if self.databaseManager.fullScheduleRequiresLoad()
        {
            NetworkManager().retrieveStandings()
            
            NetworkManager().retrieveRosterList()
            
            NetworkManager().retrieveFullSeasonSchedule()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0)
            {
                self.databaseManager.linkPlayersToTeams()
                
                NetworkManager().retrievePlayerStatisticsDictionary(){_ in }
            }
        }
        
        let playerLeaders = self.databaseManager.retrieveCategoryLeaders("goals")
        
        print("\nSize of player leaders list is \(playerLeaders.count) for goals category\n")
        
        for player in playerLeaders
        {
            print("\(player)\n")
        }
        
        let goalieLeaders = self.databaseManager.retrieveGoalieCategoryLeaders("shutouts", false)
        
        print("\nSize of goalie leaders list is \(goalieLeaders.count) for shutouts category\n")
        
        for goalie in goalieLeaders
        {
            print("\(goalie)\n")
        }
        
        userDefaults.set(TimeAndDateUtils.isValidSetting(currentSeason, true), forKey: Constants.IS_PLAYOFF_SETTING_VALID)
        
        //print("Value of IS_PLAYOFF_SETTING_VALID is \(userDefaults.bool(forKey: Constants.IS_PLAYOFF_SETTING_VALID))")
        //print("Value of current season is \(currentSeason)")
        
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        // Use a UIHostingController as window root view controller
        if let windowScene = scene as? UIWindowScene
        {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: MainMenuView().environmentObject(UserSettingsViewModel()))
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene)
    {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene)
    {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene)
    {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene)
    {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene)
    {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}

