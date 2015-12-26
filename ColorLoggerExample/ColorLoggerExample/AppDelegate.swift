//
//  AppDelegate.swift
//  ColorLoggerExample
//
//  Created by Osamu Nishiyama on 2015/04/09.
//  Copyright (c) 2015年 EVER SENSE, INC. All rights reserved.
//

import UIKit

let log = ColorLogger.defaultInstance

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        log.verbose("This is Verbose Log") //verbose not active. Default outputLogLevel is Debug
        log.debug("This is Debug Log")
        log.info("This is Info Log")
        log.warning("This is Warning Log")
        log.error("This is Error Log")
        
        log.debug([1,2,3,4]) // AnyObject
        let a : NSObject? = nil
        log.debug(a) //nil
        log.debug("one", 2, [3,4]) //variadic parameter
        
        
        log.outputLogLevel = .Verbose
        log.showFileInfo = false
        log.showDate = false
        log.showLogLevel = true
        log.showFunctionName = false
        
        print("")
        log.verbose("This is Verbose Log")
        log.debug("This is Debug Log")
        log.info("This is Info Log")
        log.warning("This is Warning Log")
        log.error("This is Error Log")

        
        log.outputLogLevel = .Warning
        log.showLogLevel = false
        log.showFileInfo = false
        log.showFunctionName = true
        log.showDate = true
        
        print("")
        log.verbose("This is Verbose Log") // not active
        log.debug("This is Debug Log") // not active
        log.info("This is Info Log") // not active
        log.warning("This is Warning Log")
        log.error("This is Error Log")
        
        

        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

