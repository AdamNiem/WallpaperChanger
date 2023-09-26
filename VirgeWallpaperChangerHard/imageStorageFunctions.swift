//
//  imageStorageFunctions.swift
//  VirgesWallpaperChanger
//
//  Created by AdamN on 8/9/23.
//

import Foundation
import SwiftUI
import AppKit

//https://stackoverflow.com/questions/37344822/saving-image-and-then-loading-it-in-swift-ios
//this function uses NSImage which is only for mac, if ever importing to mobile will need to create a typealias so that UIImage can be used for ios and then NSImage applied to macos through using UIImage
//https://www.swiftbysundell.com/tips/making-uiimage-macos-compatible/

/*
func saveImage(image: NSImage) -> Bool {
    let test = NSImage()
    guard let data = image.pngData() ?? image.jpegData() else {
        return false
    }
    guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
        return false
    }
    do {
        try data.write(to: directory.appendingPathComponent("fileName.png")!)
        return true
    } catch {
        print(error.localizedDescription)
        return false
    }
}

func getSavedImage(named: String) -> NSImage? {
    if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
        return NSImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(named).path)
    }
    return nil
}
 
*/

func saveFile(url: URL, fileNewName: String) -> Bool {
    
    
    guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
        return false
    }
    do {
        let data = try Data(contentsOf: url)
        let fileNameExtended = fileNewName + ".png"
        try data.write(to: directory.appendingPathComponent(fileNameExtended)!)
        print("file saved!")
        return true
    }
    catch{
        print("error in saving file ", error.localizedDescription)
        return false
    }

}



func getFilePath(fileName: String) -> String? {
    
    guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
        return nil
    }
    let fileNameExtended = fileName + ".png"
    print("getting FILE PATH", directory.appendingPathComponent(fileNameExtended)?.path)
    
    return directory.appendingPathComponent(fileNameExtended)?.path

}


func saveImage(url: URL, fileNewName: String) -> Bool {
    
    guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
        return false
    }
    do {
        //let image = NSImage(contentsOf: url)
        //let imageData = image?.tiffRepresentation!
        let data = try Data(contentsOf: url)
        
        let fileNameExtended = fileNewName + ".png"
        try data.write(to: directory.appendingPathComponent(fileNameExtended)!)
        //data.w
        print("image saved!")
        return true
    }
    catch{
        print("error in saving image ", error.localizedDescription)
        return false
    }

}

func getImagePath(fileName: String) -> String? {
    
    guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
        return nil
    }
    let fileNameExtended = fileName + ".png"
    print("getting IMAGE PATH", directory.appendingPathComponent(fileNameExtended)?.path)
    
    return directory.appendingPathComponent(fileNameExtended)?.path

}

func getImageFile(fileName: String) -> NSImage? {
    guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
        assertionFailure("could not find directory url to get the image file")
        return nil
    }
    
    let fileNameExtended = fileName + ".png"
    guard let fileURL = directory.appendingPathComponent(fileNameExtended)?.absoluteURL else {
        assertionFailure("could not find file url to get the image file")
        return nil
    }
       
    print("getting IMAGE FILE PATH THING", fileURL)
    print("getting IMAGE FILE PATH THING TYPE", type(of: fileURL))

    guard let image = NSImage(contentsOf: fileURL) else{
        //assertionFailure("got the file but could not convert it into an image")
        return nil
    }
    
    return image
}



func saveLoadingImage(){
    let loadingScreen = Image("loadingScreen")
    
    //let data = Data(contentsOf: loadingScreen)
   // URL(i)
    //saveImage(url: <#T##URL#>, fileNewName: <#T##String#>)
}



