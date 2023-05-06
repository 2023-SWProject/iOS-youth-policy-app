//
//  YouthCenterTab.swift
//  YouthPolicyPedia
//
//  Created by 김태성 on 2023/04/01.
//

import SwiftUI

struct YouthCenterTab: View {
    
    @EnvironmentObject var policyStore: PolicyStore
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                HStack {
                    Capsule()
                        .frame(width: 90, height: 27)
                        .foregroundColor(.orange).grayscale(1.0)
                        .overlay {
                            
                            HStack {
                                Image(systemName: "location.fill")
                                    .foregroundColor(.purple.opacity(0.8))
                                    .padding(-5)
//                                Text("천안시")
                                Text(policyStore.selectedLocation.first?.key ?? "")
                                    .foregroundColor(.white)
                                    .font(.headline)
                            }
                        }
                    Spacer()
                }
                .padding()
                
                VStack {
                    HStack {
                        Text("**\(policyStore.selectedDetailLocation.first?.key ?? "")** 근처")
                            .font(.system(size: 30))
                        
                        Spacer()
                    }
                    
                    HStack {
                        Text("청년 센터입니다")
                            .font(.system(size: 30))
                        Spacer()
                    }
                    Spacer()
                }
                .padding()
                .foregroundColor(.primary)
                
                // YouthCenterCell -> YouthCenterDetailView
                ForEach(1...2, id: \.self) {_ in
                    
//                    NavigationLink {
//                        YouthCenterDetailView()
                    Button {
                        print("업데이트 예정입니다.")
                    } label: {
                        Rectangle()
                            .foregroundColor(.yellow.opacity(0.2))
                            .frame(width: UIScreen.main.bounds.width - 40, height: 120)
                            .cornerRadius(10)
                            .overlay {
                                
                                HStack {
                                    AsyncImage(
                                        url: URL(string: "https://www.youthcenter.go.kr/framework/filedownload/getImage.do?filePathName=K43kYCzEpw54N3DsTLz6bPgd%2FOPUmucKCGZDlA2w%2BAJd3lxlxhKZVaY6cVGLvIKxIAbgyajbMvnaT5yo8VVeEg%3D%3D"),
                                        content: { image in
                                            image.resizable()
    //                                            .aspectRatio(contentMode: .fit)
                                                .cornerRadius(10)
                                                .padding(7)
                                                .frame(width: 150, height: 115)
                                            //                                        .frame(maxWidth: 400, maxHeight: 110)
                                        },
                                        placeholder: {
                                            ProgressView()
                                        }
                                    )
                                    
                                    VStack {
                                        Text("천안청년센터 불당이음")
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
//            .navigationTitle("청년 센터")
        }
    }
}

struct YouthCenterTab_Previews: PreviewProvider {
    static var previews: some View {
        YouthCenterTab()
    }
}
