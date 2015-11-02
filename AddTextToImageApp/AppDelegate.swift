//
//  AppDelegate.swift
//  AddTextToImageApp
//
//  Created by martin hand on 11/1/15.
//  Copyright © 2015 martin hand. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var memes = [Meme]()
    
    var memesFilePath : String {
        let manager = NSFileManager.defaultManager()
        let url = manager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
        return url.URLByAppendingPathComponent("memesArray").path!
    }
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        // Unarchive the graph when application launch
        //        self.memes = NSKeyedUnarchiver.unarchiveObjectWithFile(memesFilePath) as? [Meme] ?? [Meme]()
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if let savedMemes = defaults.objectForKey("memes") as? NSData {
            memes = NSKeyedUnarchiver.unarchiveObjectWithData(savedMemes) as! [Meme]
        }
        
        print("didFinishLaunchingWithOptions")
        
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        print("applicationWillResignActive() - Running save method")
        save()
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        //NSKeyedArchiver.archiveRootObject(memes, toFile: memesFilePath)
        
        save()
        
        print("applicationDidEnterBackground() - Running save() method")
    }
    
    func save() {
        let savedData = NSKeyedArchiver.archivedDataWithRootObject(memes)
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(savedData, forKey: "memes")
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        
        //NSKeyedArchiver.archiveRootObject(self.memes, toFile: memesFilePath)
        save()
        
        print("applicationWillTerminate")
    }
    
    
}

