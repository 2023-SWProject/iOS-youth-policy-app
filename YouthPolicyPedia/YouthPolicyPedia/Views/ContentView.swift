//
//  ContentView.swift
//  YouthPolicyPedia
//
//  Created by 김태성 on 2023/04/01.
//

import SwiftUI

struct ContentView : View {
    
    @EnvironmentObject var policyStore: PolicyStore
    @EnvironmentObject var centerStore: CenterStore
    @State var isShowingOnboardingView: Bool = UserDefaults.standard.object(forKey: "isShowingOnboardingView") as? Bool ?? true
    @State var isShowingSelectView: Bool = UserDefaults.standard.object(forKey: "isShowingSelectView") as? Bool ?? true
    @State private var selection = 2
    
    var body: some View {
        ZStack {
            if isShowingSelectView {
                SelectView(isShowingSelectView: $isShowingSelectView, isShowingOnboardingView: $isShowingOnboardingView)
            } else {
                TabView(selection:$selection) {
                    YouthCenterTab(isShowingSelectView: $isShowingSelectView, isShowingOnboardingView: $isShowingOnboardingView)
                        .tabItem {
                            Image(systemName: "door.right.hand.closed")
                            Text("청년 공간")
                        }
                        .tag(1)
                    YouthPolicyTab(isShowingSelectView: $isShowingSelectView, isShowingOnboardingView: $isShowingOnboardingView)
                        .tabItem {
                            Image(systemName: "square.on.square.badge.person.crop.fill")
                            Text("청년 정책")
                        }
                        .tag(2)
                    YouthPolicyGlossaryTab(isShowingSelectView: $isShowingSelectView, isShowingOnboardingView: $isShowingOnboardingView)
                        .tabItem {
                            Image(systemName: "character.book.closed")
                            Text("정책 용어")
                        }
                        .tag(3)
//                    MyPageTab(isShowingSelectView: $isShowingSelectView, isShowingOnboardingView: $isShowingOnboardingView)
//                        .tabItem {
//                            Image(systemName: "person.circle")
//                            Text("내 정보")
//                        }
                }
                .onAppear {
                    print("컨텐트뷰컨텐트뷰컨텐트뷰컨텐트뷰컨텐트뷰컨텐트뷰컨텐트뷰컨텐트뷰컨텐트뷰 ")
                    print("USER AGE: \(policyStore.userAge)")
                    policyStore.ArrayForLocationQuery = policyStore.locationStringToCode(policyStore.selectedLocation, selectedDetailLocation: policyStore.selectedDetailLocation)
                    
                    // policyStore.ArrayForLocationQuery 쿼리 패치 완료 후 패치하기 위한 조건문
                    if policyStore.ArrayForLocationQuery != [] {
                        centerStore.fetchCenters()
                        policyStore.fetchPolicies(userAge: policyStore.userAge)
                    }
//                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) {
//                        for p in policyStore.policies {
//                            print("\(p.tags)")
//                        }
//                    }
                }
            }
        }
        .onAppear {
            print("\(policyStore.eduQuery) edu : \(policyStore.eduQuery.count)")
            print("\(policyStore.empQuery) emp : \(policyStore.empQuery.count)")
            print("\(policyStore.speQuery) spe : \(policyStore.speQuery.count)")
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                print("정책 개수 : \(policyStore.policies.count)개")
                print("센터 개수 : \(centerStore.centers.count)개")
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
