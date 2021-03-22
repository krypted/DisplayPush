//
//  AppGlobal.swift
//  NotificationContentRead
//
//

import UIKit

//MARK:- Global Variable(s)
let _sharedUserDefaults = UserDefaults(suiteName:"group.com.notificationcontent.demo.notificationserviceextension")
let _defaultNotificationCenter = NotificationCenter.default

//MARK: - Global Notification Name(s)
let nfPushReceived = Notification.Name("nfPushReceived")
let nfApplicationBecomeActive = Notification.Name("nfApplicationBecomeActive")

//MARK: - Global Method(s)
/// It is used to print logs in console.
/// - Parameter items: Items to represetn any objects.
func vPrint(_ items: Any...) {
    #if DEBUG
    for item in items {
        print(item)
    }
    #endif
}

/// It is used to font used in Fonts
/// - Parameter font: Object to represent UIFont.
func printFonts(_ font: UIFont?) {
    if let _ = font{
        vPrint("------------------------------")
        vPrint("Font Family Name = [\(font!.familyName)]")
        let names = UIFont.fontNames(forFamilyName: font!.familyName)
        vPrint("Font Names = [\(names)]")
    }else{
        let fontFamilyNames = UIFont.familyNames
        for familyName in fontFamilyNames {
            vPrint("------------------------------")
            vPrint("Font Family Name = [\(familyName)]")
            let names = UIFont.fontNames(forFamilyName: familyName)
            vPrint("Font Names = [\(names)]")
        }
    }
}

/// It will stored notification object data to shared user defaults.
/// - Parameter notification: Represent **[String:Any]** value.
func storeNotificationToSharedDefaults(_ notification: [AnyHashable : Any]?) {
    guard let notification = notification else {return}
    if let dictCustom = notification["custom"] as? [String:Any],
       let dictA = dictCustom["a"] as? [String:Any],
       let url = dictA["url"] as? String {
        var arrOfURLs: [String] = []
        if var urls = fetchStoredNotifications() {
            urls.append(url);arrOfURLs = urls
        }else{
            arrOfURLs.append(url)
        }
        _sharedUserDefaults?.setValue(arrOfURLs, forKey: "push_urls")
        _sharedUserDefaults?.synchronize()
        _defaultNotificationCenter.post(name: nfPushReceived, object: nil, userInfo: nil)
    }
}

func fetchStoredNotifications() -> [String]? {
    return _sharedUserDefaults?.value(forKey: "push_urls") as? [String]
}
