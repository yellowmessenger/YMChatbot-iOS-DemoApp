//
//  SceneDelegate.swift
//  YMChatDemo
//
//  Created by Kauntey Suryawanshi on 12/02/21.
//

import UIKit
import YMChat

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

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

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        // Data can be passed in notification payload as seen above. The content of data can be then accessed here and pass furhter to the bot in the payload
        let userInfo = connectionOptions.notificationResponse?.notification.request.content.userInfo
        if let payload = userInfo?["notificationIdentifier"] as? String {
            let data = Data(payload.utf8)
            if let jsonPayload = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: String] {
                YMChat.shared.config.payload = jsonPayload
            }
        }

        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}
