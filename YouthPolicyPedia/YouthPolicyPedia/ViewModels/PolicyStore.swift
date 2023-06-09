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
    @Published var pageNumber = -2
    
    // MARK: - 사용자 선택하는 변수 -
    @Published var selectedLocation: [String: String] = ((UserDefaults.standard.dictionary(forKey: "myLocation") ?? [:]) as? [String: String] ?? [:])
    @Published var selectedDetailLocation: [String: String] = ((UserDefaults.standard.dictionary(forKey: "myDetailLocation") ?? [:]) as? [String: String] ?? [:])
    
    @Published var userAge: Int = UserDefaults.standard.integer(forKey: "myAge")
//    @Published var education: [String] = ((UserDefaults.standard.array(forKey: "myEducation") ?? []) as? [String] ?? [])
    
    // MARK: - 쿼리 변수
    var ArrayForLocationQuery: [String] = []
    @Published var eduQuery: [String] = ((UserDefaults.standard.array(forKey: "myEdu") ?? []) as? [String] ?? [])
    @Published var empQuery: [String] = ((UserDefaults.standard.array(forKey: "myEmp") ?? []) as? [String] ?? [])
    @Published var speQuery: [String] = ((UserDefaults.standard.array(forKey: "mySpe") ?? []) as? [String] ?? [])
    @Published var incomeQuery: [String] = ((UserDefaults.standard.array(forKey: "myIncome") ?? []) as? [String] ?? [])
    
    @Published var 무주택자: String = ""
    @Published var 년제학교: String = ""
    @Published var 일인가구: String = ""
    @Published var 신혼부부: String = ""
    @Published var 농업인: String = ""
    @Published var 소상공인: String = ""
    @Published var 차상위계층: String = ""
    @Published var 기초생활및생계급여: String = ""
    
    // MARK: - 지역 선택시 상세지역 반환 하는 함수
    var detailLocation: [String: String] = [:] // 변환 변수
    
    func giveDetailLocation(_ selectedLocation: String) -> [String: String] {
        switch selectedLocation {
        case "서울": return ["성동구": "003002001004", "강북구": "003002001009", "동대문구": "003002001006", "중구": "003002001002", "마포구": "003002001014", "도봉구": "003002001010", "관악구": "003002001021", "중랑구": "003002001007", "용산구": "003002001003", "서대문구": "003002001013", "영등포구": "003002001019", "서초구": "003002001022", "송파구": "003002001024", "금천구": "003002001018", "구로구": "003002001017", "강남구": "003002001023", "광진구": "003002001005", "동작구": "003002001020", "종로구": "003002001001", "성북구": "003002001008", "은평구": "003002001012", "강동구": "003002001025", "강서구": "003002001016", "양천구": "003002001015", "노원구": "003002001011"]
        case "부산": return ["서구": "003002002002", "부산진구": "003002002005", "동구": "003002002003", "중구": "003002002001", "사하구": "003002002010", "동래구": "003002002006", "사상구": "003002002015", "기장군": "003002002016", "강서구": "003002002012", "수영구": "003002002014", "남구": "003002002007", "영도구": "003002002004", "연제구": "003002002013", "북구": "003002002008", "해운대구": "003002002009", "금정구": "003002002011"]
        case "대구": return ["동구": "003002003002", "중구": "003002003001", "북구": "003002003005", "달서구": "003002003007", "서구": "003002003003", "수성구": "003002003006", "남구": "003002003004", "달성군": "003002003008"]
        case "인천": return ["미추홀구": "003002004004", "남구": "003002004003", "부평구": "003002004007", "연수구": "003002004005", "동구": "003002004002", "계양구": "003002004008", "강화군": "003002004010", "옹진군": "003002004011", "남동구": "003002004006", "중구": "003002004001", "서구": "003002004009"]
        case "광주": return ["북구": "003002005004", "광산": "003002005005", "남구": "003002005003", "동구": "003002005001", "서구": "003002005002"]
        case "대전": return ["동구": "003002006001", "중구": "003002006002", "서구": "003002006003", "유성구": "003002006004", "대덕구": "003002006005"]
        case "울산": return ["중구": "003002007001", "울주군": "003002007005", "북구": "003002007004", "동구": "003002007003", "남구": "003002007002"]
        case "경기": return ["양주시": "003002008026", "하남시": "003002008018", "구리시": "003002008012", "성남시": "003002008002", "안성시": "003002008022", "안산시": "003002008009", "연천군": "003002008031", "포천군": "003002008032", "고양시": "003002008010", "과천시": "003002008011", "화성시": "003002008024", "이천시": "003002008021", "군포시": "003002008016", "남양주시": "003002008013", "광주시": "003002008025", "평택시": "003002008007", "파주시": "003002008020", "포천시": "003002008027", "광명시": "003002008006", "오산시": "003002008014", "수원시": "003002008001", "안양시": "003002008004", "여주군": "003002008030", "가평군": "003002008033", "여주시": "003002008028", "김포시": "003002008023", "양평군": "003002008034", "부천시": "003002008005", "시흥시": "003002008015", "용인시": "003002008019", "동두천시": "003002008008", "양주군": "003002008029", "의왕시": "003002008017", "의정부시": "003002008003"]
        case "강원": return ["양구군": "003002009015", "횡성군": "003002009009", "속초시": "003002009006", "춘천시": "003002009001", "정선군": "003002009012", "태백시": "003002009005", "영월군": "003002009010", "원주시": "003002009002", "인제군": "003002009016", "평창군": "003002009011", "동해시": "003002009004", "강릉시": "003002009003", "홍천군": "003002009008", "고성군": "003002009017", "삼척시": "003002009007", "철원군": "003002009013", "화천군": "003002009014", "양양군": "003002009018"]
        case "충북": return ["영동군": "003002010007", "괴산군": "003002010010", "충주시": "003002010002", "청주시": "003002010001", "옥천군": "003002010006", "진천군": "003002010009", "음성군": "003002010011", "제천시": "003002010003", "청원군": "003002010004", "보은군": "003002010005", "증평군": "003002010008", "단양군": "003002010012"]
        case "충남": return ["태안군": "003002011016", "예산군": "003002011015", "당진시": "003002011008", "청양군": "003002011013", "홍성군": "003002011014", "천안시": "003002011001", "계룡시": "003002011007", "서천군": "003002011012", "공주시": "003002011002", "금산군": "003002011009", "부여군": "003002011011", "보령시": "003002011003", "아산시": "003002011004", "당진군": "003002011017", "연기군": "003002011010", "서산시": "003002011005", "논산시": "003002011006"]
        case "전북": return ["군산시": "003002012002", "부안군": "003002012014", "무주군": "003002012009", "남원시": "003002012005", "김제시": "003002012006", "순창군": "003002012012", "임실군": "003002012011", "고창군": "003002012013", "정읍시": "003002012004", "완주군": "003002012007", "익산시": "003002012003", "장수군": "003002012010", "진안군": "003002012008", "전주시": "003002012001"]
        case "전남": return ["담양군": "003002013006", "나주시": "003002013004", "보성군": "003002013010", "여수시": "003002013002", "곡성군": "003002013007", "광양시": "003002013005", "함평군": "003002013017", "고흥군": "003002013009", "장성군": "003002013019", "진도군": "003002013021", "신안군": "003002013022", "순천시": "003002013003", "화순군": "003002013011", "영광군": "003002013018", "구례군": "003002013008", "해남군": "003002013014", "강진군": "003002013013", "목포시": "003002013001", "영암군": "003002013015", "완도군": "003002013020", "장흥군": "003002013012", "무안군": "003002013016"]
        case "경북": return ["문경시": "003002014009", "경산시": "003002014010", "구미시": "003002014005", "예천군": "003002014020", "포항시": "003002014001", "청송군": "003002014013", "고령군": "003002014017", "울진군": "003002014022", "울릉군": "003002014023", "김천시": "003002014003", "군위군": "003002014011", "의성군": "003002014012", "안동시": "003002014004", "영주시": "003002014006", "봉화군": "003002014021", "영덕군": "003002014015", "영천시": "003002014007", "경주시": "003002014002", "영양군": "003002014014", "상주시": "003002014008", "청도군": "003002014016", "성주군": "003002014018", "칠곡군": "003002014019"]
        case "경남": return ["양산시": "003002015010", "함안군": "003002015012", "통영시": "003002015005", "밀양시": "003002015008", "남해군": "003002015015", "김해시": "003002015007", "진해시": "003002015004", "사천시": "003002015006", "산청군": "003002015017", "거제시": "003002015009", "합천군": "003002015020", "고성군": "003002015014", "마산시": "003002015002", "창녕군": "003002015013", "진주시": "003002015003", "하동군": "003002015016", "창원시": "003002015001", "의령군": "003002015011", "함양군": "003002015018", "거창군": "003002015019"]
        case "제주": return ["서귀포시": "003002016002", "남제주군": "003002016004", "제주시": "003002016001", "북제주군": "003002016003"]
        case "세종": return ["세종": "003002017001"]
        default: return ["name": "code"]
        }
    }
    
    // MARK: - 지역 코드 쿼리를 위해 코드만 빼주는 함수
    func locationStringToCode(_ selectedLocation: [String: String], selectedDetailLocation: [String: String]) -> [String] {
        var arr: [String] = []
        
        for code in selectedLocation.values {
            arr.append(code)
        }
        
        for code in selectedDetailLocation.values {
            arr.append(code)
        }
        
        return arr
    }
    
    // MARK: - 데이터 부분
    @Published var policies = [Policy]()
    
    let database = Firestore.firestore()
    
    // MARK: - 데이터 fetch -
    func fetchPolicies(userAge: Int) {
        print("fetch start")
        let eduCount = eduQuery.count
        let empCount = empQuery.count
        let speCount = speQuery.count
        let incomeCount = incomeQuery.count
        
        if incomeCount >= 2 { // 소득분위 안골랐을 경우 -> "-" 값만 있을경우
            // 쿼리 추가해줘야됨
            if speCount > 0 && empCount > 0 && eduCount > 0 {
                var innerEduQuery = eduQuery
                var innerEmpQuery = empQuery
                var innerSpeQuery = speQuery
                innerEduQuery.append("8") // "제한없음"에 해당하는 것들 무조건 포함 시키기 위해 추가 8
                innerEmpQuery.append("8") // "제한없음"에 해당하는 것들 무조건 포함 시키기 위해 추가 8
                innerSpeQuery.append("7") // "제한없음"에 해당하는 것들 무조건 포함 시키기 위해 추가 7
                innerEduQuery.append("9") // "???"에 해당하는 것들 무조건 포함 시키기 위해 추가 9
                innerEmpQuery.append("9") // "???"에 해당하는 것들 무조건 포함 시키기 위해 추가 9
                innerSpeQuery.append("8") // "???"에 해당하는 것들 무조건 포함 시키기 위해 추가 8
                
                database.collection("PolicyData_603")
                    .whereField("polyBizSecd", in: ArrayForLocationQuery.compactMap { Int($0) }) // 지역 필터링
                    .whereField("ageinfoTt", isGreaterThanOrEqualTo: userAge) // 나이 필터링
                    .whereFilter(Filter.orFilter([
                        Filter.whereField("accrrqiscnTt", arrayContainsAny: innerEduQuery), // 학력
                        Filter.whereField("empmsttscnTt", arrayContainsAny: innerEmpQuery), // 고용
                        Filter.whereField("splzrlmrqiscnTt", arrayContainsAny: innerSpeQuery), // 특화
                        Filter.whereField("aidSection", arrayContainsAny: incomeQuery) // 소득분위
                                ]))
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
                                let 신혼부부: String = docData["신혼부부"] as? String ?? ""
                                let tags: String = docData["plcytpnm"] as? String ?? ""
                                let 일인가구: String = docData["1인가구여부"] as? String ?? ""
                                let 농업인: String = docData["농업인"] as? String ?? ""
                                let 소상공인: String = docData["소상공인"] as? String ?? ""
                                let 차상위계층: String = docData["차상위계층"] as? String ?? ""
                                let 기초생활및생계급여: String = docData["기초생활및생계급여"] as? String ?? ""
                                let 무주택자: String = docData["homelessWhether"] as? String ?? ""
                                
                                // 임시 쿼리 확인차 선언
    //                            let 일인가구여부: String = docData["1인가구여부"] as? String ?? "nil"
                                let splzrlmrqiscnTt: [String] = docData["splzrlmrqiscnTt"] as? [String] ?? ["nil"]
                                
                                let policiesData: Policy = Policy(detailType: detailType, bizid: bizid, title: title, introduction: introduction, type: type,  content: content, reqAge: reqAge, reqEmploymentStatus: reqEmploymentStatus, reqEducation: reqEducation, reqMajor: reqMajor, reqSpecializedField: reqSpecializedField, period: period, procedure: procedure, siteURL: siteURL, locationCode: locationCode, 신혼부부: 신혼부부, tags: tags, 일인가구: 일인가구, 농업인: 농업인, 소상공인: 소상공인, 차상위계층: 차상위계층, 기초생활및생계급여: 기초생활및생계급여, 무주택자: 무주택자)

                                print(splzrlmrqiscnTt)
                                self.policies.append(policiesData)
                            }
                        }
                    }
            } else if eduCount > 0 && empCount == 0 && speCount == 0 { // edu만 골랐을 경우
                var innerEduQuery = eduQuery
                var innerEmpQuery = empQuery
                var innerSpeQuery = speQuery
                innerEduQuery.append("8") // "제한없음"에 해당하는 것들 무조건 포함 시키기 위해 추가 8
                innerEmpQuery.append("8") // "제한없음"에 해당하는 것들 무조건 포함 시키기 위해 추가 8
                innerSpeQuery.append("7") // "제한없음"에 해당하는 것들 무조건 포함 시키기 위해 추가 7
                innerEduQuery.append("9") // "???"에 해당하는 것들 무조건 포함 시키기 위해 추가 9
                innerEmpQuery.append("9") // "???"에 해당하는 것들 무조건 포함 시키기 위해 추가 9
                innerSpeQuery.append("8") // "???"에 해당하는 것들 무조건 포함 시키기 위해 추가 8
                
                database.collection("PolicyData_603")
                    .whereField("polyBizSecd", in: ArrayForLocationQuery.compactMap { Int($0) }) // 지역 필터링
                    .whereField("ageinfoTt", isGreaterThanOrEqualTo: userAge) // 나이 필터링
                    .whereFilter(Filter.orFilter([
                        Filter.whereField("accrrqiscnTt", arrayContainsAny: innerEduQuery), // 학력
    //                    Filter.whereField("empmsttscnTt", arrayContainsAny: innerEmpQuery), // 고용
    //                    Filter.whereField("splzrlmrqiscnTt", arrayContainsAny: innerSpeQuery), // 특화
                        Filter.whereField("aidSection", arrayContainsAny: incomeQuery) // 소득분위
                                ]))
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
                                let 신혼부부: String = docData["신혼부부"] as? String ?? ""
                                let tags: String = docData["plcytpnm"] as? String ?? ""
                                let 일인가구: String = docData["1인가구여부"] as? String ?? ""
                                let 농업인: String = docData["농업인"] as? String ?? ""
                                let 소상공인: String = docData["소상공인"] as? String ?? ""
                                let 차상위계층: String = docData["차상위계층"] as? String ?? ""
                                let 기초생활및생계급여: String = docData["기초생활및생계급여"] as? String ?? ""
                                let 무주택자: String = docData["homelessWhether"] as? String ?? ""
                                
                                // 임시 쿼리 확인차 선언
    //                            let 일인가구여부: String = docData["1인가구여부"] as? String ?? "nil"
                                let splzrlmrqiscnTt: [String] = docData["splzrlmrqiscnTt"] as? [String] ?? ["nil"]
                                
                                let policiesData: Policy = Policy(detailType: detailType, bizid: bizid, title: title, introduction: introduction, type: type,  content: content, reqAge: reqAge, reqEmploymentStatus: reqEmploymentStatus, reqEducation: reqEducation, reqMajor: reqMajor, reqSpecializedField: reqSpecializedField, period: period, procedure: procedure, siteURL: siteURL, locationCode: locationCode, 신혼부부: 신혼부부, tags: tags, 일인가구: 일인가구, 농업인: 농업인, 소상공인: 소상공인, 차상위계층: 차상위계층, 기초생활및생계급여: 기초생활및생계급여, 무주택자: 무주택자)

                                print(splzrlmrqiscnTt)
                                self.policies.append(policiesData)
                            }
                        }
                    }
            } else if empCount > 0 && eduCount == 0 && speCount == 0 { // emp만 골랐을 경우
                var innerEduQuery = eduQuery
                var innerEmpQuery = empQuery
                var innerSpeQuery = speQuery
                innerEduQuery.append("8") // "제한없음"에 해당하는 것들 무조건 포함 시키기 위해 추가 8
                innerEmpQuery.append("8") // "제한없음"에 해당하는 것들 무조건 포함 시키기 위해 추가 8
                innerSpeQuery.append("7") // "제한없음"에 해당하는 것들 무조건 포함 시키기 위해 추가 7
                innerEduQuery.append("9") // "???"에 해당하는 것들 무조건 포함 시키기 위해 추가 9
                innerEmpQuery.append("9") // "???"에 해당하는 것들 무조건 포함 시키기 위해 추가 9
                innerSpeQuery.append("8") // "???"에 해당하는 것들 무조건 포함 시키기 위해 추가 8
                
                database.collection("PolicyData_603")
                    .whereField("polyBizSecd", in: ArrayForLocationQuery.compactMap { Int($0) }) // 지역 필터링
                    .whereField("ageinfoTt", isGreaterThanOrEqualTo: userAge) // 나이 필터링
                    .whereFilter(Filter.orFilter([
    //                    Filter.whereField("accrrqiscnTt", arrayContainsAny: innerEduQuery), // 학력
                        Filter.whereField("empmsttscnTt", arrayContainsAny: innerEmpQuery), // 고용
    //                    Filter.whereField("splzrlmrqiscnTt", arrayContainsAny: innerSpeQuery), // 특화
                        Filter.whereField("aidSection", arrayContainsAny: incomeQuery) // 소득분위
                                ]))
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
                                let 신혼부부: String = docData["신혼부부"] as? String ?? ""
                                let tags: String = docData["plcytpnm"] as? String ?? ""
                                let 일인가구: String = docData["1인가구여부"] as? String ?? ""
                                let 농업인: String = docData["농업인"] as? String ?? ""
                                let 소상공인: String = docData["소상공인"] as? String ?? ""
                                let 차상위계층: String = docData["차상위계층"] as? String ?? ""
                                let 기초생활및생계급여: String = docData["기초생활및생계급여"] as? String ?? ""
                                let 무주택자: String = docData["homelessWhether"] as? String ?? ""
                                
                                // 임시 쿼리 확인차 선언
    //                            let 일인가구여부: String = docData["1인가구여부"] as? String ?? "nil"
                                let splzrlmrqiscnTt: [String] = docData["splzrlmrqiscnTt"] as? [String] ?? ["nil"]
                                
                                let policiesData: Policy = Policy(detailType: detailType, bizid: bizid, title: title, introduction: introduction, type: type,  content: content, reqAge: reqAge, reqEmploymentStatus: reqEmploymentStatus, reqEducation: reqEducation, reqMajor: reqMajor, reqSpecializedField: reqSpecializedField, period: period, procedure: procedure, siteURL: siteURL, locationCode: locationCode, 신혼부부: 신혼부부, tags: tags, 일인가구: 일인가구, 농업인: 농업인, 소상공인: 소상공인, 차상위계층: 차상위계층, 기초생활및생계급여: 기초생활및생계급여, 무주택자: 무주택자)

                                print(splzrlmrqiscnTt)
                                self.policies.append(policiesData)
                            }
                        }
                    }
            } else if speCount > 0 && eduCount == 0 && empCount == 0 { // spe만 골랐을 경우
                var innerEduQuery = eduQuery
                var innerEmpQuery = empQuery
                var innerSpeQuery = speQuery
                innerEduQuery.append("8") // "제한없음"에 해당하는 것들 무조건 포함 시키기 위해 추가 8
                innerEmpQuery.append("8") // "제한없음"에 해당하는 것들 무조건 포함 시키기 위해 추가 8
                innerSpeQuery.append("7") // "제한없음"에 해당하는 것들 무조건 포함 시키기 위해 추가 7
                innerEduQuery.append("9") // "???"에 해당하는 것들 무조건 포함 시키기 위해 추가 9
                innerEmpQuery.append("9") // "???"에 해당하는 것들 무조건 포함 시키기 위해 추가 9
                innerSpeQuery.append("8") // "???"에 해당하는 것들 무조건 포함 시키기 위해 추가 8
                
                database.collection("PolicyData_603")
                    .whereField("polyBizSecd", in: ArrayForLocationQuery.compactMap { Int($0) }) // 지역 필터링
                    .whereField("ageinfoTt", isGreaterThanOrEqualTo: userAge) // 나이 필터링
                    .whereFilter(Filter.orFilter([
    //                    Filter.whereField("accrrqiscnTt", arrayContainsAny: innerEduQuery), // 학력
    //                    Filter.whereField("empmsttscnTt", arrayContainsAny: innerEmpQuery), // 고용
                        Filter.whereField("splzrlmrqiscnTt", arrayContainsAny: innerSpeQuery), // 특화
                        Filter.whereField("aidSection", arrayContainsAny: incomeQuery) // 소득분위
                                ]))
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
                                let 신혼부부: String = docData["신혼부부"] as? String ?? ""
                                let tags: String = docData["plcytpnm"] as? String ?? ""
                                let 일인가구: String = docData["1인가구여부"] as? String ?? ""
                                let 농업인: String = docData["농업인"] as? String ?? ""
                                let 소상공인: String = docData["소상공인"] as? String ?? ""
                                let 차상위계층: String = docData["차상위계층"] as? String ?? ""
                                let 기초생활및생계급여: String = docData["기초생활및생계급여"] as? String ?? ""
                                let 무주택자: String = docData["homelessWhether"] as? String ?? ""
                                
                                // 임시 쿼리 확인차 선언
    //                            let 일인가구여부: String = docData["1인가구여부"] as? String ?? "nil"
                                let splzrlmrqiscnTt: [String] = docData["splzrlmrqiscnTt"] as? [String] ?? ["nil"]
                                
                                let policiesData: Policy = Policy(detailType: detailType, bizid: bizid, title: title, introduction: introduction, type: type,  content: content, reqAge: reqAge, reqEmploymentStatus: reqEmploymentStatus, reqEducation: reqEducation, reqMajor: reqMajor, reqSpecializedField: reqSpecializedField, period: period, procedure: procedure, siteURL: siteURL, locationCode: locationCode, 신혼부부: 신혼부부, tags: tags, 일인가구: 일인가구, 농업인: 농업인, 소상공인: 소상공인, 차상위계층: 차상위계층, 기초생활및생계급여: 기초생활및생계급여, 무주택자: 무주택자)

                                print(splzrlmrqiscnTt)
                                self.policies.append(policiesData)
                            }
                        }
                    }
            } else if eduCount == 0 && empCount > 0 && speCount > 0 { // edu만 안 골랐을 경우
                var innerEduQuery = eduQuery
                var innerEmpQuery = empQuery
                var innerSpeQuery = speQuery
                innerEduQuery.append("8") // "제한없음"에 해당하는 것들 무조건 포함 시키기 위해 추가 8
                innerEmpQuery.append("8") // "제한없음"에 해당하는 것들 무조건 포함 시키기 위해 추가 8
                innerSpeQuery.append("7") // "제한없음"에 해당하는 것들 무조건 포함 시키기 위해 추가 7
                innerEduQuery.append("9") // "???"에 해당하는 것들 무조건 포함 시키기 위해 추가 9
                innerEmpQuery.append("9") // "???"에 해당하는 것들 무조건 포함 시키기 위해 추가 9
                innerSpeQuery.append("8") // "???"에 해당하는 것들 무조건 포함 시키기 위해 추가 8
                
                database.collection("PolicyData_603")
                    .whereField("polyBizSecd", in: ArrayForLocationQuery.compactMap { Int($0) }) // 지역 필터링
                    .whereField("ageinfoTt", isGreaterThanOrEqualTo: userAge) // 나이 필터링
                    .whereFilter(Filter.orFilter([
    //                    Filter.whereField("accrrqiscnTt", arrayContainsAny: innerEduQuery), // 학력
                        Filter.whereField("empmsttscnTt", arrayContainsAny: innerEmpQuery), // 고용
                        Filter.whereField("splzrlmrqiscnTt", arrayContainsAny: innerSpeQuery), // 특화
                        Filter.whereField("aidSection", arrayContainsAny: incomeQuery) // 소득분위
                                ]))
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
                                let 신혼부부: String = docData["신혼부부"] as? String ?? ""
                                let tags: String = docData["plcytpnm"] as? String ?? ""
                                let 일인가구: String = docData["1인가구여부"] as? String ?? ""
                                let 농업인: String = docData["농업인"] as? String ?? ""
                                let 소상공인: String = docData["소상공인"] as? String ?? ""
                                let 차상위계층: String = docData["차상위계층"] as? String ?? ""
                                let 기초생활및생계급여: String = docData["기초생활및생계급여"] as? String ?? ""
                                let 무주택자: String = docData["homelessWhether"] as? String ?? ""
                                
                                // 임시 쿼리 확인차 선언
    //                            let 일인가구여부: String = docData["1인가구여부"] as? String ?? "nil"
                                let splzrlmrqiscnTt: [String] = docData["splzrlmrqiscnTt"] as? [String] ?? ["nil"]
                                
                                let policiesData: Policy = Policy(detailType: detailType, bizid: bizid, title: title, introduction: introduction, type: type,  content: content, reqAge: reqAge, reqEmploymentStatus: reqEmploymentStatus, reqEducation: reqEducation, reqMajor: reqMajor, reqSpecializedField: reqSpecializedField, period: period, procedure: procedure, siteURL: siteURL, locationCode: locationCode, 신혼부부: 신혼부부, tags: tags, 일인가구: 일인가구, 농업인: 농업인, 소상공인: 소상공인, 차상위계층: 차상위계층, 기초생활및생계급여: 기초생활및생계급여, 무주택자: 무주택자)

                                print(splzrlmrqiscnTt)
                                self.policies.append(policiesData)
                            }
                        }
                    }
            } else if empCount == 0 && eduCount > 0 && speCount > 0 { // emp만 안 골랐을 경우
                var innerEduQuery = eduQuery
                var innerEmpQuery = empQuery
                var innerSpeQuery = speQuery
                innerEduQuery.append("8") // "제한없음"에 해당하는 것들 무조건 포함 시키기 위해 추가 8
                innerEmpQuery.append("8") // "제한없음"에 해당하는 것들 무조건 포함 시키기 위해 추가 8
                innerSpeQuery.append("7") // "제한없음"에 해당하는 것들 무조건 포함 시키기 위해 추가 7
                innerEduQuery.append("9") // "???"에 해당하는 것들 무조건 포함 시키기 위해 추가 9
                innerEmpQuery.append("9") // "???"에 해당하는 것들 무조건 포함 시키기 위해 추가 9
                innerSpeQuery.append("8") // "???"에 해당하는 것들 무조건 포함 시키기 위해 추가 8
                
                database.collection("PolicyData_603")
                    .whereField("polyBizSecd", in: ArrayForLocationQuery.compactMap { Int($0) }) // 지역 필터링
                    .whereField("ageinfoTt", isGreaterThanOrEqualTo: userAge) // 나이 필터링
                    .whereFilter(Filter.orFilter([
                        Filter.whereField("accrrqiscnTt", arrayContainsAny: innerEduQuery), // 학력
    //                    Filter.whereField("empmsttscnTt", arrayContainsAny: innerEmpQuery), // 고용
                        Filter.whereField("splzrlmrqiscnTt", arrayContainsAny: innerSpeQuery), // 특화
                        Filter.whereField("aidSection", arrayContainsAny: incomeQuery) // 소득분위
                                ]))
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
                                let 신혼부부: String = docData["신혼부부"] as? String ?? ""
                                let tags: String = docData["plcytpnm"] as? String ?? ""
                                let 일인가구: String = docData["1인가구여부"] as? String ?? ""
                                let 농업인: String = docData["농업인"] as? String ?? ""
                                let 소상공인: String = docData["소상공인"] as? String ?? ""
                                let 차상위계층: String = docData["차상위계층"] as? String ?? ""
                                let 기초생활및생계급여: String = docData["기초생활및생계급여"] as? String ?? ""
                                let 무주택자: String = docData["homelessWhether"] as? String ?? ""
                                
                                // 임시 쿼리 확인차 선언
    //                            let 일인가구여부: String = docData["1인가구여부"] as? String ?? "nil"
                                let splzrlmrqiscnTt: [String] = docData["splzrlmrqiscnTt"] as? [String] ?? ["nil"]
                                
                                let policiesData: Policy = Policy(detailType: detailType, bizid: bizid, title: title, introduction: introduction, type: type,  content: content, reqAge: reqAge, reqEmploymentStatus: reqEmploymentStatus, reqEducation: reqEducation, reqMajor: reqMajor, reqSpecializedField: reqSpecializedField, period: period, procedure: procedure, siteURL: siteURL, locationCode: locationCode, 신혼부부: 신혼부부, tags: tags, 일인가구: 일인가구, 농업인: 농업인, 소상공인: 소상공인, 차상위계층: 차상위계층, 기초생활및생계급여: 기초생활및생계급여, 무주택자: 무주택자)

                                print(splzrlmrqiscnTt)
                                self.policies.append(policiesData)
                            }
                        }
                    }
            } else if speCount == 0 && empCount > 0 && eduCount > 0 { // spe만 안 골랐을 경우
                var innerEduQuery = eduQuery
                var innerEmpQuery = empQuery
                var innerSpeQuery = speQuery
                innerEduQuery.append("8") // "제한없음"에 해당하는 것들 무조건 포함 시키기 위해 추가 8
                innerEmpQuery.append("8") // "제한없음"에 해당하는 것들 무조건 포함 시키기 위해 추가 8
                innerSpeQuery.append("7") // "제한없음"에 해당하는 것들 무조건 포함 시키기 위해 추가 7
                innerEduQuery.append("9") // "???"에 해당하는 것들 무조건 포함 시키기 위해 추가 9
                innerEmpQuery.append("9") // "???"에 해당하는 것들 무조건 포함 시키기 위해 추가 9
                innerSpeQuery.append("8") // "???"에 해당하는 것들 무조건 포함 시키기 위해 추가 8
                
                database.collection("PolicyData_603")
                    .whereField("polyBizSecd", in: ArrayForLocationQuery.compactMap { Int($0) }) // 지역 필터링
                    .whereField("ageinfoTt", isGreaterThanOrEqualTo: userAge) // 나이 필터링
                    .whereFilter(Filter.orFilter([
                        Filter.whereField("accrrqiscnTt", arrayContainsAny: innerEduQuery), // 학력
                        Filter.whereField("empmsttscnTt", arrayContainsAny: innerEmpQuery), // 고용
    //                    Filter.whereField("splzrlmrqiscnTt", arrayContainsAny: innerSpeQuery), // 특화
                        Filter.whereField("aidSection", arrayContainsAny: incomeQuery) // 소득분위
                                ]))
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
                                let 신혼부부: String = docData["신혼부부"] as? String ?? ""
                                let tags: String = docData["plcytpnm"] as? String ?? ""
                                let 일인가구: String = docData["1인가구여부"] as? String ?? ""
                                let 농업인: String = docData["농업인"] as? String ?? ""
                                let 소상공인: String = docData["소상공인"] as? String ?? ""
                                let 차상위계층: String = docData["차상위계층"] as? String ?? ""
                                let 기초생활및생계급여: String = docData["기초생활및생계급여"] as? String ?? ""
                                let 무주택자: String = docData["homelessWhether"] as? String ?? ""
                                
                                // 임시 쿼리 확인차 선언
    //                            let 일인가구여부: String = docData["1인가구여부"] as? String ?? "nil"
                                let splzrlmrqiscnTt: [String] = docData["splzrlmrqiscnTt"] as? [String] ?? ["nil"]
                                
                                let policiesData: Policy = Policy(detailType: detailType, bizid: bizid, title: title, introduction: introduction, type: type,  content: content, reqAge: reqAge, reqEmploymentStatus: reqEmploymentStatus, reqEducation: reqEducation, reqMajor: reqMajor, reqSpecializedField: reqSpecializedField, period: period, procedure: procedure, siteURL: siteURL, locationCode: locationCode, 신혼부부: 신혼부부, tags: tags, 일인가구: 일인가구, 농업인: 농업인, 소상공인: 소상공인, 차상위계층: 차상위계층, 기초생활및생계급여: 기초생활및생계급여, 무주택자: 무주택자)

                                print(splzrlmrqiscnTt)
                                self.policies.append(policiesData)
                            }
                        }
                    }
            } else if speCount == 0 && empCount == 0 && eduCount == 0 { // 모두 안골랐을 경우
                
                database.collection("PolicyData_603")
                    .whereField("polyBizSecd", in: ArrayForLocationQuery.compactMap { Int($0) }) // 지역 필터링
                    .whereField("ageinfoTt", isGreaterThanOrEqualTo: userAge) // 나이 필터링
                    .whereFilter(Filter.orFilter([
//                        Filter.whereField("accrrqiscnTt", arrayContainsAny: innerEduQuery), // 학력
//                        Filter.whereField("empmsttscnTt", arrayContainsAny: innerEmpQuery), // 고용
    //                    Filter.whereField("splzrlmrqiscnTt", arrayContainsAny: innerSpeQuery), // 특화
                        Filter.whereField("aidSection", arrayContainsAny: incomeQuery) // 소득분위
                                ]))
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
                                let 신혼부부: String = docData["신혼부부"] as? String ?? ""
                                let tags: String = docData["plcytpnm"] as? String ?? ""
                                let 일인가구: String = docData["1인가구여부"] as? String ?? ""
                                let 농업인: String = docData["농업인"] as? String ?? ""
                                let 소상공인: String = docData["소상공인"] as? String ?? ""
                                let 차상위계층: String = docData["차상위계층"] as? String ?? ""
                                let 기초생활및생계급여: String = docData["기초생활및생계급여"] as? String ?? ""
                                let 무주택자: String = docData["homelessWhether"] as? String ?? ""
                                
                                // 임시 쿼리 확인차 선언
    //                            let 일인가구여부: String = docData["1인가구여부"] as? String ?? "nil"
                                let splzrlmrqiscnTt: [String] = docData["splzrlmrqiscnTt"] as? [String] ?? ["nil"]
                                
                                let policiesData: Policy = Policy(detailType: detailType, bizid: bizid, title: title, introduction: introduction, type: type,  content: content, reqAge: reqAge, reqEmploymentStatus: reqEmploymentStatus, reqEducation: reqEducation, reqMajor: reqMajor, reqSpecializedField: reqSpecializedField, period: period, procedure: procedure, siteURL: siteURL, locationCode: locationCode, 신혼부부: 신혼부부, tags: tags, 일인가구: 일인가구, 농업인: 농업인, 소상공인: 소상공인, 차상위계층: 차상위계층, 기초생활및생계급여: 기초생활및생계급여, 무주택자: 무주택자)

                                print(splzrlmrqiscnTt)
                                self.policies.append(policiesData)
                            }
                        }
                    }
            } else {
                fatalError("ERR")
            }
        } else if incomeCount <= 1 {
            // 그대로 하면됨
            if speCount > 0 && empCount > 0 && eduCount > 0 {
                var innerEduQuery = eduQuery
                var innerEmpQuery = empQuery
                var innerSpeQuery = speQuery
                innerEduQuery.append("8") // "제한없음"에 해당하는 것들 무조건 포함 시키기 위해 추가 8
                innerEmpQuery.append("8") // "제한없음"에 해당하는 것들 무조건 포함 시키기 위해 추가 8
                innerSpeQuery.append("7") // "제한없음"에 해당하는 것들 무조건 포함 시키기 위해 추가 7
                innerEduQuery.append("9") // "???"에 해당하는 것들 무조건 포함 시키기 위해 추가 9
                innerEmpQuery.append("9") // "???"에 해당하는 것들 무조건 포함 시키기 위해 추가 9
                innerSpeQuery.append("8") // "???"에 해당하는 것들 무조건 포함 시키기 위해 추가 8
                
                database.collection("PolicyData_603")
                    .whereField("polyBizSecd", in: ArrayForLocationQuery.compactMap { Int($0) }) // 지역 필터링
                    .whereField("ageinfoTt", isGreaterThanOrEqualTo: userAge) // 나이 필터링
                    .whereFilter(Filter.orFilter([
                        Filter.whereField("accrrqiscnTt", arrayContainsAny: innerEduQuery), // 학력
                        Filter.whereField("empmsttscnTt", arrayContainsAny: innerEmpQuery), // 고용
                        Filter.whereField("splzrlmrqiscnTt", arrayContainsAny: innerSpeQuery), // 특화
                                ]))
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
                                let 신혼부부: String = docData["신혼부부"] as? String ?? ""
                                let tags: String = docData["plcytpnm"] as? String ?? ""
                                let 일인가구: String = docData["1인가구여부"] as? String ?? ""
                                let 농업인: String = docData["농업인"] as? String ?? ""
                                let 소상공인: String = docData["소상공인"] as? String ?? ""
                                let 차상위계층: String = docData["차상위계층"] as? String ?? ""
                                let 기초생활및생계급여: String = docData["기초생활및생계급여"] as? String ?? ""
                                let 무주택자: String = docData["homelessWhether"] as? String ?? ""
                                
                                // 임시 쿼리 확인차 선언
    //                            let 일인가구여부: String = docData["1인가구여부"] as? String ?? "nil"
                                let splzrlmrqiscnTt: [String] = docData["splzrlmrqiscnTt"] as? [String] ?? ["nil"]
                                
                                let policiesData: Policy = Policy(detailType: detailType, bizid: bizid, title: title, introduction: introduction, type: type,  content: content, reqAge: reqAge, reqEmploymentStatus: reqEmploymentStatus, reqEducation: reqEducation, reqMajor: reqMajor, reqSpecializedField: reqSpecializedField, period: period, procedure: procedure, siteURL: siteURL, locationCode: locationCode, 신혼부부: 신혼부부, tags: tags, 일인가구: 일인가구, 농업인: 농업인, 소상공인: 소상공인, 차상위계층: 차상위계층, 기초생활및생계급여: 기초생활및생계급여, 무주택자: 무주택자)

                                print(splzrlmrqiscnTt)
                                self.policies.append(policiesData)
                            }
                        }
                    }
            } else if eduCount > 0 && empCount == 0 && speCount == 0 { // edu만 골랐을 경우
                var innerEduQuery = eduQuery
                var innerEmpQuery = empQuery
                var innerSpeQuery = speQuery
                innerEduQuery.append("8") // "제한없음"에 해당하는 것들 무조건 포함 시키기 위해 추가 8
                innerEmpQuery.append("8") // "제한없음"에 해당하는 것들 무조건 포함 시키기 위해 추가 8
                innerSpeQuery.append("7") // "제한없음"에 해당하는 것들 무조건 포함 시키기 위해 추가 7
                innerEduQuery.append("9") // "???"에 해당하는 것들 무조건 포함 시키기 위해 추가 9
                innerEmpQuery.append("9") // "???"에 해당하는 것들 무조건 포함 시키기 위해 추가 9
                innerSpeQuery.append("8") // "???"에 해당하는 것들 무조건 포함 시키기 위해 추가 8
                
                database.collection("PolicyData_603")
                    .whereField("polyBizSecd", in: ArrayForLocationQuery.compactMap { Int($0) }) // 지역 필터링
                    .whereField("ageinfoTt", isGreaterThanOrEqualTo: userAge) // 나이 필터링
                    .whereFilter(Filter.orFilter([
                        Filter.whereField("accrrqiscnTt", arrayContainsAny: innerEduQuery), // 학력
    //                    Filter.whereField("empmsttscnTt", arrayContainsAny: innerEmpQuery), // 고용
    //                    Filter.whereField("splzrlmrqiscnTt", arrayContainsAny: innerSpeQuery), // 특화
                                ]))
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
                                let 신혼부부: String = docData["신혼부부"] as? String ?? ""
                                let tags: String = docData["plcytpnm"] as? String ?? ""
                                let 일인가구: String = docData["1인가구여부"] as? String ?? ""
                                let 농업인: String = docData["농업인"] as? String ?? ""
                                let 소상공인: String = docData["소상공인"] as? String ?? ""
                                let 차상위계층: String = docData["차상위계층"] as? String ?? ""
                                let 기초생활및생계급여: String = docData["기초생활및생계급여"] as? String ?? ""
                                let 무주택자: String = docData["homelessWhether"] as? String ?? ""
                                
                                // 임시 쿼리 확인차 선언
    //                            let 일인가구여부: String = docData["1인가구여부"] as? String ?? "nil"
                                let splzrlmrqiscnTt: [String] = docData["splzrlmrqiscnTt"] as? [String] ?? ["nil"]
                                
                                let policiesData: Policy = Policy(detailType: detailType, bizid: bizid, title: title, introduction: introduction, type: type,  content: content, reqAge: reqAge, reqEmploymentStatus: reqEmploymentStatus, reqEducation: reqEducation, reqMajor: reqMajor, reqSpecializedField: reqSpecializedField, period: period, procedure: procedure, siteURL: siteURL, locationCode: locationCode, 신혼부부: 신혼부부, tags: tags, 일인가구: 일인가구, 농업인: 농업인, 소상공인: 소상공인, 차상위계층: 차상위계층, 기초생활및생계급여: 기초생활및생계급여, 무주택자: 무주택자)

                                print(splzrlmrqiscnTt)
                                self.policies.append(policiesData)
                            }
                        }
                    }
            } else if empCount > 0 && eduCount == 0 && speCount == 0 { // emp만 골랐을 경우
                var innerEduQuery = eduQuery
                var innerEmpQuery = empQuery
                var innerSpeQuery = speQuery
                innerEduQuery.append("8") // "제한없음"에 해당하는 것들 무조건 포함 시키기 위해 추가 8
                innerEmpQuery.append("8") // "제한없음"에 해당하는 것들 무조건 포함 시키기 위해 추가 8
                innerSpeQuery.append("7") // "제한없음"에 해당하는 것들 무조건 포함 시키기 위해 추가 7
                innerEduQuery.append("9") // "???"에 해당하는 것들 무조건 포함 시키기 위해 추가 9
                innerEmpQuery.append("9") // "???"에 해당하는 것들 무조건 포함 시키기 위해 추가 9
                innerSpeQuery.append("8") // "???"에 해당하는 것들 무조건 포함 시키기 위해 추가 8
                
                database.collection("PolicyData_603")
                    .whereField("polyBizSecd", in: ArrayForLocationQuery.compactMap { Int($0) }) // 지역 필터링
                    .whereField("ageinfoTt", isGreaterThanOrEqualTo: userAge) // 나이 필터링
                    .whereFilter(Filter.orFilter([
    //                    Filter.whereField("accrrqiscnTt", arrayContainsAny: innerEduQuery), // 학력
                        Filter.whereField("empmsttscnTt", arrayContainsAny: innerEmpQuery), // 고용
    //                    Filter.whereField("splzrlmrqiscnTt", arrayContainsAny: innerSpeQuery), // 특화
                                ]))
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
                                let 신혼부부: String = docData["신혼부부"] as? String ?? ""
                                let tags: String = docData["plcytpnm"] as? String ?? ""
                                let 일인가구: String = docData["1인가구여부"] as? String ?? ""
                                let 농업인: String = docData["농업인"] as? String ?? ""
                                let 소상공인: String = docData["소상공인"] as? String ?? ""
                                let 차상위계층: String = docData["차상위계층"] as? String ?? ""
                                let 기초생활및생계급여: String = docData["기초생활및생계급여"] as? String ?? ""
                                let 무주택자: String = docData["homelessWhether"] as? String ?? ""
                                
                                // 임시 쿼리 확인차 선언
    //                            let 일인가구여부: String = docData["1인가구여부"] as? String ?? "nil"
                                let splzrlmrqiscnTt: [String] = docData["splzrlmrqiscnTt"] as? [String] ?? ["nil"]
                                
                                let policiesData: Policy = Policy(detailType: detailType, bizid: bizid, title: title, introduction: introduction, type: type,  content: content, reqAge: reqAge, reqEmploymentStatus: reqEmploymentStatus, reqEducation: reqEducation, reqMajor: reqMajor, reqSpecializedField: reqSpecializedField, period: period, procedure: procedure, siteURL: siteURL, locationCode: locationCode, 신혼부부: 신혼부부, tags: tags, 일인가구: 일인가구, 농업인: 농업인, 소상공인: 소상공인, 차상위계층: 차상위계층, 기초생활및생계급여: 기초생활및생계급여, 무주택자: 무주택자)

                                print(splzrlmrqiscnTt)
                                self.policies.append(policiesData)
                            }
                        }
                    }
            } else if speCount > 0 && eduCount == 0 && empCount == 0 { // spe만 골랐을 경우
                var innerEduQuery = eduQuery
                var innerEmpQuery = empQuery
                var innerSpeQuery = speQuery
                innerEduQuery.append("8") // "제한없음"에 해당하는 것들 무조건 포함 시키기 위해 추가 8
                innerEmpQuery.append("8") // "제한없음"에 해당하는 것들 무조건 포함 시키기 위해 추가 8
                innerSpeQuery.append("7") // "제한없음"에 해당하는 것들 무조건 포함 시키기 위해 추가 7
                innerEduQuery.append("9") // "???"에 해당하는 것들 무조건 포함 시키기 위해 추가 9
                innerEmpQuery.append("9") // "???"에 해당하는 것들 무조건 포함 시키기 위해 추가 9
                innerSpeQuery.append("8") // "???"에 해당하는 것들 무조건 포함 시키기 위해 추가 8
                
                database.collection("PolicyData_603")
                    .whereField("polyBizSecd", in: ArrayForLocationQuery.compactMap { Int($0) }) // 지역 필터링
                    .whereField("ageinfoTt", isGreaterThanOrEqualTo: userAge) // 나이 필터링
                    .whereFilter(Filter.orFilter([
    //                    Filter.whereField("accrrqiscnTt", arrayContainsAny: innerEduQuery), // 학력
    //                    Filter.whereField("empmsttscnTt", arrayContainsAny: innerEmpQuery), // 고용
                        Filter.whereField("splzrlmrqiscnTt", arrayContainsAny: innerSpeQuery), // 특화
                                ]))
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
                                let 신혼부부: String = docData["신혼부부"] as? String ?? ""
                                let tags: String = docData["plcytpnm"] as? String ?? ""
                                let 일인가구: String = docData["1인가구여부"] as? String ?? ""
                                let 농업인: String = docData["농업인"] as? String ?? ""
                                let 소상공인: String = docData["소상공인"] as? String ?? ""
                                let 차상위계층: String = docData["차상위계층"] as? String ?? ""
                                let 기초생활및생계급여: String = docData["기초생활및생계급여"] as? String ?? ""
                                let 무주택자: String = docData["homelessWhether"] as? String ?? ""
                                
                                // 임시 쿼리 확인차 선언
    //                            let 일인가구여부: String = docData["1인가구여부"] as? String ?? "nil"
                                let splzrlmrqiscnTt: [String] = docData["splzrlmrqiscnTt"] as? [String] ?? ["nil"]
                                
                                let policiesData: Policy = Policy(detailType: detailType, bizid: bizid, title: title, introduction: introduction, type: type,  content: content, reqAge: reqAge, reqEmploymentStatus: reqEmploymentStatus, reqEducation: reqEducation, reqMajor: reqMajor, reqSpecializedField: reqSpecializedField, period: period, procedure: procedure, siteURL: siteURL, locationCode: locationCode, 신혼부부: 신혼부부, tags: tags, 일인가구: 일인가구, 농업인: 농업인, 소상공인: 소상공인, 차상위계층: 차상위계층, 기초생활및생계급여: 기초생활및생계급여, 무주택자: 무주택자)

                                print(splzrlmrqiscnTt)
                                self.policies.append(policiesData)
                            }
                        }
                    }
            } else if eduCount == 0 && empCount > 0 && speCount > 0 { // edu만 안 골랐을 경우
                var innerEduQuery = eduQuery
                var innerEmpQuery = empQuery
                var innerSpeQuery = speQuery
                innerEduQuery.append("8") // "제한없음"에 해당하는 것들 무조건 포함 시키기 위해 추가 8
                innerEmpQuery.append("8") // "제한없음"에 해당하는 것들 무조건 포함 시키기 위해 추가 8
                innerSpeQuery.append("7") // "제한없음"에 해당하는 것들 무조건 포함 시키기 위해 추가 7
                innerEduQuery.append("9") // "???"에 해당하는 것들 무조건 포함 시키기 위해 추가 9
                innerEmpQuery.append("9") // "???"에 해당하는 것들 무조건 포함 시키기 위해 추가 9
                innerSpeQuery.append("8") // "???"에 해당하는 것들 무조건 포함 시키기 위해 추가 8
                
                database.collection("PolicyData_603")
                    .whereField("polyBizSecd", in: ArrayForLocationQuery.compactMap { Int($0) }) // 지역 필터링
                    .whereField("ageinfoTt", isGreaterThanOrEqualTo: userAge) // 나이 필터링
                    .whereFilter(Filter.orFilter([
    //                    Filter.whereField("accrrqiscnTt", arrayContainsAny: innerEduQuery), // 학력
                        Filter.whereField("empmsttscnTt", arrayContainsAny: innerEmpQuery), // 고용
                        Filter.whereField("splzrlmrqiscnTt", arrayContainsAny: innerSpeQuery), // 특화
                                ]))
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
                                let 신혼부부: String = docData["신혼부부"] as? String ?? ""
                                let tags: String = docData["plcytpnm"] as? String ?? ""
                                let 일인가구: String = docData["1인가구여부"] as? String ?? ""
                                let 농업인: String = docData["농업인"] as? String ?? ""
                                let 소상공인: String = docData["소상공인"] as? String ?? ""
                                let 차상위계층: String = docData["차상위계층"] as? String ?? ""
                                let 기초생활및생계급여: String = docData["기초생활및생계급여"] as? String ?? ""
                                let 무주택자: String = docData["homelessWhether"] as? String ?? ""
                                
                                // 임시 쿼리 확인차 선언
    //                            let 일인가구여부: String = docData["1인가구여부"] as? String ?? "nil"
                                let splzrlmrqiscnTt: [String] = docData["splzrlmrqiscnTt"] as? [String] ?? ["nil"]
                                
                                let policiesData: Policy = Policy(detailType: detailType, bizid: bizid, title: title, introduction: introduction, type: type,  content: content, reqAge: reqAge, reqEmploymentStatus: reqEmploymentStatus, reqEducation: reqEducation, reqMajor: reqMajor, reqSpecializedField: reqSpecializedField, period: period, procedure: procedure, siteURL: siteURL, locationCode: locationCode, 신혼부부: 신혼부부, tags: tags, 일인가구: 일인가구, 농업인: 농업인, 소상공인: 소상공인, 차상위계층: 차상위계층, 기초생활및생계급여: 기초생활및생계급여, 무주택자: 무주택자)

                                print(splzrlmrqiscnTt)
                                self.policies.append(policiesData)
                            }
                        }
                    }
            } else if empCount == 0 && eduCount > 0 && speCount > 0 { // emp만 안 골랐을 경우
                var innerEduQuery = eduQuery
                var innerEmpQuery = empQuery
                var innerSpeQuery = speQuery
                innerEduQuery.append("8") // "제한없음"에 해당하는 것들 무조건 포함 시키기 위해 추가 8
                innerEmpQuery.append("8") // "제한없음"에 해당하는 것들 무조건 포함 시키기 위해 추가 8
                innerSpeQuery.append("7") // "제한없음"에 해당하는 것들 무조건 포함 시키기 위해 추가 7
                innerEduQuery.append("9") // "???"에 해당하는 것들 무조건 포함 시키기 위해 추가 9
                innerEmpQuery.append("9") // "???"에 해당하는 것들 무조건 포함 시키기 위해 추가 9
                innerSpeQuery.append("8") // "???"에 해당하는 것들 무조건 포함 시키기 위해 추가 8
                
                database.collection("PolicyData_603")
                    .whereField("polyBizSecd", in: ArrayForLocationQuery.compactMap { Int($0) }) // 지역 필터링
                    .whereField("ageinfoTt", isGreaterThanOrEqualTo: userAge) // 나이 필터링
                    .whereFilter(Filter.orFilter([
                        Filter.whereField("accrrqiscnTt", arrayContainsAny: innerEduQuery), // 학력
    //                    Filter.whereField("empmsttscnTt", arrayContainsAny: innerEmpQuery), // 고용
                        Filter.whereField("splzrlmrqiscnTt", arrayContainsAny: innerSpeQuery), // 특화
                                ]))
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
                                let 신혼부부: String = docData["신혼부부"] as? String ?? ""
                                let tags: String = docData["plcytpnm"] as? String ?? ""
                                let 일인가구: String = docData["1인가구여부"] as? String ?? ""
                                let 농업인: String = docData["농업인"] as? String ?? ""
                                let 소상공인: String = docData["소상공인"] as? String ?? ""
                                let 차상위계층: String = docData["차상위계층"] as? String ?? ""
                                let 기초생활및생계급여: String = docData["기초생활및생계급여"] as? String ?? ""
                                let 무주택자: String = docData["homelessWhether"] as? String ?? ""
                                
                                // 임시 쿼리 확인차 선언
    //                            let 일인가구여부: String = docData["1인가구여부"] as? String ?? "nil"
                                let splzrlmrqiscnTt: [String] = docData["splzrlmrqiscnTt"] as? [String] ?? ["nil"]
                                
                                let policiesData: Policy = Policy(detailType: detailType, bizid: bizid, title: title, introduction: introduction, type: type,  content: content, reqAge: reqAge, reqEmploymentStatus: reqEmploymentStatus, reqEducation: reqEducation, reqMajor: reqMajor, reqSpecializedField: reqSpecializedField, period: period, procedure: procedure, siteURL: siteURL, locationCode: locationCode, 신혼부부: 신혼부부, tags: tags, 일인가구: 일인가구, 농업인: 농업인, 소상공인: 소상공인, 차상위계층: 차상위계층, 기초생활및생계급여: 기초생활및생계급여, 무주택자: 무주택자)

                                print(splzrlmrqiscnTt)
                                self.policies.append(policiesData)
                            }
                        }
                    }
            } else if speCount == 0 && empCount > 0 && eduCount > 0 { // spe만 안 골랐을 경우
                var innerEduQuery = eduQuery
                var innerEmpQuery = empQuery
                var innerSpeQuery = speQuery
                innerEduQuery.append("8") // "제한없음"에 해당하는 것들 무조건 포함 시키기 위해 추가 8
                innerEmpQuery.append("8") // "제한없음"에 해당하는 것들 무조건 포함 시키기 위해 추가 8
                innerSpeQuery.append("7") // "제한없음"에 해당하는 것들 무조건 포함 시키기 위해 추가 7
                innerEduQuery.append("9") // "???"에 해당하는 것들 무조건 포함 시키기 위해 추가 9
                innerEmpQuery.append("9") // "???"에 해당하는 것들 무조건 포함 시키기 위해 추가 9
                innerSpeQuery.append("8") // "???"에 해당하는 것들 무조건 포함 시키기 위해 추가 8
                
                database.collection("PolicyData_603")
                    .whereField("polyBizSecd", in: ArrayForLocationQuery.compactMap { Int($0) }) // 지역 필터링
                    .whereField("ageinfoTt", isGreaterThanOrEqualTo: userAge) // 나이 필터링
                    .whereFilter(Filter.orFilter([
                        Filter.whereField("accrrqiscnTt", arrayContainsAny: innerEduQuery), // 학력
                        Filter.whereField("empmsttscnTt", arrayContainsAny: innerEmpQuery), // 고용
    //                    Filter.whereField("splzrlmrqiscnTt", arrayContainsAny: innerSpeQuery), // 특화
                                ]))
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
                                let 신혼부부: String = docData["신혼부부"] as? String ?? ""
                                let tags: String = docData["plcytpnm"] as? String ?? ""
                                let 일인가구: String = docData["1인가구여부"] as? String ?? ""
                                let 농업인: String = docData["농업인"] as? String ?? ""
                                let 소상공인: String = docData["소상공인"] as? String ?? ""
                                let 차상위계층: String = docData["차상위계층"] as? String ?? ""
                                let 기초생활및생계급여: String = docData["기초생활및생계급여"] as? String ?? ""
                                let 무주택자: String = docData["homelessWhether"] as? String ?? ""
                                
                                // 임시 쿼리 확인차 선언
    //                            let 일인가구여부: String = docData["1인가구여부"] as? String ?? "nil"
                                let splzrlmrqiscnTt: [String] = docData["splzrlmrqiscnTt"] as? [String] ?? ["nil"]
                                
                                let policiesData: Policy = Policy(detailType: detailType, bizid: bizid, title: title, introduction: introduction, type: type,  content: content, reqAge: reqAge, reqEmploymentStatus: reqEmploymentStatus, reqEducation: reqEducation, reqMajor: reqMajor, reqSpecializedField: reqSpecializedField, period: period, procedure: procedure, siteURL: siteURL, locationCode: locationCode, 신혼부부: 신혼부부, tags: tags, 일인가구: 일인가구, 농업인: 농업인, 소상공인: 소상공인, 차상위계층: 차상위계층, 기초생활및생계급여: 기초생활및생계급여, 무주택자: 무주택자)

                                print(splzrlmrqiscnTt)
                                self.policies.append(policiesData)
                            }
                        }
                    }
            } else if speCount == 0 && empCount == 0 && eduCount == 0 { // 모두 안골랐을 경우
                
                database.collection("PolicyData_603")
                    .whereField("polyBizSecd", in: ArrayForLocationQuery.compactMap { Int($0) }) // 지역 필터링
                    .whereField("ageinfoTt", isGreaterThanOrEqualTo: userAge) // 나이 필터링
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
                                let 신혼부부: String = docData["신혼부부"] as? String ?? ""
                                let tags: String = docData["plcytpnm"] as? String ?? ""
                                let 일인가구: String = docData["1인가구여부"] as? String ?? ""
                                let 농업인: String = docData["농업인"] as? String ?? ""
                                let 소상공인: String = docData["소상공인"] as? String ?? ""
                                let 차상위계층: String = docData["차상위계층"] as? String ?? ""
                                let 기초생활및생계급여: String = docData["기초생활및생계급여"] as? String ?? ""
                                let 무주택자: String = docData["homelessWhether"] as? String ?? ""
                                
                                // 임시 쿼리 확인차 선언
    //                            let 일인가구여부: String = docData["1인가구여부"] as? String ?? "nil"
                                let splzrlmrqiscnTt: [String] = docData["splzrlmrqiscnTt"] as? [String] ?? ["nil"]
                                
                                let policiesData: Policy = Policy(detailType: detailType, bizid: bizid, title: title, introduction: introduction, type: type,  content: content, reqAge: reqAge, reqEmploymentStatus: reqEmploymentStatus, reqEducation: reqEducation, reqMajor: reqMajor, reqSpecializedField: reqSpecializedField, period: period, procedure: procedure, siteURL: siteURL, locationCode: locationCode, 신혼부부: 신혼부부, tags: tags, 일인가구: 일인가구, 농업인: 농업인, 소상공인: 소상공인, 차상위계층: 차상위계층, 기초생활및생계급여: 기초생활및생계급여, 무주택자: 무주택자)

                                print(splzrlmrqiscnTt)
                                self.policies.append(policiesData)
                            }
                        }
                    }
            } else {
                fatalError("ERR")
            }
        } else {
            print("소득분위 페치 ERR")
        }
    }
}



//                            Filter.whereField("1인가구여부", isEqualTo: "-"),
//                            Filter.whereField("homelessWhether", isEqualTo: "-"),
//                            Filter.whereField("schoolYearSystem", isEqualTo: "-"),
//                            Filter.whereField("기초생활및생계급여", isEqualTo: "-"),
//                            Filter.whereField("농업인", isEqualTo: "-"),
//                            Filter.whereField("소상공인", isEqualTo: "-"),
//                            Filter.whereField("신혼부부", isEqualTo: "-"),
//                            Filter.whereField("중위소득", isEqualTo: "-"),
//                            Filter.whereField("차상위계층", isEqualTo: "-"),
