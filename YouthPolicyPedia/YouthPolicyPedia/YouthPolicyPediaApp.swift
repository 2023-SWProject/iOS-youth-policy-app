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
//        UserDefaults.standard.set(true, forKey: "isShowingOnboardingView") // 온보딩 계속 보이게 임시로 해놓음
//        UserDefaults.standard.set(true, forKey: "isShowingSelectView") // 온보딩 계속 보이게 임시로 해놓음
        
        
        // MARK: - 유저 디폴트에 정보가 있으면 로컬에 저장시키고 넘어가기
        
//        if UserDefaults.standard.integer(forKey: "myAge") > -1 {
//            PolicyStore().userAge = UserDefaults.standard.integer(forKey: "myAge")
//            print("유저디폴트 저장된 나이 : \(UserDefaults.standard.integer(forKey: "myAge"))")
//            print("폴리시스토어에 저장된 나이 : \(PolicyStore().userAge)")
//        }
//        
//        if let ML = UserDefaults.standard.dictionary(forKey: "myLocation") {
//
//            // [String: Any] -> [String: String]
//            var stringDictionary: [String: String] = [:]
//            for (key, value) in ML {
//                if let stringValue = value as? String {
//                    stringDictionary[key] = stringValue
//                }
//            }
//            
//            PolicyStore().selectedLocation = stringDictionary
//        }
//        
//        if let ML = UserDefaults.standard.dictionary(forKey: "myDetailLocation") {
//            
//            // [String: Any] -> [String: String]
//            var stringDictionary: [String: String] = [:]
//            for (key, value) in ML {
//                if let stringValue = value as? String {
//                    stringDictionary[key] = stringValue
//                }
//            }
//            
//            PolicyStore().selectedLocation = stringDictionary
//        }
//        
//        PolicyStore().ArrayForLocationQuery = PolicyStore().locationStringToCode(PolicyStore().selectedLocation, selectedDetailLocation: PolicyStore().selectedDetailLocation)
//        
//        print(PolicyStore().userAge)
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
//                AgeSelectView()
                ContentView()
//                Tex()
                    .environmentObject(PolicyStore())
            }
        }
    }
}
