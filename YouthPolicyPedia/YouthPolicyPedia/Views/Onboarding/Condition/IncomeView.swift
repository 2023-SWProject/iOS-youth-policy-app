//
//  IncomeView.swift
//  YouthPolicyPedia
//
//  Created by 김태성 on 2023/06/04.
//

import SwiftUI

enum IncomeQuintile: Int, CaseIterable, Identifiable {
    case one = 1
    case two
    case three
    case four
    case five
    case six
    case seven
    case eight
    case nine
    case ten
    case x
    
    var id: Int { self.rawValue }
}

struct IncomeView: View {
    @EnvironmentObject var policyStore: PolicyStore
    @State private var selectedIncomeQuintile = IncomeQuintile.one
    
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    print("뒤로가기")
                    // TODO: 만약 앱을 여기서 강제종료하면 앱이 복구 불가능 하다.
                    // 처음 앱을 켰을때 쿼리 변수가 안골라져 있다면 다 초기화 해버리기? 해바라기
                    // 초기화
                    policyStore.pageNumber = 2
                    // MARK: - 유저 디폴트, 스토어에 쿼리 변수 초기화
                    let myEdu: [String] = []
                    UserDefaults.standard.set(myEdu, forKey: "myEdu")
                    let myEmp: [String] = []
                    UserDefaults.standard.set(myEmp, forKey: "myEmp")
                    let mySpe: [String] = []
                    UserDefaults.standard.set(mySpe, forKey: "mySpe")
                    
                    policyStore.eduQuery = myEdu
                    policyStore.empQuery = myEmp
                    policyStore.speQuery = mySpe
                } label: {
                    Image(systemName: "chevron.left")
                        .bold()
                        .foregroundColor(.black)
                }
                Spacer()
            }
            .padding()
            
            VStack {
                HStack {
                    Text("소득 분위를 골라주세요")
                        .bold()
                        .font(.system(size: 25))
                    Spacer()
                }
                HStack {
                    Text("더 정확한 추천이 가능해집니다!")
                        .foregroundColor(.gray)
                        .font(.system(size: 15))
                    Spacer()
                }
            }
            .padding()
            
            Picker("IncomeQuintile", selection: $selectedIncomeQuintile) {
                Group {
                    Text("1분위").tag(IncomeQuintile.one)
                    Text("2분위").tag(IncomeQuintile.two)
                    Text("3분위").tag(IncomeQuintile.three)
                    Text("4분위").tag(IncomeQuintile.four)
                    Text("5분위").tag(IncomeQuintile.five)
                }
                Group {
                    Text("6분위").tag(IncomeQuintile.six)
                    Text("7분위").tag(IncomeQuintile.seven)
                    Text("8분위").tag(IncomeQuintile.eight)
                    Text("9분위").tag(IncomeQuintile.nine)
                    Text("10분위").tag(IncomeQuintile.ten)
                    Text("비공개").tag(IncomeQuintile.x)
                }
            }.pickerStyle(.inline)
//            Text("나는 \(selectedIncome.rawValue) 분위입니다")
            
            Spacer()
            
            Button {
                print("다음으로 고")
                policyStore.pageNumber = 100 // 추가 항목으로 넘어가기
                
            } label: {
                Text("다음으로 넘어가기")
                    .bold()
                    .frame(width: UIScreen.main.bounds.width - 30, height: 52)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(13)
            }

        }
    }
}

struct IncomeView_Previews: PreviewProvider {
    static var previews: some View {
        IncomeView()
    }
}

