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
    
    @Published var accrrqiscnSet: Set<String> = []
    @Published var ageinfoSet: Set<String> = []
    @Published var bizTycdSelSet: Set<String> = []
    @Published var empmsttscnSet: Set<String> = []
    @Published var majrrqiscnSet: Set<String> = []
    @Published var plcytpnmSet: Set<String> = []
    @Published var splzrlmrqiscnSet: Set<String> = []

    func arrayToSet() {
        for i in 0..<policies.count {
            accrrqiscnSet.insert(policies[i].reqEducation)
            ageinfoSet.insert(policies[i].reqAge)
            bizTycdSelSet.insert(policies[i].locationCode)
            empmsttscnSet.insert(policies[i].reqEmploymentStatus)
            majrrqiscnSet.insert(policies[i].reqMajor)
            plcytpnmSet.insert(policies[i].type)
            splzrlmrqiscnSet.insert(policies[i].reqSpecializedField)
        }
    }
    
    
    @Published var policies = [Policy]()
    
    let database = Firestore.firestore()
    
    func fetchPolicies() {
        
        print("fetch start")
        database.collection("NewTestData")
//        database.collection("NewData")
        ///
        /// 전체 데이터 패치 후
        /// Set 이용해서 선택 항목 추리기
        // TODO: 항목이 너무 많음..
        /// 자신의 상태 고르는 화면 구성
        /// 매개변수 쿼리에 넣어주기
        ///
        // TODO: 퀴리할 매개변수 넣어주기
        
//            .whereField("accrrqiscn", in: ["제한없음", "-", "- 제한없음", "null"]) // 참여요건 - 전공 선택추가
//            .whereField("ageinfo", in: ["제한없음", "만 18세 ~ 39세"])            // 선택한 나이 선택추가 -> 나이 변환
//            .whereField("bizTycdSel", in: [])                                 // 선택한 지역 코드 추가하기
//            .whereField("empmsttscn", in: [])                                 // 참여요건 - 취업상태 추가하기
//            .whereField("majrrqiscn", in: [])                                 // 참여요건 - 전공 추가하기
//            .whereField("plcytpnm", in: [])                                   // 정책유형 선택
//            .whereField("splzrlmrqiscn", in: [])                              // 참여요건 - 특화분야
        
        
        
//            .whereField("polybizsjnm", isEqualTo: "2022 취업지원대상자 취업능력개발비용 지원")
        
        
        
            .getDocuments { (snapshot, error) in
                self.policies.removeAll()
                
                if let snapshot {
                    for document in snapshot.documents {
//                        let id: String = document.documentID
                        
                        let docData = document.data()
                        
                        let locationCode: String = docData["bizTycdSel"] as? String ?? ""
                        let bizid: String = docData["bizid"] as? String ?? ""
//                        var polybizty: String = docData["polybizty"] as? String ?? ""
                        let title: String = docData["polybizsjnm"] as? String ?? ""
//                        var polyitcncn: String = docData["polyitcncn"] as? String ?? ""
                        let type: String = docData["plcytpnm"] as? String ?? ""
//                        var sporscvl: String = docData["sporscvl"] as? String ?? ""
                        let content: String = docData["sporcn"] as? String ?? ""
                        let reqAge: String = docData["ageinfo"] as? String ?? ""
                        let reqEmploymentStatus: String = docData["empmsttscn"] as? String ?? ""
                        let reqEducation: String = docData["accrrqiscn"] as? String ?? ""
                        let reqMajor: String = docData["majrrqiscn"] as? String ?? ""
                        let reqSpecializedField: String = docData["splzrlmrqiscn"] as? String ?? ""
//                        var cnsgnmor: String = docData["cnsgnmor"] as? String ?? ""
                        let period: String = docData["rqutprdcn"] as? String ?? ""
                        let procedure: String = docData["qutproccn"] as? String ?? ""
//                        var jdgnprescn: String = docData["jdgnprescn"] as? String ?? ""
                        let siteURL: String = docData["rquturla"] as? String ?? ""
                                                
                        let policiesData: Policy = Policy(locationCode: locationCode, bizid: bizid, title: title, type: type,  content: content, reqAge: reqAge, reqEmploymentStatus: reqEmploymentStatus, reqEducation: reqEducation, reqMajor: reqMajor, reqSpecializedField: reqSpecializedField, period: period, procedure: procedure, siteURL: siteURL)

                        self.policies.append(policiesData)
                    }
                }
            }
        
        print("fetch complete")
    }
}
