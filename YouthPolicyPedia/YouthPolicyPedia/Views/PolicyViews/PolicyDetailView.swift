//
//  PolicyDetailView.swift
//  YouthPolicyPedia
//
//  Created by 김태성 on 2023/04/29.
//

import SwiftUI

struct PolicyDetailView: View {
    var policy: Policy
    
    var body: some View {
        VStack {
            Text("정책명 : \(policy.title)")
            Text("정책설명 : \(policy.content)")
            Text("신청가능 나이 : \(policy.reqAge)")
            Text("신청절차 : \(policy.procedure)")
            Text("신청가능기간 : \(policy.period)")
            Text("URL : \(policy.siteURL)")
        }
    }
}

//struct PolicyDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        PolicyDetailView()
//    }
//}
