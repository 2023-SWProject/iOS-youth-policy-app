//
//  YouthPolicyTab.swift
//  YouthPolicyPedia
//
//  Created by 김태성 on 2023/04/01.
//

import SwiftUI

struct YouthPolicyTab: View {
    @State var searchText = ""
    @State var selectedColor = "color"
    var colors = ["추천순", "마감일순", "조회순", "지원금"]

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                HStack {
                    VStack {
                        HStack {
                            Text("미정을 위한 **1건**의 정책")
                                .font(.system(size: 25))
                            
                            Spacer()
                        }
                       
                        Spacer()
                    }
                    .padding()
                    .foregroundColor(.primary)
                    Spacer()
                    VStack {
                          Picker("Choose a color", selection: $selectedColor) {
                            ForEach(colors, id: \.self) {
                              Text($0)
                            }
                          }
                          .pickerStyle(.menu)
                          
                          .cornerRadius(15)
                          
                        }
                }
                
                ForEach(1...1, id: \.self) {_ in
                    
                    NavigationLink {
//                        YouthCenterDetailView()
                    } label: {
                        Rectangle()
                            .foregroundColor(.yellow.opacity(0.2))
                            .frame(width: UIScreen.main.bounds.width - 40, height: 80)
                            .cornerRadius(10)
                            .overlay {
                                
                                HStack {
                                    VStack {
                                        Text("청년 창업 지원금 보조 정책")
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
