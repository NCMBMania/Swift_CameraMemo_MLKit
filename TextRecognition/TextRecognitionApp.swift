//
//  TextRecognitionApp.swift
//  TextRecognition
//
//  Created by Atsushi on 2021/09/02.
//

import SwiftUI
import NCMB

@main
struct TextRecognitionApp: App {
    @Environment(\.scenePhase) private var scenePhase // 追加
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .onChange(of: scenePhase) { scene in
            switch scene {
            case .active:
                NCMB.initialize(applicationKey: "YOUR_APPLICATION_KEY", clientKey: "YOUR_CLIENT_KEY")
            case .background: break;
            case .inactive: break;
            @unknown default: break;
            }
        }
    }
}
