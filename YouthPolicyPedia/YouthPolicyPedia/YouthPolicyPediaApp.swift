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
        UserDefaults.standard.set(true, forKey: "isShowingOnboardingView") // 온보딩 계속 보이게 임시로 해놓음
        UserDefaults.standard.set(true, forKey: "isShowingInputAgeView") // 온보딩 계속 보이게 임시로 해놓음
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
//                SelectConditionView()
//                AgeTestView()
//                SetFilterTestView()
                ContentView()
                    .environmentObject(PolicyStore())
            }
        }
    }
}
