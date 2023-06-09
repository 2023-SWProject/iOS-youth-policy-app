//
//  CIRCLETESTVIEW.swift
//  YouthPolicyPedia
//
//  Created by 김태성 on 2023/06/09.
//

import SwiftUI

struct CIRCLETESTVIEW: View {
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 30) {
                ForEach(1...5, id: \.self) {_ in
                    TESTCELL()
                }
            }
        }
    }
}

struct CIRCLETESTVIEW_Previews: PreviewProvider {
    static var previews: some View {
        CIRCLETESTVIEW()
    }
}

struct TESTCELL: View {
    var body: some View {
        HStack {
            Button {
                //            buttonAction("\(center.url)", .link)
                //                        isShowingAlert.toggle()
            } label: {
                VStack {
                    ZStack {
                        // 사진
                        AsyncImage(
                            url: URL(string: "https://www.youthcenter.go.kr/framework/filedownload/getImage.do?filePathName=K43kYCzEpw54N3DsTLz6bPgd%2FOPUmucKCGZDlA2w%2BAJd3lxlxhKZVaY6cVGLvIKxIAbgyajbMvnaT5yo8VVeEg%3D%3D"),
                            content: { image in
                                image.resizable()
                                    .cornerRadius(10)
                                    .frame(maxWidth: 400, maxHeight: 110)
                            },
                            placeholder: {
                                ProgressView()
                            }
                        )
                            .frame(width: 150, height: 110)
                            .cornerRadius(10)
                            .zIndex(1)
                            .background(
                                RoundedRectangle(cornerRadius: 10.0)
                                    .fill(Color.white)
                                    .shadow(radius: 3, x: 1, y: 1)
                            )
                        
                        Rectangle()
                            .foregroundColor(.green.opacity(0.8))
                            .frame(width: 150, height: 110)
                            .cornerRadius(10)
                            .padding(.top, 100)

                        Text("우리두리지역아동센터") // name
                            .lineLimit(2)
                            .foregroundColor(.black)
                            .bold()
                            .font(.system(size: 16))
                            .zIndex(2)
                            .padding(.top, 150)
                            .frame(maxWidth: 150)
                    }
                }
                
            }
        }
    }
}
