//
//  Tex.swift
//  YouthPolicyPedia
//
//  Created by 김태성 on 2023/05/06.
//

import SwiftUI

struct Tex: View {
    
    @EnvironmentObject var policyStore: PolicyStore
    
    var body: some View {
        VStack {
            Text("\(policyStore.userAge)")
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                print("처음 나오는 로케이션 : \(policyStore.selectedDetailLocation)")
//                print("\(policyStore.deta)")
                print("\(UserDefaults.standard.dictionary(forKey: "myDetailLocation"))")
                policyStore.selectedDetailLocation = UserDefaults.standard.dictionary(forKey: "myDetailLocation") as? [String: String] ?? ["11":"22"]
                print("\(policyStore.selectedDetailLocation)")
            }
        }
    }
}

struct Tex_Previews: PreviewProvider {
    static var previews: some View {
        Tex()
    }
}
