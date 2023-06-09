//
//  AckView.swift
//  YouthPolicyPedia
//
//  Created by 김태성 on 2023/06/09.
//

import SwiftUI

struct AckView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text("Source Libraries:")
                    .fontWeight(.semibold)
                Text("AlertToast")
                Text("Firebase")
                Text("LottieUI")
            }
            .foregroundColor(.gray)
            .padding(.bottom, 5)
            
            Group {
                Text("API:")
                    .fontWeight(.semibold)
                
                Text("The data used by 미정이")
                HStack{
                    Text("is from")
                    Text("온라인청년센터 API")
                        .underline(true, color: .gray)
                }
            }
            .foregroundColor(.gray)
            .padding(.bottom, 5)
            
            Group {
                Text("Image:")
                    .fontWeight(.semibold)
                Text("온라인청년센터")
                    .tint(.gray)
            }
            .foregroundColor(.gray)
            .padding(.bottom, 5)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .navigationBarTitle("라이선스", displayMode: .inline)
    }
}

struct AckView_Previews: PreviewProvider {
    static var previews: some View {
        AckView()
    }
}
