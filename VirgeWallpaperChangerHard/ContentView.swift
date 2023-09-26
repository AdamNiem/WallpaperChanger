//
//  ContentView.swift
//  VirgesWallpaperChanger
//
//  Created by AdamN on 7/22/23.
//
// ContentView stuff isnt used for now can be deleted

import SwiftUI

struct ContentView: View {
    
    @State private var showFileImporter = false
    
    
    let data = (1...12).map { "Item \($0)" }
    let datas = ["january", "february", "march", "april", "may", "june", "july", "august", "september", "october", "november", "december"]

        let columns = [
            GridItem(.adaptive(minimum: 200))
        ]
    
    var body: some View {
       
        ScrollView {
            LazyVGrid(columns: columns, alignment: .center) {
                       ForEach(datas, id: \.self) { item in
                        VStack
                        {
                           Text(item)
                           Button("Pick Background Image") {
                              showFileImporter = true
                           }
                           .fileImporter(isPresented: $showFileImporter, allowedContentTypes: [.jpeg, .tiff, .png]) { result in
                               switch result {
                               case .failure(let error):
                                   print("Error selecting file \(error.localizedDescription)")
                               case .success(let url):
                                   print("selected url = \(url)")
                               }
                               
                           }
                           
                           .background(RoundedRectangle(cornerRadius: 8)
                           .foregroundColor(Color.gray)
                           .shadow(color: Color.black, radius: 8, x: 0, y: 4))
                            Image(nsImage: NSImage())
                                .resizable()
                                 .aspectRatio(contentMode: .fit)
                                .frame(width: 240, height: 150, alignment: .center)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color.gray.opacity(0.8), lineWidth: 2)
                                )
                        }
                        .frame(width: 200, height: 200)
                        .background(Color.gray.opacity(0.2))
                        .border(Color.white)
                        .shadow(radius: 10)
                        .cornerRadius(5)
                       }
                       
                       
                   }
                   .padding()
                  
                   Spacer()
               }
        
        
    }
    
}


