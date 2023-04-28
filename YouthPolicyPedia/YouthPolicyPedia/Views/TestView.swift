//
//  TestView.swift
//  YouthPolicyPedia
//
//  Created by 김태성 on 2023/04/16.
//

import SwiftUI

struct TestView: View {
    @StateObject var policyStore: PolicyStore = PolicyStore()
    
    var body: some View {
        VStack {
            
            List(policyStore.policies, id: \.bizid) { policy in
                Text("정책명 : \(policy.title)")
                Text("가능 나이 : \(policy.reqAge)")
                Text("신청절차 : \(policy.procedure)")
                Text("신청가능기간 : \(policy.period)")
                Text("URL : \(policy.siteURL)")
            }
            
            Spacer()
            
            Button {
                policyStore.fetchPolicies()
            } label: {
                Text("패치")
            }

            Button {
                print(policyStore.policies)
            } label: {
                Text("프린트")
            }
            
            Button {
                print(policyStore.policies.count)
            } label: {
                Text("개수 프린트")
            }
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
