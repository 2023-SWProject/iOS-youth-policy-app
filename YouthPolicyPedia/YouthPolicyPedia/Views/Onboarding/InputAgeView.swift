//
//  InputAgeView.swift
//  YouthPolicyPedia
//
//  Created by 김태성 on 2023/05/03.
//

import SwiftUI

struct InputAgeView: View {
    @Binding var isShowingInputAgeView: Bool
    @EnvironmentObject var policyStore: PolicyStore
    
    var body: some View {
        VStack {
            Text("만 나이를 입력해주세요.")
                .bold()
                .font(.system(size: 27))
            
            TextField("나이", text: $policyStore.myAge)
                .bold()
                .font(.system(size: 27))
                .padding()
            
            Button {
                UserDefaults.standard.set(false, forKey: "isShowingInputAgeView")
                isShowingInputAgeView.toggle()
            } label: {
                Text("확인하기")
                    .frame(width: UIScreen.main.bounds.width - 30, height: 50)
                    .background(policyStore.myAge == "" ? Color.gray : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(13)
            }
            .padding()
            .disabled(policyStore.myAge == "")
        }
    }
}

//struct InputAgeView_Previews: PreviewProvider {
//    static var previews: some View {
//        InputAgeView()
//    }
//}
