//
//  AppDelegate.swift
//  EmoDiary
//
//  Created by 이지영 on 2016. 11. 1..
//  Copyright © 2016년 gamsung. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        emoArray = [
            EmotionIndex.happy: Emotion(name: "행복", resource: "#FED958", value: 4),
            EmotionIndex.love: Emotion(name: "사랑", resource: "#FED3E0", value: 3),
            EmotionIndex.relieved: Emotion(name: "후련", resource: "#D2EEFB", value: 1),
            EmotionIndex.fun: Emotion(name: "재미", resource: "#FFB364", value: 2),
            EmotionIndex.anger: Emotion(name: "분노", resource: "#BE5C5D", value: -4),
            EmotionIndex.sad: Emotion(name: "우울", resource: "#768EFF", value: -3),
            EmotionIndex.lonely: Emotion(name: "외로움", resource: "#E2B7EE", value: -2),
            EmotionIndex.shame: Emotion(name: "자괴감", resource: "#D7D7D7", value: -1),
            EmotionIndex.calm: Emotion(name: "침착", resource: "#E1F7D9", value: 0),
            EmotionIndex.feelingless: Emotion(name: "애매", resource: "#E3DCCA", value: 0)
        ]

        return true
    }
    


    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

