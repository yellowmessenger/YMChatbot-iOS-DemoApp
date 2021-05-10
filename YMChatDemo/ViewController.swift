//
//  ViewController.swift
//  YMChatDemo
//
//  Created by Kauntey Suryawanshi on 12/02/21.
//

import UIKit
import YMChat // Note this

class ViewController: UIViewController, YMChatDelegate {

    @IBAction func presentYM(_ sender: Any) {
        let config = YMConfig(botId: "x1609740331340")
        config.statusBarColor = UIColor(red: 81 / 255, green: 133 / 255, blue: 237 / 255, alpha: 1)

        config.enableHistory = true
        config.payload = ["UserState": "Anonymous"]

        // WARNING: config should be set before invoking startChatBot() method
        YMChat.shared.config = config

        // Loads the chat window. Pass the current view controller as a parameter
        YMChat.shared.startChatbot(on: self)

        // Enable logging for debugging purpose
        YMChat.shared.enableLogging = true

        YMChat.shared.delegate = self
    }

    // MARK: - YMChatDelegate
    func onEventFromBot(response: YMBotEventResponse) {
        print("Even from a bot has been received", response)
    }
}
