//
//  PreloadViewController.swift
//  YMChatDemo
//
//  Created by Sankalp on 04/01/23.
//

import UIKit
import YMChat

class PreloadViewController: UIViewController, YMChatDelegate {

    var chatController: YMChatViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let config = YMConfig(botId: botID)
        config.version = 2
        YMChat.shared.config = config

        // Loads the chat window. Pass the current view controller as a parameter
        do {
            self.chatController = try YMChat.shared.initialiseView()
            chatController.view.frame = self.view.frame
            self.addChild(chatController)
            view.addSubview(chatController.view)
            chatController.view.isHidden = true
        } catch {
            print("Error occured while loading chatbot \(error)")
        }
        
        YMChat.shared.delegate = self
    }

    @IBAction func presentChatbot(_ sender: Any) {
        chatController.view.isHidden = false
    }
    
    //MARK: - YMChatDelegate
    func onEventFromBot(response: YMBotEventResponse) {
        print(response.description)
    }
    
    func onBotClose() {
        chatController.view.isHidden = true
    }
}
