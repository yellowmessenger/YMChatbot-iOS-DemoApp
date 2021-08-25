//
//  ViewController.swift
//  YMChatDemo
//
//  Created by Kauntey Suryawanshi on 12/02/21.
//

import UIKit
import YMChat // Note this
import Firebase
import FirebaseMessaging

class ViewController: UIViewController, YMChatDelegate {

    @IBAction func presentYM(_ sender: Any) {
        Messaging.messaging().token { token, error in
          if let error = error {
            print("########## Error fetching FCM registration token: \(error)")
          } else if let token = token {
            print("########## FCM registration token: \(token)")
            self.presentBot(fcmToken: token)
          }
        }

    }

    func presentBot(fcmToken: String) {
        let config = YMConfig(botId: "x1609740331340")

        config.deviceToken = fcmToken

        config.payload = ["name": "xyz"]

        config.statusBarColor = UIColor.red

        // WARNING: config should be set before invoking startChatBot() method
        YMChat.shared.config = config

        // Loads the chat window. Pass the current view controller as a parameter
        do {
            try YMChat.shared.startChatbot()
        } catch {
            print("Error occured while loading chatbot \(error)")
        }

        YMChat.shared.delegate = self
    }

    // MARK: - YMChatDelegate
    func onEventFromBot(response: YMBotEventResponse) {
        print("Even from a bot has been received", response)
    }

    func onBotClose() {
        print("Bot closed")
    }
}
