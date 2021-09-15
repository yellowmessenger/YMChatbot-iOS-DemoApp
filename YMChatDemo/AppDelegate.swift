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

        // NOTE: UNCOMMENT FOLLOWING LINE TO ENABLE FIREBASE PUSH NOTIFICATIONS
         ymNotificationSetup(application)

        return true
    }

    func ymNotificationSetup(_ application: UIApplication) {
        FirebaseApp.configure()
        UNUserNotificationCenter.current().delegate = self
        Messaging.messaging().delegate = self

        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: { granted, _ in
            print("Notification permission Granted \(granted)")
        })
        application.registerForRemoteNotifications()
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        showNotificationContentInAlertModal(userInfo: userInfo)

        completionHandler()
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {

        // Push notification come here when the host app is in foreground and chotbot is not open
        showNotificationContentInAlertModal(userInfo: userInfo)
        completionHandler(UIBackgroundFetchResult.newData)
    }

    /// Shows an alert when a push notification is received. This is only for **demonstration** purpose
    private func showNotificationContentInAlertModal(userInfo: [AnyHashable: Any]) {
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

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) { }
}
