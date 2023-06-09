//
//  EducationView.swift
//  YouthPolicyPedia
//
//  Created by 김태성 on 2023/06/04.
//

import SwiftUI
import AlertToast

struct EducationView: View {
    @EnvironmentObject var policyStore: PolicyStore
    
    @State private var isPushEduArr: [Bool] = Array(repeating: false, count: 10)
    let eduName: [String] = ["고졸 미만", "고교 재학", "고졸 예정", "고교 졸업", "대학 재학", "대졸 예정", "대학 졸업", "석사 박사"]
    let eduNum: [String] = ["0", "1" ,"2", "3", "4", "5", "6", "7"]
    @State var eduSelectArr: [String] = []
    
    @State private var isPushEmpArr: [Bool] = Array(repeating: false, count: 10)
    let empName: [String] = ["재직자", "자영업자", "미취업자", "프리랜서", "일용근로자", "예비창업자", "단기근로자", "영농종사자"]
    let empNum: [String] = ["0", "1" ,"2", "3", "4", "5", "6", "7"]
    @State var empSelectArr: [String] = []
    
    @State private var isPushSpeArr: [Bool] = Array(repeating: false, count: 9)
    let speName: [String] = ["중소기업", "여성", "저소득층", "장애인", "농업인", "군인", "지역인재"]
    let speNum: [String] = ["0", "1" ,"2", "3", "4", "5", "6"]
    @State var speSelectArr: [String] = []
    
    @State private var isOver10 = false
    @State private var selectCount = 0
    
