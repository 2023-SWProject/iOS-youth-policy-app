//
//  PolicyStore.swift
//  YouthPolicyPedia
//
//  Created by 김태성 on 2023/04/16.
//

import Foundation
import Firebase
import FirebaseFirestore

class PolicyStore: ObservableObject {
    @Published var policies = [Policy]()
    
    let database = Firestore.firestore()
    
    func fetchPolicies() {
        
        print("fetch start")
        database.collection("NewData")
            .getDocuments { (snapshot, error) in
                self.policies.removeAll()
                
                if let snapshot {
                    for document in snapshot.documents {
//                        let id: String = document.documentID
                        
                        let docData = document.data()
                        
                        let bizTycdSelq: String = docData["bizTycdSel"] as? String ?? ""
                        let bizidq: String = docData["bizid"] as? String ?? ""
//                        var polybiztyq: String = docData["polybizty"] as? String ?? ""
//                        var polybizsjnmq: String = docData["polybizsjnm"] as? String ?? ""
//                        var polyitcncnq: String = docData["polyitcncn"] as? String ?? ""
//                        var plcytpnmq: String = docData["plcytpnm"] as? String ?? ""
//                        var sporscvlq: String = docData["sporscvl"] as? String ?? ""
//                        var sporcnq: String = docData["bizTycdSel"] as? String ?? ""
//                        var ageinfoq: String = docData["bizTycdSel"] as? String ?? ""
//                        var empmsttscnq: String = docData["bizTycdSel"] as? String ?? ""
//                        var accrrqiscnq: String = docData["bizTycdSel"] as? String ?? ""
//                        var majrrqiscnq: String = docData["bizTycdSel"] as? String ?? ""
//                        var splzrlmrqiscnq: String = docData["bizTycdSel"] as? String ?? ""
//                        var cnsgnmorq: String = docData["bizTycdSel"] as? String ?? ""
//                        var rqutprdcnq: String = docData["bizTycdSel"] as? String ?? ""
//                        var qutproccnq: String = docData["bizTycdSel"] as? String ?? ""
//                        var jdgnprescnq: String = docData["bizTycdSel"] as? String ?? ""
//                        var rquturlaq: String = docData["bizTycdSel"] as? String ?? ""
                        
                        
                        let policiesData: Policy = Policy(bizTycdSel: bizTycdSelq, bizid: bizidq)
                        
//                        let policiesData: Policy = Policy(bizTycdSel: bizTycdSelq, bizid: bizidq, polybizty: polybiztyq, polybizsjnm: polybizsjnmq, polyitcncn: polyitcncnq, plcytpnm: plcytpnmq, sporscvl: sporscvlq, sporcn: sporcnq, ageinfo: ageinfoq, empmsttscn: empmsttscnq, accrrqiscn: accrrqiscnq, majrrqiscn: majrrqiscnq, splzrlmrqiscn: splzrlmrqiscnq, cnsgnmor: cnsgnmorq, rqutprdcn: rqutprdcnq, qutproccn: qutproccnq, jdgnprescn: jdgnprescnq, rquturla: rquturlaq)
                        
                        self.policies.append(policiesData)
                    }
                }
            }
        
        print("fetch complete")
    }
}
