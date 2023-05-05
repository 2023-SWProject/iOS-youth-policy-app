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
    // MARK: - [Deprecated]
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
    
    // MARK:  .-

    @Published var pageNumber = 0
    
    // MARK: - 사용자 선택하는 변수 -
    @Published var selectedLocation = ""
    @Published var selectedDetailLocation: [String] = []
    
    var detailLocation: [String] = []
    
    
    // MARK: - 지역 선택시 상세지역 반환 하는 함수 -
    func giveDetailLocation(_ selectedLocation: String) -> [String] {
        switch selectedLocation {
        case "서울": return ["강남구", "강동구", "강북구", "강서구", "관악구", "광진구", "구로구", "금천구", "노원구", "도봉구", "동대문구", "동작구", "마포구", "서대문구", "서초구", "성동구", "성북구", "송파구", "양천구", "영등포구", "용산구", "은평구", "종로구", "중구", "중랑구"]
        case "부산": return ["강서구", "금정구", "기장군", "남구", "동구", "동래구", "부산진구", "북구", "사상구", "사하구", "서구", "수영구", "연제구", "영도구", "중구", "해운대구"]
        case "대구": return ["남구", "달서구", "달성군", "동구", "북구", "서구", "수성구", "중구"]
        case "인천": return ["강화군", "계양구", "남구", "남동구", "동구", "미추홀구", "부평구", "서구", "연수구", "옹진군", "중구"]
        case "광주": return ["광산", "남구", "동구", "북구", "서구"]
        case "대전": return ["대덕구", "동구", "서구", "유성구", "중구"]
        case "울산": return ["남구", "동구", "북구", "울주군", "중구"]
        case "경기": return ["가평군", "고양시", "과천시", "광명시", "광주시", "구리시", "군포시", "김포시", "남양주시", "동두천시", "부천시", "성남시", "수원시", "시흥시", "안산시", "안성시", "안양시", "양주군", "양주시", "양평군", "여주군", "여주시", "연천군", "오산시", "용인시", "의왕시", "의정부시", "이천시", "파주시", "평택시", "포천군", "포천시", "하남시", "화성시"]
        case "강원": return ["강릉시", "고성군", "동해시", "삼척시", "속초시", "양구군", "양양군", "영월군", "원주시", "인제군", "정선군", "철원군", "춘천시", "태백시", "평창군", "홍천군", "화천군", "횡성군"]
        case "충북": return ["괴산군", "단양군", "보은군", "영동군", "옥천군", "음성군", "제천시", "증평군", "진천군", "청원군", "청주시", "충주시"]
        case "충남": return ["계룡시", "공주시", "금산군", "논산시", "당진군", "당진시", "보령시", "부여군", "서산시", "서천군", "아산시", "연기군", "예산군", "천안시", "청양군", "태안군", "홍성군"]
        case "전북": return ["고창군", "군산시", "김제시", "남원시", "무주군", "부안군", "순창군", "완주군", "익산시", "임실군", "장수군", "전주시", "정읍시", "진안군"]
        case "전남": return ["강진군", "고흥군", "곡성군", "광양시", "구례군", "나주시", "담양군", "목포시", "무안군", "보성군", "순천시", "신안군", "여수시", "영광군", "영암군", "완도군", "장성군", "장흥군", "진도군", "함평군", "해남군", "화순군"]
        case "경북": return ["경산시", "경주시", "고령군", "구미시", "군위군", "김천시", "문경시", "봉화군", "상주시", "성주군", "안동시", "영덕군", "영양군", "영주시", "영천시", "예천군", "울릉군", "울진군", "의성군", "청도군", "청송군", "칠곡군", "포항시"]
        case "경남": return ["거제시", "거창군", "고성군", "김해시", "남해군", "마산시", "밀양시", "사천시", "산청군", "양산시", "의령군", "진주시", "진해시", "창녕군", "창원시", "통영시", "하동군", "함안군", "함양군", "합천군"]
        case "제주": return ["남제주군", "북제주군", "서귀포시", "제주시"]
        case "세종": return ["세종"]
        default: return ["default"]
        }
    }
    
    // MARK: - 데이터 부분
    @Published var policies = [Policy]()
    @Published var myAge = ""
    
    let database = Firestore.firestore()
    
    // MARK: - 데이터 fetch -
    func fetchPolicies(myAge: Int) {
        
        print("fetch start")
        database.collection("PolicyData")
        /// 매개변수 쿼리에 넣어주기
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
                        let introduction: String = docData["polyitcncn"] as? String ?? ""
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
                        // 나이 숫자 [0, 1, 2, 3, 4, 5] 까지 예외 처리 -> 테스트 필요
                        // 나이 String 에서 숫자만 필터링
                        let ages = reqAge.filter {
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
                        // MARK: 나이 필터링 끝 -
                        
                        let policiesData: Policy = Policy(detailType: detailType, bizid: bizid, title: title, introduction: introduction, type: type,  content: content, reqAge: reqAge, reqEmploymentStatus: reqEmploymentStatus, reqEducation: reqEducation, reqMajor: reqMajor, reqSpecializedField: reqSpecializedField, period: period, procedure: procedure, siteURL: siteURL, locationCode: locationCode)

                        self.policies.append(policiesData)
                    }
                }
            }
        print("fetch complete")
    }
}