    func checkSelectCountOver10() -> Bool {
        return selectCount > 10
    }
    
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    print("뒤로가기")
                    // 처음 선택으로 돌아가기
                    policyStore.pageNumber = 0
                    policyStore.selectedDetailLocation = [:]
                    policyStore.selectedLocation = [:]
                } label: {
                    Image(systemName: "chevron.left")
                        .bold()
                        .foregroundColor(.black)
                }
                Spacer()
            }
            .padding()
            // MARK: - 학력
            Group {
                HStack {
                    Text("학력")
                        .bold()
                        .padding()
                    Spacer()
                }
                HStack {
                    ForEach(0...2, id: \.self) { i in
                            Button {
                                isPushEduArr[i].toggle()
                                if isPushEduArr[i] { // 누르면 추가
                                    eduSelectArr.append(eduNum[i])
                                    selectCount += 1
                                } else { // 다시 누르면 삭제
                                    eduSelectArr.remove(at: eduSelectArr.firstIndex(of: eduNum[i]) ?? 0)
                                    selectCount -= 1
                                }
                                isOver10 = checkSelectCountOver10()
                                print("\(eduSelectArr)")
                            } label: {
                                Text("\(eduName[i])")
                                    .padding(.vertical, 5)
                                    .padding(.horizontal, 10)
                                    .foregroundColor(.brown)
                                    .background(Rectangle().fill(isPushEduArr[i] ? .yellow.opacity(0.5) : .white))
                                    .overlay(
                                        Rectangle().strokeBorder(.brown)
                                    )
                            }
                    }
                }
                
                HStack {
                    ForEach(3...5, id: \.self) { i in
                            Button {
                                isPushEduArr[i].toggle()
                                if isPushEduArr[i] { // 누르면 추가
                                    eduSelectArr.append(eduNum[i])
                                    selectCount += 1
                                } else { // 다시 누르면 삭제
                                    eduSelectArr.remove(at: eduSelectArr.firstIndex(of: eduNum[i]) ?? 0)
                                    selectCount -= 1
                                }
                                isOver10 = checkSelectCountOver10()
                                print("\(eduSelectArr)")
                            } label: {
                                Text("\(eduName[i])")
                                    .padding(.vertical, 5)
                                    .padding(.horizontal, 10)
                                    .foregroundColor(.brown)
                                    .background(Rectangle().fill(isPushEduArr[i] ? .yellow.opacity(0.5) : .white))
                                    .overlay(
                                        Rectangle().strokeBorder(.brown)
                                    )
                            }
                    }
                }
                
                HStack {
                    ForEach(6...7, id: \.self) { i in
                            Button {
                                isPushEduArr[i].toggle()
                                if isPushEduArr[i] { // 누르면 추가
                                    if i != 8 {
                                        eduSelectArr.append(eduNum[i])
                                    }
                                    
                                    selectCount += 1
                                } else { // 다시 누르면 삭제
                                    if i != 8 {
                                        eduSelectArr.remove(at: eduSelectArr.firstIndex(of: eduNum[i]) ?? 0)
                                    }
                                    
                                    selectCount -= 1
                                }
                                isOver10 = checkSelectCountOver10()
                                print("\(eduSelectArr)")
                            } label: {
                                Text("\(eduName[i])")
                                    .padding(.vertical, 5)
                                    .padding(.horizontal, 10)
                                    .foregroundColor(.brown)
                                    .background(Rectangle().fill(isPushEduArr[i] ? .yellow.opacity(0.5) : .white))
                                    .overlay(
                                        Rectangle().strokeBorder(.brown)
                                    )
                            }
                    }
                }
            }
            
            // MARK: - 취업 상태
            Group {
                HStack {
                    Text("취업 상태")
                        .bold()
                        .padding()
                    Spacer()
                }
                HStack {
                    ForEach(0...3, id: \.self) { i in
                            Button {
                                isPushEmpArr[i].toggle()
                                if isPushEmpArr[i] { // 누르면 추가
                                    empSelectArr.append(empNum[i])
                                    selectCount += 1
                                } else { // 다시 누르면 삭제
                                    empSelectArr.remove(at: empSelectArr.firstIndex(of: empNum[i]) ?? 0)
                                    selectCount -= 1
                                }
                                isOver10 = checkSelectCountOver10()
                                print("\(empSelectArr)")
                            } label: {
                                Text("\(empName[i])")
                                    .padding(.vertical, 5)
                                    .padding(.horizontal, 10)
                                    .foregroundColor(.brown)
                                    .background(Rectangle().fill(isPushEmpArr[i] ? .yellow.opacity(0.5) : .white))
                                    .overlay(
                                        Rectangle().strokeBorder(.brown)
                                    )
                            }
                    }
                }
                
                HStack {
                    ForEach(4...5, id: \.self) { i in
                            Button {
                                isPushEmpArr[i].toggle()
                                if isPushEmpArr[i] { // 누르면 추가
                                    empSelectArr.append(empNum[i])
                                    selectCount += 1
                                } else { // 다시 누르면 삭제
                                    empSelectArr.remove(at: empSelectArr.firstIndex(of: empNum[i]) ?? 0)
                                    selectCount -= 1
                                }
                                isOver10 = checkSelectCountOver10()
                                print("\(empSelectArr)")
                            } label: {
                                Text("\(empName[i])")
                                    .padding(.vertical, 5)
                                    .padding(.horizontal, 10)
                                    .foregroundColor(.brown)
                                    .background(Rectangle().fill(isPushEmpArr[i] ? .yellow.opacity(0.5) : .white))
                                    .overlay(
                                        Rectangle().strokeBorder(.brown)
                                    )
                            }
                    }
                }
                
                HStack {
                    ForEach(6...7, id: \.self) { i in
                            Button {
                                isPushEmpArr[i].toggle()
                                if isPushEmpArr[i] { // 누르면 추가
                                    if i != 8 {
                                        empSelectArr.append(empNum[i])
                                    }
                                    
                                    selectCount += 1
                                } else { // 다시 누르면 삭제
                                    if i != 8 {
                                        empSelectArr.remove(at: empSelectArr.firstIndex(of: empNum[i]) ?? 0)
                                    }
                                    
                                    selectCount -= 1
                                }
                                isOver10 = checkSelectCountOver10()
                                print("\(empSelectArr)")
                            } label: {
                                Text("\(empName[i])")
                                    .padding(.vertical, 5)
                                    .padding(.horizontal, 10)
                                    .foregroundColor(.brown)
                                    .background(Rectangle().fill(isPushEmpArr[i] ? .yellow.opacity(0.5) : .white))
                                    .overlay(
                                        Rectangle().strokeBorder(.brown)
                                    )
                            }
                    }
                }
            }
            
            // MARK: - 추가 사항
            Group {
                HStack {
                    Text("추가 사항")
                        .bold()
                        .padding()
                    Spacer()
                }
                HStack {
                    ForEach(0...3, id: \.self) { i in
                            Button {
                                isPushSpeArr[i].toggle()
                                if isPushSpeArr[i] { // 누르면 추가
                                    speSelectArr.append(speNum[i])
                                    selectCount += 1
                                } else { // 다시 누르면 삭제
                                    speSelectArr.remove(at: speSelectArr.firstIndex(of: empNum[i]) ?? 0)
                                    selectCount -= 1
                                }
                                isOver10 = checkSelectCountOver10()
                                print("\(speSelectArr)")
                            } label: {
                                Text("\(speName[i])")
                                    .padding(.vertical, 5)
                                    .padding(.horizontal, 10)
                                    .foregroundColor(.brown)
                                    .background(Rectangle().fill(isPushSpeArr[i] ? .yellow.opacity(0.5) : .white))
                                    .overlay(
                                        Rectangle().strokeBorder(.brown)
                                    )
                            }
                    }
                }
                
                HStack {
                    ForEach(4...6, id: \.self) { i in
                            Button {
                                isPushSpeArr[i].toggle()
                                if isPushSpeArr[i] { // 누르면 추가
                                    speSelectArr.append(speNum[i])
                                    selectCount += 1
                                } else { // 다시 누르면 삭제
                                    speSelectArr.remove(at: speSelectArr.firstIndex(of: empNum[i]) ?? 0)
                                    selectCount -= 1
                                }
                                isOver10 = checkSelectCountOver10()
                                print("\(speSelectArr)")
                            } label: {
                                Text("\(speName[i])")
                                    .padding(.vertical, 5)
                                    .padding(.horizontal, 10)
                                    .foregroundColor(.brown)
                                    .background(Rectangle().fill(isPushSpeArr[i] ? .yellow.opacity(0.5) : .white))
                                    .overlay(
                                        Rectangle().strokeBorder(.brown)
                                    )
                            }
                    }
                }
                
//                HStack {
//                    ForEach(5...6, id: \.self) { i in
//                            Button {
//                                isPushSpeArr[i].toggle()
//                                if isPushSpeArr[i] { // 누르면 추가
//                                    if i != 7 {
//                                        speSelectArr.append(speNum[i])
//                                    }
//                                    
//                                    selectCount += 1
//                                } else { // 다시 누르면 삭제
//                                    if i != 7 {
//                                        speSelectArr.remove(at: speSelectArr.firstIndex(of: empNum[i]) ?? 0)
//                                    }
//                                    
//                                    selectCount -= 1
//                                }
//                                isOver10 = checkSelectCountOver10()
//                                print("\(speSelectArr)")
//                            } label: {
//                                Text("\(speName[i])")
//                                    .padding(.vertical, 5)
//                                    .padding(.horizontal, 10)
//                                    .foregroundColor(.brown)
//                                    .background(Rectangle().fill(isPushSpeArr[i] ? .yellow.opacity(0.5) : .white))
//                                    .overlay(
//                                        Rectangle().strokeBorder(.brown)
//                                    )
//                            }
//                    }
//                }
            }
            Spacer()
            Button {
                print("다음으로 넘어가기")
                policyStore.pageNumber = 3 // 추가 항목으로 넘어가기
                
                // MARK: - 유저 디폴트, 스토어에 쿼리 변수 저장
                let myEdu: [String] = eduSelectArr
                UserDefaults.standard.set(myEdu, forKey: "myEdu")
                let myEmp: [String] = empSelectArr
                UserDefaults.standard.set(myEmp, forKey: "myEmp")
                let mySpe: [String] = speSelectArr
                UserDefaults.standard.set(mySpe, forKey: "mySpe")
                
                policyStore.eduQuery = myEdu
                policyStore.empQuery = myEmp
                policyStore.speQuery = mySpe
            } label: {
                Text(selectCount == 0 ? "건너뛰기" : "다음으로 넘어가기")
                    .bold()
                    .frame(width: UIScreen.main.bounds.width - 30, height: 52)
                    .background(selectCount == 0 ? Color.blue.opacity(0.3) : selectCount > 10 ? Color.gray : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(13)
            }
            .disabled(selectCount > 10)
        }
        .toast(isPresenting: $isOver10) {
            AlertToast(displayMode: .hud, type: .error(.red), title: "항목 개수를 10개 이하로 줄여주세요")
        }
    }
}

struct EducationView_Previews: PreviewProvider {
    static var previews: some View {
        EducationView()
    }
}
