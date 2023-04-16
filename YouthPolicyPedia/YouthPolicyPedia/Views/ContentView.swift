//
//  ContentView.swift
//  YouthPolicyPedia
//
//  Created by 김태성 on 2023/04/01.
//

import SwiftUI

struct ContentView : View {
    
    @StateObject var policyStore: PolicyStore = PolicyStore()
    
  var body: some View {
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
        policyStore.fetchPolicies()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) {
          // 1초 후 실행될 부분
            print(policyStore.policies)
        }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
