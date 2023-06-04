//
//  AgeSelectView.swift
//  YouthPolicyPedia
//
//  Created by 김태성 on 2023/05/02.
//

import SwiftUI

struct AgeSelectView: View {
    @EnvironmentObject var policyStore: PolicyStore
    @State private var birthDate = Date()
    @State private var age: DateComponents = DateComponents()
    @State private var 계산할나이: DateComponents = DateComponents()
    
    @Binding var isShowingSelectView: Bool
    @Binding var isShowingOnboardingView: Bool
    
    @State var isShowingSheet = false
    @State var isShowingButton = false
    
    var body: some View{
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
            
            HStack {
                Text("생년월일을 입력해주세요.")
                    .bold()
                    .font(.system(size: 20))
                Spacer()
            }
            .padding()
            
            HStack {
                Text("\(String(age.year ?? 2023))년 \(age.month ?? 1)월 \(age.day ?? 1)일")
                    .padding()
                    .overlay {
                        Rectangle()
                            .foregroundColor(.blue.opacity(0.25))
                            .cornerRadius(10)
                            .frame(width: UIScreen.main.bounds.width - 50, height: 50)
                    }
            }
            .contentShape(Rectangle())
            .onTapGesture {
                isShowingSheet = true
                isShowingButton = true
            }
            
            Spacer()
            
            if isShowingButton {
                Button {
                    policyStore.userAge = 계산할나이.year ?? 0
                    
                    // MARK: - 유저디폴트에 정보 저장
                    let userLocationInformation = policyStore.selectedLocation
                    UserDefaults.standard.set(userLocationInformation, forKey: "myLocation")
                    
                    let userDetailLocationInformation = policyStore.selectedDetailLocation
                    UserDefaults.standard.set(userDetailLocationInformation, forKey: "myDetailLocation")
                    
                    let userAgeInformation = policyStore.userAge
                    UserDefaults.standard.set(userAgeInformation, forKey: "myAge")
                    
                    UserDefaults.standard.set(false, forKey: "isShowingSelectView")
                    isShowingSelectView = false
                } label: {
                    Text("나이 입력하기")
                        .bold()
                        .frame(width: UIScreen.main.bounds.width - 30, height: 52)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(13)
                }
            }
        }
        .sheet(isPresented: $isShowingSheet) {
            Group {
                DatePicker("Birth date:", selection: $birthDate, in: ...Date(), displayedComponents: .date)
                    .datePickerStyle(WheelDatePickerStyle())
                    .font(.title)
                    .labelsHidden()
                
            }.onChange(of: birthDate, perform: { value in
                age = Calendar.current.dateComponents([.year, .month, .day], from: birthDate)
                계산할나이 = Calendar.current.dateComponents([.year], from: birthDate, to: Date())
            })
                .presentationDetents([.height(200), .medium, .large])
                .presentationDragIndicator(.hidden)
        }
    }
}

//struct AgeSelectView_Previews: PreviewProvider {
//    static var previews: some View {
//        AgeSelectView()
//    }
//}
