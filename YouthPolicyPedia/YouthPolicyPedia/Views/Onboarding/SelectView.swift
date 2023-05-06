//
//  SelectView.swift
//  YouthPolicyPedia
//
//  Created by 김태성 on 2023/05/05.
//

import SwiftUI

struct SelectView: View {
    
    @EnvironmentObject var policyStore: PolicyStore
    
    @Binding var isShowingSelectView: Bool
    @Binding var isShowingOnboardingView: Bool
    
    var body: some View {
        ZStack {
            if policyStore.pageNumber == -2 {
                FirstOnboardingView()
            } else if policyStore.pageNumber == 0 {
                LocationSelectView()
                    .transition(.opacity.animation(.easeIn(duration: 0.4)))
            } else if policyStore.pageNumber == 1 {
                DetailLocationSelectView()
                    .transition(.opacity.animation(.easeOut(duration: 0.4)))
            } else if policyStore.pageNumber == 2 {
                AgeSelectView(isShowingSelectView: $isShowingSelectView, isShowingOnboardingView: $isShowingOnboardingView)
                    .transition(.opacity.animation(.easeOut(duration: 0.4)))
            } else if policyStore.pageNumber == -1 {
                Text("")
                    .transition(.opacity.animation(.easeIn(duration: 0.4)))
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.4) {
                            policyStore.pageNumber = 1
                        }
                    }
            }
        }
    }
}

//struct SelectView_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectView()
//    }
//}
