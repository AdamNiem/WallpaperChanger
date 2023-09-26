//
//  Notifications.swift
//  VirgesWallpaperChanger
//
//  Created by AdamN on 8/17/23.
//

import Foundation
import SwiftUI
import UserNotifications



class NotificationHandler {
    init(){
        print("notification handler initializing")
        func promptUserToAcceptNotifications() -> Void {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                if success {

                    print("All set!")
                } else if let error = error {
                    print(error.localizedDescription)
                    
                }
            }
        }
        
        func createNotification(month: Int) -> Void{
            let content = UNMutableNotificationContent()
            
            UNUserNotificationCenter.current()
            content.title = "Change wallpaper Virge"
            content.subtitle = "Click to change wallpaper"
            content.sound = UNNotificationSound.default
            
            // set up 12 notifications for each month
            var date = DateComponents()
            date.day = 1
            date.minute = 1
            date.hour = 1
            date.month = month
            date.second = 1
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
            // choose a random identifier
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            // add our notification request
            UNUserNotificationCenter.current().add(request)
        }
        
        promptUserToAcceptNotifications()

        
        // set up 12 notifications for each month
        let counter:Int
        for x in 1...12 {
            print(x)
            createNotification(month: x)
        }
        
        
    }
}



func saveLog() -> Bool {
    
    guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
        return false
    }
    do {
        //let image = NSImage(contentsOf: url)
        //let imageData = image?.tiffRepresentation!
        let data = try Data(base64Encoded: "what is this")
        
        let fileNameExtended = "log.txt"
        let str = "textHere " + "\(Date())"
        try str.write(to: directory.appendingPathComponent(fileNameExtended)!, atomically: true, encoding: String.Encoding.utf8)
        //data.w
        print("image saved!")
        return true
    }
    catch{
        print("error in saving image ", error.localizedDescription)
        return false
    }

}

