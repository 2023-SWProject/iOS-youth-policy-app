//
//  CIRCLETESTVIEW.swift
//  YouthPolicyPedia
//
//  Created by 김태성 on 2023/06/09.
//

import SwiftUI

struct CIRCLETESTVIEW: View {
    var body: some View {
        HStack {
            Capsule()
                .frame(width: 90, height: 27)
                .foregroundColor(.orange)
                .overlay {
                    HStack {
                        Image(systemName: "location.fill")
//                            .foregroundColor()
                            .padding(-5)
                        Text("충남")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                }
            Spacer()
        }
        .padding()
    }
}

struct CIRCLETESTVIEW_Previews: PreviewProvider {
    static var previews: some View {
        CIRCLETESTVIEW()
    }
}
