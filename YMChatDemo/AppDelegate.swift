//
//  AppDelegate.swift
//  YMChatDemo
//
//  Created by Kauntey Suryawanshi on 12/02/21.
//

import UIKit
import YMChat

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        if let payload = userInfo["notificationIdentifier"] as? String {
            let data = Data(payload.utf8)
            if let jsonPayload = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: String] {
                YMChat.shared.config.payload = jsonPayload
            }
        }

        completionHandler()
    }


    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

/* EXAMPLE PUSH NOTIFICATION PAYLOAD
 {
         "notification": {
             "title": "Test from local 24",
             "body": "test"
         },
         "data": {
             "notificationIdentifier": "ORD123"
         },
         "apns": {
             "headers": {
                 "apns-collapse-id": "22525410718044744571092241829"
             }
         }
     }
 */
