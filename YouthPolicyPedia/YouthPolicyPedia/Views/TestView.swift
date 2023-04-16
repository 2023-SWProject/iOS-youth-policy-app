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
