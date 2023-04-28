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
    var filterOptions = ["추천순", "마감일순", "조회순", "지원금순"]
    var userName = "미정"
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                HStack {
                    VStack {
                        HStack {
                            Text("**\(userName)님**을 위한 **\(policyStore.policies.count)건**의 정책")
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
//                        YouthCenterDetailView()
                        PolicyDetailView(policy: policy)
                    } label: {
                        Rectangle()
                            .foregroundColor(.yellow.opacity(0.2))
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
                                            Spacer()
                                            
                                            Image(systemName: "chevron.right")
                                                .foregroundColor(.blue)
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
        YouthPolicyTab()
    }
}
