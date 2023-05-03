//
//  SetFilterTestView.swift
//  YouthPolicyPedia
//
//  Created by 김태성 on 2023/05/01.
//


//@Published var accrrqiscnSet: Set<String> = []
//@Published var ageinfoSet: Set<String> = []
//@Published var bizTycdSelSet: Set<String> = []
//@Published var empmsttscnSet: Set<String> = []
//@Published var majrrqiscnSet: Set<String> = []
//@Published var plcytpnmSet: Set<String> = []
//@Published var splzrlmrqiscnSet: Set<String> = []


import SwiftUI

struct SetFilterTestView: View {
    @EnvironmentObject var policyStore: PolicyStore
    
    var body: some View {
        VStack {
            Text("\(policyStore.accrrqiscnSet.count)")
            Text("\(policyStore.ageinfoSet.count)")
            Text("\(policyStore.bizTycdSelSet.count)")
            Text("\(policyStore.empmsttscnSet.count)")
            Text("\(policyStore.majrrqiscnSet.count)")
            Text("\(policyStore.plcytpnmSet.count)")
            Text("\(policyStore.splzrlmrqiscnSet.count)")
            Text("\(policyStore.polyBizSecdSet.count)")
        }
        .onAppear {
            policyStore.fetchPolicies(myAge: Int(policyStore.myAge) ?? 0)
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                policyStore.arrayToSet()
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                    print(policyStore.accrrqiscnSet)
                    print(policyStore.ageinfoSet)
                    print(policyStore.bizTycdSelSet)
                    print(policyStore.empmsttscnSet)
                    print(policyStore.majrrqiscnSet)
                    print(policyStore.plcytpnmSet)
                    print(policyStore.splzrlmrqiscnSet)
                    print(policyStore.polyBizSecdSet)
                    
                    
//                    var ages = policyStore.ageinfoSet.map {
//                        $0.filter {
//                            $0.isNumber
//                        }
//                    }
//                    
//                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
//                        var ageNumCount = ages.map { $0.count }
//                        var ageSet = Set(ageNumCount)
//                        print(ageSet)
//                    }
                }
            }
            
        }
    }
}

struct SetFilterTestView_Previews: PreviewProvider {
    static var previews: some View {
        SetFilterTestView()
    }
}
