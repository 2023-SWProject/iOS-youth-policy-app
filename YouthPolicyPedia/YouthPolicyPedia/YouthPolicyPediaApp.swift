//
//  YouthPolicyPediaApp.swift
//  YouthPolicyPedia
//
//  Created by 김태성 on 2023/04/01.
//

import SwiftUI
import FirebaseCore

// TODO: 상태 입력 화면에서 항목 추가하기
// FIXME: 중앙 부처인 것들 임의의 코드 한개 부여하기

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
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
//                AgeSelectView()
                ContentView()
                    .environmentObject(PolicyStore())
            }
        }
    }
}
