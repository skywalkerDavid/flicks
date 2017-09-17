//
//  AppDelegate.swift
//  flicks
//
//  Created by dawei_wang on 9/12/17.
//  Copyright © 2017 dawei_wang. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let nowPlayingNavigationController = storyboard.instantiateViewController(withIdentifier: "MoviesNavigationController") as! UINavigationController
        let nowPlayingViewController = nowPlayingNavigationController.topViewController as! MovieTableViewController
        nowPlayingViewController.endpoint = "now_playing"
        nowPlayingNavigationController.tabBarItem.title = "Now Playing"
        nowPlayingNavigationController.tabBarItem.image = UIImage.init(named: "ic_now_playing_normal")
        nowPlayingNavigationController.tabBarItem.selectedImage = UIImage.init(named: "ic_now_playing_selected")
        
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.babu()
        let color : UIColor = UIColor.white
        let titleFont : UIFont = UIFont(name: "Courier New", size: 16.0)!
        let attributes = [
            NSForegroundColorAttributeName : color,
            NSShadowAttributeName : shadow,
            NSFontAttributeName : titleFont
        ]
        
        nowPlayingNavigationController.tabBarItem.setTitleTextAttributes(attributes, for: UIControlState.normal)
        
        let topRatedNavigationController = storyboard.instantiateViewController(withIdentifier: "MoviesNavigationController") as! UINavigationController
        let topRatedViewController = topRatedNavigationController.topViewController as! MovieTableViewController
        topRatedViewController.endpoint = "top_rated"
        topRatedNavigationController.tabBarItem.title = "Top Rated"
        topRatedNavigationController.tabBarItem.image = UIImage.init(named: "ic_top_rated_normal")
        topRatedNavigationController.tabBarItem.selectedImage = UIImage.init(named: "ic_top_rated_selected")
        topRatedNavigationController.tabBarItem.setTitleTextAttributes(attributes, for: UIControlState.normal)
        
        let tabbarController = UITabBarController()
        tabbarController.viewControllers = [nowPlayingNavigationController, topRatedNavigationController]
        tabbarController.tabBar.barTintColor = UIColor.rausch()
        
        window?.rootViewController = tabbarController
        window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

