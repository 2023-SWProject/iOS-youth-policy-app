//
//  PersonalInformationControlView.swift
//  YouthPolicyPedia
//
//  Created by 김태성 on 2023/06/09.
//

import SwiftUI

struct PersonalInformationControlView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text("미정이")
                    .fontWeight(.semibold)
                Text("저희 미정이는 어떠한 개인정보도 \n수집하지 않습니다")
                Text("모든 정보는 사용자의 앱 내에 저장됩니다.")
            }
            .foregroundColor(.gray)
            .padding(.bottom, 5)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .navigationBarTitle("개인정보 취급방침", displayMode: .inline)
    }
}

struct PersonalInformationControlView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalInformationControlView()
    }
}
