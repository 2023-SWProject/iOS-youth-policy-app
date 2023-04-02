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
    var colors = ["추천순", "green", "blue"]

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                HStack {
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
                
//                VStack {
//                    HStack {
//                        Text("**천안시** 근처")
//                            .font(.system(size: 30))
//                        
//                        Spacer()
//                    }
//                    
//                    HStack {
//                        Text("청년 센터입니다")
//                            .font(.system(size: 30))
//                        Spacer()
//                    }
//                    Spacer()
//                }
//                .padding()
//                .foregroundColor(.primary)
                
                // YouthCenterCell -> YouthCenterDetailView
                ForEach(1...2, id: \.self) {_ in
                    
                    NavigationLink {
//                        YouthCenterDetailView()
                    } label: {
                        Rectangle()
                            .foregroundColor(.yellow.opacity(0.2))
                            .frame(width: UIScreen.main.bounds.width - 40, height: 120)
                            .cornerRadius(10)
                            .overlay {
                                
                                HStack {
                                    VStack {
                                        Text("독거노인 ")
                                            .padding(.top, 50)
                                            .foregroundColor(.blue)
                                        
                                        HStack {
                                            Text("운영시간")
                                                .foregroundColor(.black)
                                            Text("08:00 - 18:00")
                                                .foregroundColor(.secondary)
                                                .padding(.top, 1)
                                        }
                                        
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
