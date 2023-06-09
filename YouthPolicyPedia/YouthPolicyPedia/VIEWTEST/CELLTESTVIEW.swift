//
//  CELLTESTVIEW.swift
//  YouthPolicyPedia
//
//  Created by 김태성 on 2023/06/04.
//

import SwiftUI

struct CELLTESTVIEW: View {
    var body: some View {
        ScrollView {
            HStack {
                VStack {
                    HStack {
                        Text("**미정이**의 **당신**을 위한 **10건**의 정책")
                            .font(.system(size: 25))
                        Spacer()
                    }
                    Spacer()
                }
                .padding()
                .foregroundColor(.primary)
            }
                
            // MARK: - if 신혼부부 count > 0 ? 나오게 : 안나오게
            Group {
                HStack {
                    Text("당신이 신혼부부라면? 😘")
                        .bold()
                        .padding(.leading, 20)
                    Spacer()
                }
                
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(1...5, id: \.self) {_ in
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
                                                Text("대학생 청소년 교육 지원 활동")
                                                    .font(.system(size: 15))
                                                    .lineLimit(2)
                                                    .padding()
                                                    .padding(.leading, 5)
                                            }
                                            Spacer()
                                            HStack {
                                                Rectangle()
                                                    .cornerRadius(5)
                                                    .foregroundColor(.white.opacity(0.6))
                                                    .frame(width: 60, height: 30)
                                                    .overlay {
                                                        ZStack {
                                                            Text("#창업 지원")
                                                                .font(.system(size: 12))
                                                                .opacity(0.5)
                                                                .zIndex(1)
                                                                .monospacedDigit()
                                                            
                                                            Rectangle()
                                                                .foregroundColor(.red)
                                                                .frame(width: 55, height: 24)
                                                                .cornerRadius(5)
                                                                .opacity(0.5)
                                                        }
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
                }.scrollIndicators(.hidden)
            }
            
            HStack {
                Text("혼밥 노노 1인 가구 🙆‍♂️🙆‍♀️")
                    .bold()
                    .padding(.leading, 20)
                Spacer()
            }
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(1...5, id: \.self) {_ in
                        ZStack {
                            Rectangle()
                                .frame(width: 130, height: 150)
                                .foregroundColor(Color("myCellColor2"))
                                .cornerRadius(10)
                                .padding(.leading, 15)
                                .padding(.bottom, 40)
                                .zIndex(1)
                            
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
            }.scrollIndicators(.hidden)
            
            HStack {
                Text("농업인 아자아자 👩‍🌾🧑‍🌾🌾🥕")
                    .bold()
                    .padding(.leading, 20)
                Spacer()
            }
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(1...5, id: \.self) {_ in
                        ZStack {
                            Rectangle()
                                .frame(width: 130, height: 150)
                                .foregroundColor(Color("myCellColor3"))
                                .cornerRadius(10)
                                .padding(.leading, 15)
                                .padding(.bottom, 40)
                                .zIndex(1)
                            
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
            }.scrollIndicators(.hidden)
        }
    }
}


struct CELLTESTVIEW_Previews: PreviewProvider {
    static var previews: some View {
        CELLTESTVIEW()
    }
}
