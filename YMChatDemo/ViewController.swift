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

let botID: String = <#botid#>
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
        let config = YMConfig(botId: botID)

        //To enable V2 bot set version = 2
//        config.version = 2

            // Set fcm device token for push notifications
            //config.deviceToken = fcmToken


            // Any information that needs to be passed from host app to the bot can be passed using payload
            // config.payload = ["name": "xyz"]

            // Other config
            //        config.closeButtonColor = UIColor.white
            //        config.statusBarColor = UIColor.red

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

    @IBAction func unlinkDeviceToken(_ sender: Any) {
        Messaging.messaging().token { token, error in
            if let error = error {
                print("########## Error fetching FCM registration token: \(error)")
            } else if let token = token {
                //Get api key from Account setting section of app.yellow.ai or My Profile Section of cloud.yellow.ai
                let apiKey: String = ""
                YMChat.shared.unlinkDeviceToken(botId: botID, apiKey: apiKey, deviceToken: token) {
                    print("Token removed successfully")
                } failure: { errorString in
                    print("ERROR: \(errorString)")
                }
            }
        }
    }


    // MARK: - YMChatDelegate
    func onEventFromBot(response: YMBotEventResponse) {
        print("Event from a bot has been received", response)
    }

    func onBotClose() {
        print("Bot closed")
    }
}

extension UIStackView {
    convenience init(
        views: [UIView],
        axis: NSLayoutConstraint.Axis? = nil,
        distribution: UIStackView.Distribution? = nil,
        alignment: UIStackView.Alignment? = nil,
        spacing: CGFloat? = nil
        ) {
        self.init(arrangedSubviews: views)
        if let axis = axis {
            self.axis = axis
        }
        if let distribution = distribution {
            self.distribution = distribution
        }
        if let alignment = alignment {
            self.alignment = alignment
        }
        if let spacing = spacing {
            self.spacing = spacing
        }
    }
}
