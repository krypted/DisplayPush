//
//  PushNotification.swift
//  NotificationContentRead
//
//

import UIKit
import OneSignal

//MARK: UNUserNotificationCenterDelegate
extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func configOneSignal(_ launchOptions: [AnyHashable : Any]?) {
        OneSignal.initWithLaunchOptions(launchOptions)
        OneSignal.setAppId("7165ea65-b6b3-4b05-864f-1984fc6fcc6d")
        OneSignal.promptForPushNotifications(userResponse: {[weak self](accepted) in
            guard let _ = self else{return}
        }, fallbackToSettings: true)
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        vPrint(#function + " : " + error.localizedDescription)
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        vPrint("====================== APNS UserInfo ======================")
        vPrint("APNS UserInfo : " + String(describing: userInfo.description))
        _defaultNotificationCenter.post(name: nfPushReceived, object: nil)
    }
}
