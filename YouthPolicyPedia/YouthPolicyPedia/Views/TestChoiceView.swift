//
//  TestChoiceView.swift
//  YouthPolicyPedia
//
//  Created by 김태성 on 2023/05/03.
//

import SwiftUI

struct TestChoiceView: View {
    @Binding var gotoNextPage: Bool
    @EnvironmentObject var policyStore: PolicyStore
    
    @State private var selectedLoaction = ""
    var locations = ["서울", "부산", "대구", "인천", "광주", "대전", "울산", "경기", "강원", "충북", "충남", "전북", "전남", "경북", "경남", "제주", "세종"]
    @State private var detailLocations: [String] = []
    @State private var selectedDetailLoaction = ""
    
    @State private var selection = 0
    var body: some View {
        TabView(selection: $selection) {
            Group {
                Picker("지역 선택창", selection: $selectedLoaction) {
                    ForEach(locations, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.automatic)
                .cornerRadius(15)
                .onChange(of: selectedLoaction) { _ in
                    detailLocations = showDetailLocation(location: selectedLoaction)
                    selection = 1
                }
            }
            .font(.system(size: 30))
            .tag(0)
            Group {
                if selectedLoaction != "" {
                    Picker("세부 지역 선택창", selection: $selectedDetailLoaction) {
                        ForEach(detailLocations, id: \.self) {
                            Text($0)
                        }
                    }
                    .onChange(of: selectedDetailLoaction) { _ in
                        selection = 2
                    }
                } else {
                    Text("지역을 먼저 선택해 주세요")
                }
            }
            .font(.system(size: 30))
            .tag(1)
            
            InputAgeView(isShowingInputAgeView: $gotoNextPage)
                .font(.system(size: 30))
                .tag(2)
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
}

func showDetailLocation(location: String) -> [String] {
    switch location {
    case "서울":
        return ["종로구", "중구용", "산구성", "동구광", "진구동", "대문구", "중랑구", "성북구", "강북구", "도봉구", "노원구", "은평구", "서대문구", "마포구", "양천구", "강서구", "구로구", "금천구", "영등포구", "동작구", "관악구", "서초구", "강남구", "송파구"]
    default:
        return ["미", "완", "성"]
    }
}

//struct TestChoiceView_Previews: PreviewProvider {
//    static var previews: some View {
//        TestChoiceView()
//            .environmentObject(PolicyStore())
//    }
//}
