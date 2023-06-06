//
//  YouthPolicyTab.swift
//  YouthPolicyPedia
//
//  Created by 김태성 on 2023/04/01.
//

import SwiftUI

struct YouthPolicyTab: View {
    @EnvironmentObject var policyStore: PolicyStore
    
    @Binding var isShowingSelectView: Bool
    @Binding var isShowingOnboardingView: Bool
    
    var body: some View {
        NavigationStack {
            ScrollView {
//                HStack {
//                    VStack {
//                        HStack {
//                            Text("**미정이**의 추천 정책")
//                                .font(.system(size: 25))
//                        }
//                        Spacer()
//                    }
//                    .padding()
//                    .foregroundColor(.primary)
//                }

                showRowFilteredBy(\.신혼부부, "신혼부부")
                showRowFilteredBy(\.일인가구, "일인가구")
                showRowFilteredBy(\.농업인, "농업인")
                showRowFilteredBy(\.소상공인, "소상공인")
                showRowFilteredBy(\.차상위계층, "차상위계층")
                showRowFilteredBy(\.기초생활및생계급여, "기초생활및생계급여")
                showRowFilteredBy(\.무주택자, "무주택자")
                
                HStack {
                    Text("신청가능성이 있는 **\(policyStore.policies.count)개** 정책")
                    .bold()
                    .padding(.leading, 20)
                        
                    Spacer()
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
                                            Spacer()
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
            .navigationTitle("미정이의 추천 정책")
            .toolbar {
                Button {
                    print("123")
                } label: {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.black)
                }
            }
        }
    }
    
    @ViewBuilder
    func showRowFilteredBy(_ keyPath: KeyPath<Policy, String>, _ message: String) -> some View {
        if policyStore.policies.contains(where: { $0[keyPath: keyPath] != "-" }) {
            Group {
                HStack {
                    Group {
                        switch message {
                        case "신혼부부":
                            Text("당신이 신혼부부라면? 😘")
                        case "일인가구":
                            Text("혼밥 노노 1인 가구 🙆‍♂️🙆‍♀️")
                        case "농업인":
                            Text("농업인 아자아자 👩‍🌾🧑‍🌾🌾🥕")
                        case "소상공인":
                            Text("소상공인?")
                        case "차상위계층":
                            Text("차상위계층 아자아자 🥕")
                        case "기초생활및생계급여":
                            Text("기초생활및생계급여 아자아자 🥕")
                        case "무주택자":
                            Text("무주택자 아자아자 🥕")
                        default:
                            Text("ERR")
                        }
                    }
                    .bold()
                    .padding(.leading, 20)
                        
                    Spacer()
                }
                
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(policyStore.policies) {p in
                            if p[keyPath: keyPath] != "-" { // p.tag
                                NavigationLink {
                                    PolicyDetailView(policy: p)
                                } label: {
                                    ZStack {
                                        Rectangle()
                                            .frame(width: 130, height: 150)
                                            .foregroundColor(Color("myCellColor"))
                                            .cornerRadius(10)
                                            .padding(.leading, 15)
                                            .padding(.bottom, 40)
                                            .zIndex(1)
                                            .overlay {
                                                VStack {
                                                    HStack {
                                                        Text("\(p.title)")
                                                            .foregroundColor(.black)
                                                            .lineLimit(2)
                                                            .padding()
                                                            .padding(.leading, 5)
                                                    }
                                                    Spacer()
                                                    HStack {
                                                        Rectangle()
                                                            .cornerRadius(100)
                                                            .foregroundColor(.white.opacity(0.6))
                                                            .frame(width: 60, height: 30)
                                                            .overlay {
                                                                Text("#\(p.tags)")
                                                                    .font(.system(size: 12))
                                                                    .opacity(0.5)
                                                            }
                                                    }
                                                    .padding(.bottom, 10)
                                                    .padding(.trailing, 30)
                                                    
                                                    Spacer()
                                                }
                                            }
                                        
                                        Rectangle()
                                            .frame(width: 130, height: 150)
                                            .foregroundColor(.gray.opacity(0.2))
                                            .cornerRadius(10)
                                            .padding(.leading, 15)
                                            .padding(.bottom, 40)
                                            .offset(x: 5, y: 5)
                                            .zIndex(0)
                                    }
                                }
                            }
                        }
                    }
                }.scrollIndicators(.hidden)
            }
        } else {
            EmptyView()
        }
    } 
}

struct YouthPolicyTab_Previews: PreviewProvider {
    static var previews: some View {
        YouthPolicyTab(isShowingSelectView: .constant(false), isShowingOnboardingView: .constant(false))
            .environmentObject(PolicyStore())
    }
}
