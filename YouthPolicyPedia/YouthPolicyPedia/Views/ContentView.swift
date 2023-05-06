//
//  ContentView.swift
//  YouthPolicyPedia
//
//  Created by 김태성 on 2023/04/01.
//

import SwiftUI

struct ContentView : View {
    
    @EnvironmentObject var policyStore: PolicyStore
    @State var isShowingOnboardingView: Bool = UserDefaults.standard.object(forKey: "isShowingOnboardingView") as? Bool ?? true
    @State var isShowingSelectView: Bool = UserDefaults.standard.object(forKey: "isShowingSelectView") as? Bool ?? true
    
    var body: some View {
        ZStack {
//            if isShowingOnboardingView {
//                FirstOnboardingView(isShowingOnboardingView: $isShowingOnboardingView)
            if isShowingSelectView {
                SelectView(isShowingSelectView: $isShowingSelectView, isShowingOnboardingView: $isShowingOnboardingView)
            } else {
                TabView {
                    YouthCenterTab()
                        .tabItem {
                            Image(systemName: "door.right.hand.closed")
                            Text("청년 공간")
                        }
                    YouthPolicyTab()
                        .tabItem {
                            Image(systemName: "square.on.square.badge.person.crop.fill")
                            Text("청년 정책")
                        }
                    YouthPolicyGlossaryTab()
                        .tabItem {
                            Image(systemName: "character.book.closed")
                            Text("정책 용어")
                        }
                }
                .onAppear {
                    policyStore.ArrayForLocationQuery = policyStore.locationStringToCode(policyStore.selectedLocation, selectedDetailLocation: policyStore.selectedDetailLocation)
                    print(policyStore.userAge)
                    print(policyStore.ArrayForLocationQuery)
                    
//                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                        policyStore.fetchPolicies(userAge: policyStore.userAge)
//                    }
//                    print("이전 정보")
//                    print(UserDefaults.standard.dictionary(forKey: "myLocation") ?? ["이전정보": "없음"])
//                    
//                    print("이후 정보 업데이트")
//                    print(UserDefaults.standard.dictionary(forKey: "myLocation") ?? ["이후정보": "없음"])
                    
//                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) {
//                        print(policyStore.policies)
//                    }
                }
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
