//
//  SelectConditionView.swift
//  YouthPolicyPedia
//
//  Created by 김태성 on 2023/04/29.
//

import SwiftUI

struct SelectConditionView: View {
    @State var selectedLoaction = ""
    var locations = ["서울", "부산", "대구", "인천", "광주", "대전", "울산", "경기", "강원", "충북", "충남", "전북", "전남", "경북", "경남", "제주", "세종"]
    
    var body: some View {
        VStack {
            Picker("지역 선택창", selection: $selectedLoaction) {
                ForEach(locations, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.automatic)
            .cornerRadius(15)
            
            
//            Picker("세부 지역 선택창", selection: $selectedLoaction) {
//                ForEach(locations, id: \.self) {
//                    Text($0)
//                }
//            }
                
            
            Text("\(selectedLoaction) 선택함")
        }
    }
}

struct SelectConditionView_Previews: PreviewProvider {
    static var previews: some View {
        SelectConditionView()
    }
}
