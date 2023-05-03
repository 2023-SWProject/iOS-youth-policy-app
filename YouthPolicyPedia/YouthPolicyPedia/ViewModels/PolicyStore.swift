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
    @Published var polyBizSecdSet: Set<String> = []
    
    func arrayToSet() {
        for i in 0..<policies.count {
            accrrqiscnSet.insert(policies[i].reqEducation)
            ageinfoSet.insert(policies[i].reqAge)
            bizTycdSelSet.insert(policies[i].detailType)
            empmsttscnSet.insert(policies[i].reqEmploymentStatus)
            majrrqiscnSet.insert(policies[i].reqMajor)
            plcytpnmSet.insert(policies[i].type)
            splzrlmrqiscnSet.insert(policies[i].reqSpecializedField)
            polyBizSecdSet.insert(policies[i].locationCode)
        }
    }
    
    @Published var policies = [Policy]()
    @Published var myAge = ""
    
    let database = Firestore.firestore()
    
    // MARK: - 데이터 fetch
    func fetchPolicies(myAge: Int) {
        // TODO: myAge 매개변수로 받아주기
//        var myAge = 1
        
        print("fetch start")
//        database.collection("NewTestData")
        database.collection("PolicyData")
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
        
        
        // TODO: 지역 코드 생성해서 매개변수 넣어주기
            .whereField("polyBizSecd", in: ["003002011", "003002011001"]) // 현재 [충남, 천안] 선택 상태
//            .whereField("polybizsjnm", isEqualTo: "2022 취업지원대상자 취업능력개발비용 지원")
        
            .getDocuments { (snapshot, error) in
                self.policies.removeAll()
                
                if let snapshot {
                    for document in snapshot.documents {
//                        let id: String = document.documentID
                        
                        let docData = document.data()
                        
                        let detailType: String = docData["bizTycdSel"] as? String ?? ""
                        let bizid: String = docData["bizid"] as? String ?? ""
//                        var polybizty: String = docData["polybizty"] as? String ?? ""
                        let title: String = docData["polybizsjnm"] as? String ?? ""
//                        var polyitcncn: String = docData["polyitcncn"] as? String ?? ""
                        let type: String = docData["plcytpnm"] as? String ?? ""
//                        var sporscvl: String = docData["sporscvl"] as? String ?? ""
                        let content: String = docData["sporcn"] as? String ?? ""
                        let reqAge: String = docData["ageinfo"] as? String ?? ""                      // 나이
                        let reqEmploymentStatus: String = docData["empmsttscn"] as? String ?? ""
                        let reqEducation: String = docData["accrrqiscn"] as? String ?? ""
                        let reqMajor: String = docData["majrrqiscn"] as? String ?? ""
                        let reqSpecializedField: String = docData["splzrlmrqiscn"] as? String ?? ""
//                        var cnsgnmor: String = docData["cnsgnmor"] as? String ?? ""
                        let period: String = docData["rqutprdcn"] as? String ?? ""
                        let procedure: String = docData["qutproccn"] as? String ?? ""
//                        var jdgnprescn: String = docData["jdgnprescn"] as? String ?? ""
                        let siteURL: String = docData["rquturla"] as? String ?? ""
                        let locationCode: String = docData["polyBizSecd"] as? String ?? ""

                        
                        // MARK: - 나이 필터링
                        // TODO: 나이 숫자 [0, 1, 2, 3, 4, 5] 까지 예외 처리하기 -> 테스트 필요
                        // 나이 String 에서 숫자만 필터링
                        var ages = reqAge.filter {
                            $0.isNumber
                        }
                        
                        let ageNumberCount = ages.count
                        
                        switch ageNumberCount {
                        case 0:
                            print("0 -> pass")
                        case 1:
                            print("1 -> pass")
                        case 2:
                            print("2")
                            // 두개일 경우 원본 나이에서 '이상'이 들어가는지 '이하'가 들어가는지 판단후 00 앞에 붙이거나 99 를 뒤에 붙인다.
                            // ex) 만 18세 이상 -> 1899
                            //     만 30세 이하 -> 0030
                            var age1 = "00"
                            var age2 = "00"
                            
                            if reqAge.contains("이상") {
                                age1 = ages
                                age2 = "99"
                            } else if reqAge.contains("이하") {
                                age1 = "00"
                                age2 = ages
                            } else {
                                print("case 2 예외")
                            }
                            
                            guard Int(age1)! <= myAge && myAge <= Int(age2)! else { continue }
                        case 3:
                            print("3")
                            
                            // ex) 만 100세 이하
                            guard !(ages.contains("이하")) else { continue }
                            
                            // ex) 만 0세 ~ 30세
                            let age1: String = "0" + String(String(ages).prefix(1))
                            let age2: String = String(String(ages).suffix(2))
                            
                            guard Int(age1)! <= myAge && myAge <= Int(age2)! else { continue }
                        case 4:
                            print("4")
//                            guard ages.count == 4 else { continue }

                            let age1: String = String(String(ages).prefix(2))
                            let age2: String = String(String(ages).suffix(2))

                            guard Int(age1)! <= myAge && myAge <= Int(age2)! else { continue }
                        case 5:
                            // ex) 만 10세 ~ 999세
                            print("5")
                            
                            let age1: String = String(String(ages).prefix(2))
                            let age2: String = "99"
                            
                            guard Int(age1)! <= myAge && myAge <= Int(age2)! else { continue }
                        default:
                            print("default -> pass")
                        }
                        // MARK: - 나이 필터링 끝
                        
                        let policiesData: Policy = Policy(detailType: detailType, bizid: bizid, title: title, type: type,  content: content, reqAge: reqAge, reqEmploymentStatus: reqEmploymentStatus, reqEducation: reqEducation, reqMajor: reqMajor, reqSpecializedField: reqSpecializedField, period: period, procedure: procedure, siteURL: siteURL, locationCode: locationCode)

                        self.policies.append(policiesData)
                    }
                }
            }
        print("fetch complete")
    }
}
