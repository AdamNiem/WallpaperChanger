//
//  monthGrid.swift
//  VirgesWallpaperChanger
//
//  Created by AdamN on 7/28/23.
//

import SwiftUI
import UserNotifications

struct monthGrid: View {
    
    @State private var showFileImporter = false
    @State private var currentlySelectedMonth = ""
    @State private var appToggle = true
    @State private var tempVariable = NSImage()
    
    @State private var monthURLs = [
        "january": "virge",
        "february": "virge",
        "march": "virge",
        "april": "virge",
        "may": "virge",
        "june": "test",
        "july": "virge",
        "august": "virge",
        "september": "virge",
        "october": "virge",
        "november": "virge",
        "december": "virge",
        "loading screen": "virge"
    ]
    
    @State private var monthNSImages = [
        "january": getImageFile(fileName: "january") ?? NSImage(),
        "february": getImageFile(fileName: "february") ?? NSImage(),
        "march": getImageFile(fileName: "march") ?? NSImage(),
        "april": getImageFile(fileName: "april") ?? NSImage(),
        "may": getImageFile(fileName: "may") ?? NSImage(),
        "june": getImageFile(fileName: "june") ?? NSImage(),
        "july": getImageFile(fileName: "july") ?? NSImage(),
        "august": getImageFile(fileName: "august") ?? NSImage(),
        "september": getImageFile(fileName: "september") ?? NSImage(),
        "october": getImageFile(fileName: "october") ?? NSImage(),
        "november": getImageFile(fileName: "november") ?? NSImage(),
        "december": getImageFile(fileName: "december") ?? NSImage(),
        "loading screen": getImageFile(fileName: "loading screen") ?? NSImage()
    ]
    
    @State private var currentMonth = "january"
    
    @State var showingAlert = false

    
    //utilize a timer that tries to update desktop every 3 seconds when app is running. This is done since
    let monthCalendarTimer = CalendarTimer(timeInterval: 3)
    let notificationHandler = NotificationHandler()
    
    var body: some View {
        
        let columns = [
            GridItem(.adaptive(minimum: 250))
        ]
        
        ScrollView {
            LazyVGrid(columns: columns, alignment: .center, spacing: 50) {
                       ForEach(["january", "february", "march", "april", "may", "june", "july", "august", "september", "october", "november", "december", "loading screen"], id: \.self) { item in
                        
                           VStack {
                               Text(String(item).capitalized)
                               Button("upload " + String(item).capitalized + " image here"){
                                   showFileImporter = true
                                   currentlySelectedMonth = String(item)
                                   //imageURL
                               }
                               .fileImporter(isPresented: $showFileImporter, allowedContentTypes: [.jpeg, .tiff, .png]) { result in
                                   switch result {
                                      case .failure(let error):
                                          print("Error selecting file \(error.localizedDescription)")
                                          currentlySelectedMonth = ""
                                      case .success(let url):
                                          print("selected url = \(url)")
                                         
                                            showFileImporter = false
                                            monthURLs[currentlySelectedMonth] = "\(url)"

                                            saveFile(url: url, fileNewName: currentlySelectedMonth)
                                       
                                            //should add a better fallback
                                            tempVariable = getImageFile(fileName: currentlySelectedMonth) ?? NSImage()
                                            monthNSImages[currentlySelectedMonth] = getImageFile(fileName: currentlySelectedMonth) ?? NSImage()
                                       
                                       //print(UNUserNotificationCenter.current().)
                                       
                                       ///-----------------------------------------------------
                                            //this is done because wallpaper does not update when the image it is set to is updated (Ex: changing august photo will not update wallpaper unless changed to some other picture and then back to the august photo)
                                       if((getImageFile(fileName: "loading screen")) != nil){
                                           changeDesktopWallpaperToRelativeAppDocumentary(fileName: "loading screen")
                                       }else{
                                           //switch is probably not the best solution but i dont care for now
                                           //if loading screen is not given an image then will pick an image from a month different to the one currently selected
                                           var month = "january"
                                           switch(currentlySelectedMonth){
                                               case "january": month = "february"
                                               case "february": month = "march"
                                               case "march": month = "april"
                                               case "april": month = "may"
                                               case "may": month = "june"
                                               case "june": month = "july"
                                               case "july": month = "august"
                                               case "august": month = "september"
                                               case "september": month = "october"
                                               case "october": month = "november"
                                               case "november": month = "december"
                                               case "december": month = "january"
                                               default: month = "january"
                                           }
                                           changeDesktopWallpaperToRelativeAppDocumentary(fileName: month)
                                       }
                                       ///-----------------------------------------------------

                                   }
                                      
                                  }
                               
                               Image(nsImage: monthNSImages[item] ?? NSImage())
                                   .resizable()
                                    .aspectRatio(contentMode: .fit)
                                   .frame(width: 240, height: 150, alignment: .center)
                                   .overlay(
                                               RoundedRectangle(cornerRadius: 5)
                                                   .stroke(Color.gray.opacity(0.8), lineWidth: 2)
                                           )
                                                              
                           }
                           .frame(width: 250, height: 220, alignment: .center)
                           .background(Color.gray.opacity(0.2))
                           .shadow(radius: 10)
                           .cornerRadius(5)
                           
                               
                       }
                       
                   }
            //toggle to turn app on or off in background
            Toggle("This doesnt do anything", isOn: $appToggle)
                .onChange(of: appToggle) { newValue in
                    if appToggle == true {
                        //monthCalendarTimer.timer.resume()
                    }
                    if appToggle == false {
                        //monthCalendarTimer.timer.suspend()
                    }
                }
            Text("Some details: app when toggled runs a background timer that checks the month every day to see if wallpaper should be changed")
           
               }
            agentBtn()
            
    }
    
    //https://stackoverflow.com/questions/44999876/nsworkspace-setdesktopimageurl-fit-to-screen
    func setDesktopImageTest(url: URL) {
        do {
            if let screen = NSScreen.main {
                try NSWorkspace.shared.setDesktopImageURL(url, for: screen, options: [:])
                
            }
        } catch {
            print(error)
        }
    }
    
}


struct monthGrid_Previews: PreviewProvider {
    static var previews: some View {
        monthGrid()
    }
}

