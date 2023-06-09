//
//  MyPageTab.swift
//  YouthPolicyPedia
//
//  Created by 김태성 on 2023/05/28.
//

import SwiftUI

struct MyPageTab: View {
    @EnvironmentObject var policyStore: PolicyStore
    @EnvironmentObject var centerStore: CenterStore
    
    @Binding var isShowingSelectView: Bool
    @Binding var isShowingOnboardingView: Bool
    
    var body: some View {
        NavigationStack {
            HStack {
                Image(systemName: "person.circle")
                    .resizable()
                    .foregroundColor(.gray.opacity(0.3))
                    .frame(width: 50, height: 50)
//                    .overlay {
//                        Image(systemName: "figure.wave")
//                            .foregroundColor(.gray.opacity(0.7))
//                            .scaledToFill()
//                    }
                Spacer()
                Text("나의 지역")
                    .bold()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
            }
            .padding()

            Spacer()
            
            
                .navigationTitle("내 정보")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        NavigationLink {
                            SettingView(isShowingSelectView: $isShowingSelectView, isShowingOnboardingView: $isShowingOnboardingView)
                        } label: {
                            Image(systemName: "gearshape")
                                .foregroundColor(.black)
                        }
                    }
                }
        }
    }
}

struct MyPageTab_Previews: PreviewProvider {
    static var previews: some View {
        MyPageTab(isShowingSelectView: .constant(false), isShowingOnboardingView: .constant(false))
    }
}
