//
//  SettingView.swift
//  YouthPolicyPedia
//
//  Created by 김태성 on 2023/05/06.
//

import SwiftUI

struct SettingView: View {
    
    @EnvironmentObject var policyStore: PolicyStore
    
    @Binding var isShowingSelectView: Bool
    @Binding var isShowingOnboardingView: Bool
    
    var body: some View {
        VStack {
            Button {
//                SelectView(isShowingSelectView: $isShowingSelectView, isShowingOnboardingView: $isShowingOnboardingView)
                policyStore.pageNumber = 0
                
                // 유저 디폴트 초기화
//                UserDefaults.standard.set(true, forKey: "isShowingOnboardingView")
//                isShowingOnboardingView = true
                UserDefaults.standard.set(true, forKey: "isShowingSelectView")
                isShowingSelectView = true
                
                let userLocationInformation: [String: String] = [:]
                UserDefaults.standard.set(userLocationInformation, forKey: "myLocation")
                policyStore.selectedLocation = [:]
                
                let userDetailLocationInformation: [String: String] = [:]  //["key1": "value1", "key2": "value2"]
                UserDefaults.standard.set(userDetailLocationInformation, forKey: "myDetailLocation")
                policyStore.selectedDetailLocation = [:]
                
                let userAgeInformation = 0
                UserDefaults.standard.set(userAgeInformation, forKey: "myAge")
                policyStore.userAge = 0
            } label: {
                HStack {
                    Text("정보 수정하기")
                        .foregroundColor(.black)
                    Spacer()
                    Image(systemName: "arrow.right")
                }
            }
            .padding()
//            .simultaneousGesture(TapGesture().onEnded{
//                policyStore.pageNumber = 0
//            })
            
            Spacer()
        }
    }
}

//struct ChangeInformationView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChangeInformationView()
//    }
//}
