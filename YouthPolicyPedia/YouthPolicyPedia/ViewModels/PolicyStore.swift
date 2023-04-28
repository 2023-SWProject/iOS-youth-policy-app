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
        database.collection("TestData")
            .getDocuments { (snapshot, error) in
                self.policies.removeAll()
                
                if let snapshot {
                    for document in snapshot.documents {
//                        let id: String = document.documentID
                        
                        let docData = document.data()
                        
                        let serialNumber: String = docData["bizTycdSel"] as? String ?? ""
                        let bizid: String = docData["bizid"] as? String ?? ""
//                        var polybizty: String = docData["polybizty"] as? String ?? ""
                        let title: String = docData["polybizsjnm"] as? String ?? ""
//                        var polyitcncn: String = docData["polyitcncn"] as? String ?? ""
//                        var plcytpnm: String = docData["plcytpnm"] as? String ?? ""
//                        var sporscvl: String = docData["sporscvl"] as? String ?? ""
                        let content: String = docData["sporcn"] as? String ?? ""
                        let reqAge: String = docData["ageinfo"] as? String ?? ""
//                        var empmsttscn: String = docData["empmsttscn"] as? String ?? ""
//                        var accrrqiscn: String = docData["accrrqiscn"] as? String ?? ""
//                        var majrrqiscn: String = docData["majrrqiscn"] as? String ?? ""
//                        var splzrlmrqiscn: String = docData["splzrlmrqiscn"] as? String ?? ""
//                        var cnsgnmor: String = docData["cnsgnmor"] as? String ?? ""
                        let period: String = docData["rqutprdcn"] as? String ?? ""
                        let procedure: String = docData["qutproccn"] as? String ?? ""
//                        var jdgnprescn: String = docData["jdgnprescn"] as? String ?? ""
                        let siteURL: String = docData["rquturla"] as? String ?? ""
                                                
                        let policiesData: Policy = Policy(serialNumber: serialNumber, bizid: bizid, title: title, content: content, reqAge: reqAge, period: period, procedure: procedure, siteURL: siteURL)

                        self.policies.append(policiesData)
                    }
                }
            }
        
        print("fetch complete")
    }
}
