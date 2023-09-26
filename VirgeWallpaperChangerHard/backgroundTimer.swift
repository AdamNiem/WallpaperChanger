//
//  backgroundTimer.swift
//  VirgesWallpaperChanger
//
//  Created by AdamN on 8/11/23.
//

import Foundation
import SwiftUI


func timerInit() -> DispatchSourceTimer {
    let t = DispatchSource.makeTimerSource()
    t.schedule(deadline: .now(), repeating: .seconds(1), leeway: .seconds(1))
    t.setEventHandler(handler: { () in
        print("timer is timering")
    })
    
    t.resume()
    return t
}

/// https://medium.com/over-engineering/a-background-repeating-timer-in-swift-412cecfd2ef9
/// By Daniel Galasko
/// RepeatingTimer mimics the API of DispatchSourceTimer but in a way that prevents
/// crashes that occur from calling resume multiple times on a timer that is
/// already resumed (noted by https://github.com/SiftScience/sift-ios/issues/52
class RepeatingTimer {

    let timeInterval: TimeInterval
    
    init(timeInterval: TimeInterval) {
        self.timeInterval = timeInterval
    }
    
    private lazy var timer: DispatchSourceTimer = {
        let t = DispatchSource.makeTimerSource()
        t.schedule(deadline: .now() + self.timeInterval, repeating: self.timeInterval)
        t.setEventHandler(handler: { [weak self] in
            self?.eventHandler?()
        })
        return t
    }()

    var eventHandler: (() -> Void)?

    private enum State {
        case suspended
        case resumed
    }

    private var state: State = .suspended

    deinit {
        timer.setEventHandler {}
        timer.cancel()
        /*
         If the timer is suspended, calling cancel without resuming
         triggers a crash. This is documented here https://forums.developer.apple.com/thread/15902
         */
        resume()
        eventHandler = nil
    }

    func resume() {
        if state == .resumed {
            return
        }
        state = .resumed
        timer.resume()
    }

    func suspend() {
        if state == .suspended {
            return
        }
        state = .suspended
        timer.suspend()
    }
}


func setDesktopImageTest(url: URL) {
    do {
        if let screen = NSScreen.main {
            try NSWorkspace.shared.setDesktopImageURL(url, for: screen, options: [:])
        }
    } catch {
        print(error)
    }
}

func getCurrentMonthName() -> String{
    let currentDate = Date()

    let nameFormatter = DateFormatter()
    nameFormatter.dateFormat = "MMMM" // format January, February, March, ...

    let name = nameFormatter.string(from: currentDate)
    let lowercaseName = name.lowercased()
    let lowercaseNameTrimmmed = lowercaseName.trimmingCharacters(in: .whitespacesAndNewlines) //a bit lengthy
    //let index = Calendar.current.component(.month, from: currentDate) // format 1, 2, 3, ...
        
    //return returns january, february, march I think
    
    return lowercaseNameTrimmmed
}

func pickRandomMonth() -> String{
    let randomInt = Int.random(in: 1..<12)
    var month = "january"
    switch randomInt{
        case 1: month = "january"
        case 2: month = "february"
        case 3: month = "march"
        case 4: month = "april"
        case 5: month = "may"
        case 6: month = "june"
        case 7: month = "july"
        case 8: month = "august"
        case 9: month = "september"
        case 10: month = "october"
        case 11: month = "november"
        case 12: month = "december"
        default: month = "january"
    }
    
    return month
}

class CalendarTimer {
    var timeInterval:Double
    var timer:RepeatingTimer
    var counter = ""
    
    init(timeInterval: Double = 10){
        self.timeInterval = timeInterval
        self.timer = RepeatingTimer(timeInterval: timeInterval)
        self.timer.eventHandler = {
            //unwraps optionals and then sets wallpaper to file in apps document directory image with the name of the current month
            guard let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
                return
            }
            
            let currentMonthName = getCurrentMonthName()
            let fileName = currentMonthName + ".png"
            guard let url = dir.appendingPathComponent(fileName)?.path else{
                return
            }
            
            if(self.counter == ""){
                self.counter = "1"
            }else if(self.counter == "1"){
                self.counter = ""
            }
            
            do {
                if let screen = NSScreen.main {
                    try NSWorkspace.shared.setDesktopImageURL(URL(fileURLWithPath:url), for: screen, options: [:])
                }
            } catch {
                print(error)
            }
        }
        timer.resume()
    }
    
}

//great name :|
func changeDesktopWallpaperToRelativeAppDocumentary(fileName: String){
        
    //unwraps optionals and then sets wallpaper to file in apps document directory image with the name of the current month
    guard let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
        return
    }
    let fileName = fileName + ".png"
    guard let url = dir.appendingPathComponent(fileName)?.path else{
        return
    }
    
    do {
        print(url)
    ///src: https://stackoverflow.com/questions/44999876/nsworkspace-setdesktopimageurl-fit-to-screen
        if let screen = NSScreen.main {
            try NSWorkspace.shared.setDesktopImageURL(URL(fileURLWithPath:url), for: screen, options: [:])
        }
    } catch {
        print(error)
    }
    
}