//import SwiftUI
//
//struct IncomeView: View {
//    @EnvironmentObject var policyStore: PolicyStore
//    
//    @State private var incName: [String: String] = ["무주택자": "", "1인가구": "", "신혼부부": "", "농업인": "", "소상공인": "", "차상위계층": "", "기초생활 및 생계급여": ""]
//    
//    var name: [String] = ["무주택자", "1인가구", "신혼부부", "농업인", "소상공인" ,"차상위계층",  "기초생활 및 생계급여"]
//    
//    @State private var choiceCount = 0
//    @State private var 무주택자 = ""
//    
//    var body: some View {
//        VStack {
//            HStack {
//                Button {
//                    print("뒤로가기")
//                    // TODO: 만약 앱을 여기서 강제종료하면 앱이 복구 불가능 하다.
//                    // 처음 앱을 켰을때 쿼리 변수가 안골라져 있다면 다 초기화 해버리기? 해바라기
//                    // 초기화
//                    policyStore.pageNumber = 2
//                    // MARK: - 유저 디폴트, 스토어에 쿼리 변수 초기화
//                    let myEdu: [String] = []
//                    UserDefaults.standard.set(myEdu, forKey: "myEdu")
//                    let myEmp: [String] = []
//                    UserDefaults.standard.set(myEmp, forKey: "myEmp")
//                    let mySpe: [String] = []
//                    UserDefaults.standard.set(mySpe, forKey: "mySpe")
//                    
//                    policyStore.eduQuery = myEdu
//                    policyStore.empQuery = myEmp
//                    policyStore.speQuery = mySpe
//                } label: {
//                    Image(systemName: "chevron.left")
//                        .bold()
//                        .foregroundColor(.black)
//                }
//                Spacer()
//            }
//            .padding()
//            
//            Group {
//                HStack {
//                    Text("추가 항목")
//                        .bold()
//                        .padding()
//                    Spacer()
//                }
//                HStack {
//                    ForEach(0...2, id: \.self) { i in
//                        Button {
//                            if incName[name[i]] == "" {
//                                incName[name[i]] = "1"
//                                choiceCount += 1
//                            } else if incName[name[i]] == "1" {
//                                incName[name[i]] = ""
//                                choiceCount -= 1
//                            }
//                        } label: {
//                            Text("\(name[i])")
//                                .padding(.vertical, 5)
//                                .padding(.horizontal, 10)
//                                .foregroundColor(.brown)
//                                .background(Rectangle().fill(incName[name[i]] == "1" ? .yellow.opacity(0.5) : .white))
//                                .overlay(
//                                    Rectangle().strokeBorder(.brown)
//                                )
//                        }
//                    }
//                }
//                
//                HStack {
//                    ForEach(3...5, id: \.self) { i in
//                        Button {
//                            if incName[name[i]] == "" {
//                                incName[name[i]] = "1"
//                                choiceCount += 1
//                            } else if incName[name[i]] == "1" {
//                                incName[name[i]] = ""
//                                choiceCount -= 1
//                            }
//                        } label: {
//                            Text("\(name[i])")
//                                .padding(.vertical, 5)
//                                .padding(.horizontal, 10)
//                                .foregroundColor(.brown)
//                                .background(Rectangle().fill(incName[name[i]] == "1" ? .yellow.opacity(0.5) : .white))
//                                .overlay(
//                                    Rectangle().strokeBorder(.brown)
//                                )
//                        }
//                    }
//                }
//                
//                HStack {
//                    ForEach(6...6, id: \.self) { i in
//                        Button {
//                            if incName[name[i]] == "" {
//                                incName[name[i]] = "1"
//                                choiceCount += 1
//                            } else if incName[name[i]] == "1" {
//                                incName[name[i]] = ""
//                                choiceCount -= 1
//                            }
//                        } label: {
//                            Text("\(name[i])")
//                                .padding(.vertical, 5)
//                                .padding(.horizontal, 10)
//                                .foregroundColor(.brown)
//                                .background(Rectangle().fill(incName[name[i]] == "1" ? .yellow.opacity(0.5) : .white))
//                                .overlay(
//                                    Rectangle().strokeBorder(.brown)
//                                )
//                        }
//                    }
//                }
//            }
//            
//            Spacer()
//            Button {
//                print("다음으로 넘어가기")
//                policyStore.pageNumber = 100 // 나이로 넘어가기
//                
//                // MARK: - 유저 디폴트, 스토어에 쿼리 변수 저장
//                
//                
//            } label: {
//                Text("다음으로 넘어가기")
//                    .bold()
//                    .frame(width: UIScreen.main.bounds.width - 30, height: 52)
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(13)
//            }
//            .opacity(choiceCount > 0 ? 1 : 0)
//        }
//    }
//}
//
//struct IncomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        IncomeView()
//    }
//}
