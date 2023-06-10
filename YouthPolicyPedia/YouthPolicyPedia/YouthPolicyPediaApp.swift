//
//  YouthPolicyPediaApp.swift
//  YouthPolicyPedia
//
//  Created by 김태성 on 2023/04/01.
//

import SwiftUI
import FirebaseCore

//class AppDelegate: NSObject, UIApplicationDelegate {
//    func application(_ application: UIApplication,
//                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        FirebaseApp.configure()
//
//        return true
//    }
//}

@main
struct YouthPolicyPediaApp: App {
    // register app delegate for Firebase setup
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    
    init() {
        FirebaseApp.configure()
        Thread.sleep(forTimeInterval: 1)
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
                    .environmentObject(PolicyStore())
                    .environmentObject(CenterStore())
            }
        }
    }
}
