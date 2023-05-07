//
//  YouthPolicyTab.swift
//  YouthPolicyPedia
//
//  Created by 김태성 on 2023/04/01.
//

import SwiftUI

struct YouthPolicyTab: View {
    @EnvironmentObject var policyStore: PolicyStore
    @State var searchText = ""
    @State var selectedFilter = "추천순"
    var filterOptions = ["추천순", "마감일순", "조회순", "지원금순", "기능구현중.."]
    var userName = "당"
    
    @Binding var isShowingSelectView: Bool
    @Binding var isShowingOnboardingView: Bool
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                HStack {
                    VStack {
                        HStack {
                            Text("**\(userName)신**을 위한 **\(policyStore.policies.count)건**의 정책")
                                .font(.system(size: 25))
                            Spacer()
                        }
                        Spacer()
                    }
                    .padding()
                    .foregroundColor(.primary)
                    Spacer()
                    VStack {
                        Picker("필터고르기", selection: $selectedFilter) {
                            ForEach(filterOptions, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(.menu)
                        .cornerRadius(15)
                    }
                }
                
                ForEach(policyStore.policies, id: \.bizid) { policy in
                    NavigationLink {
                        PolicyDetailView(policy: policy)
                    } label: {
                        Rectangle()
                            .foregroundColor(.cyan.opacity(0.1))
                            .frame(width: UIScreen.main.bounds.width - 40, height: 80)
                            .cornerRadius(10)
                            .overlay {
                                
                                HStack {
                                    VStack {
                                        Text("\(policy.title)")
                                            .padding(.top, 50)
                                            .foregroundColor(.black)
                                            .bold()
                                        
                                        HStack {
                                            
//                                            Text("\(policy.content)")
//                                                .font(.system(size: 10))
//                                                .foregroundColor(.black)
//                                                .lineLimit(2)
                                            Spacer()
//
//                                            Image(systemName: "chevron.right")
//                                                .foregroundColor(.blue)
                                        }
                                        .padding(.bottom, 40)
                                        .padding()
                                        
                                    }
                                    Spacer()
                                }
                                
                            }
                    }
                }
                .padding(.bottom, 10)
            }
            .navigationTitle("청년 정책")
            .navigationBarTitleDisplayMode(.inline)
            
            .toolbar {
                
                NavigationLink {
                    SettingView(isShowingSelectView: $isShowingSelectView, isShowingOnboardingView: $isShowingOnboardingView)
                } label: {
                    Image(systemName: "person.circle")
                }

            }
        }
        
        .searchable(
            text: $searchText,
            placement: SearchFieldPlacement.automatic,
            prompt: "정책을 찾아보세요"
        )
        
    }
}

struct YouthPolicyTab_Previews: PreviewProvider {
    static var previews: some View {
        YouthPolicyTab(isShowingSelectView: .constant(false), isShowingOnboardingView: .constant(false))
            .environmentObject(PolicyStore())
    }
}
