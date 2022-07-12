//
//  CatsAndModules_DanyloLitvinchukApp.swift
//  CatsAndModules_DanyloLitvinchuk
//
//  Created by Danylo Litvinchuk on 19.06.2022.
//

import SwiftUI
import Foundation
import FirebaseCore
import FirebaseCrashlytics

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}


@main
struct CatsAndModules_DanyloLitvinchukApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
