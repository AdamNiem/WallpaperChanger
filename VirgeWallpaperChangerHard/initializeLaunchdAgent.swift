//
//  main.swift
//  launchAgentTarget
//
//  Created by AdamN on 9/9/23.
//
import Foundation
import SwiftUI
import ServiceManagement

struct agentBtn: View{
    let service = SMAppService.agent(plistName: "Calcer.VirgeWallpaperChangerHard.agent.plist")

    var body: some View {
        
        Button("click here for magic launch agent things"){
            do {
                print("will register, status: \(service.status.rawValue)")
                try service.register()
                print("did register")
            } catch {
                print("did not register, error: \(error)")
            }
        }

    }
}
