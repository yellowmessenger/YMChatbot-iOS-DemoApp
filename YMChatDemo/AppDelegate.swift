//
//  AppDelegate.swift
//  YMChatDemo
//
//  Created by Kauntey Suryawanshi on 12/02/21.
//

import UIKit
import YMChat
import Firebase
import FirebaseMessaging

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        UNUserNotificationCenter.current().delegate = self
        Messaging.messaging().delegate = self

        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: { granted, _ in
            print("Notification permission Granted \(granted)")
        })
        application.registerForRemoteNotifications()

        return true
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        showNotificationTestAlert(userInfo: userInfo)

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

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // Push notification come here when the host app is in foreground and chotbot is not open
        showNotificationTestAlert(userInfo: userInfo)
        completionHandler(UIBackgroundFetchResult.newData)
    }

    private func showNotificationTestAlert(userInfo: [AnyHashable: Any]) {
        let botId = userInfo["botId"] as! String
        let aps = userInfo["aps"] as! [AnyHashable: Any]
        let alert = aps["alert"] as! [AnyHashable: Any]
        let body = alert["body"] as! String
        if let vc = UIApplication.shared.windows.first(where: {$0.isKeyWindow})?.rootViewController {
            vc.showInfoAlert(#"Notification: "\#(body)" for bot id: \#(botId)"#)
        }
    }

    //MARK: - Firebase messaging delegate methods

    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("############ Firebase registration token: \(String(describing: fcmToken))")
    }
    
}

extension UIViewController {
    func showInfoAlert(_ message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))

        present(alert, animated: true, completion: nil)
    }
}
