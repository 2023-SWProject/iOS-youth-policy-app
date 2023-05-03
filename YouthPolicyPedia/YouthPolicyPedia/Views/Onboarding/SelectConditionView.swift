//
//  SelectConditionView.swift
//  YouthPolicyPedia
//
//  Created by 김태성 on 2023/04/29.
//

import SwiftUI

struct SelectConditionView: View {
    @State private var selectedLoaction = ""
    var locations = ["서울", "부산", "대구", "인천", "광주", "대전", "울산", "경기", "강원", "충북", "충남", "전북", "전남", "경북", "경남", "제주", "세종"]
    @State private var detailLocations: [String] = []
    @State private var selectedDetailLoaction = ""
    
    var body: some View {
        VStack {
            Picker("지역 선택창", selection: $selectedLoaction) {
                ForEach(locations, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.automatic)
            .cornerRadius(15)
            .onTapGesture {
                detailLocations = showDetailLocation(location: selectedLoaction)
                print(detailLocations)
            }
            
            // TODO: 지역 선택했을때 세부 지역 맞는 세부지역으로 보이게 하기
            
            if selectedLoaction != "" {
                Picker("세부 지역 선택창", selection: $selectedDetailLoaction) {
                    ForEach(detailLocations, id: \.self) {
                        Text($0)
                    }
                }
            }
            
            
            Text("지역 -> \(selectedLoaction) 선택함")
            Text("상세 지역 -> \(selectedDetailLoaction) 선택함")
        }
    }
}

func showDetailLocation(location: String) -> [String] {
    switch location {
    case "서울":
        return ["종로구", "중구용", "산구성", "동구광", "진구동", "대문구", "중랑구", "성북구", "강북구", "도봉구", "노원구", "은평구", "서대문구", "마포구", "양천구", "강서구", "구로구", "금천구", "영등포구", "동작구", "관악구", "서초구", "강남구", "송파구"]
    default:
        return ["1", "2"]
    }
}

struct SelectConditionView_Previews: PreviewProvider {
    static var previews: some View {
        SelectConditionView()
    }
}
