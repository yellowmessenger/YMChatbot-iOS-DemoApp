# YMChatbot-iOS-DemoApp

This demo app demonstrates how chatbot can be integrated in a native iOS app using Cocoapods

The chatbot SDK can be found at [https://github.com/yellowmessenger/YMChatbot-iOS](https://github.com/yellowmessenger/YMChatbot-iOS)

## Steps to run
1. Clone the demo app
2. Open terminal and run `pod install`. This shall install the Chatbot SDK in your demo app
3. Open the `YMChatDemo.xcworkspace` file in Xcode and Run

### Push notifications
At present YMChat supports only Firebase push notifications
1. Download [GoogleService-Info.plist](https://firebase.google.com/docs/cloud-messaging/ios/client#add-config-file) from your account and add it to your Xcode project
2. Make sure `ymNotificationSetup` function is **uncommented** in appDidFinishLaunching method.
3. Ensure the Bundle indentifier of your xcode project matches with the one present in firebase config
4. Ensure your notification code is setup properly by sending notifications from [Firebase notification composer](https://firebase.google.com/docs/cloud-messaging/ios/first-message#send_a_notification_message)
