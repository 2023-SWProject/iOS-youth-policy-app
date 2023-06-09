//
//  LocationSelectView.swift
//  YouthPolicyPedia
//
//  Created by 김태성 on 2023/05/05.
//

import SwiftUI

struct LocationSelectView: View {
    @EnvironmentObject var policyStore: PolicyStore
    
    let locations: [String: String] = ["경남": "003002015", "전북": "003002012", "광주": "003002005", "서울": "003002001", "대구": "003002003", "인천": "003002004", "울산": "003002007", "제주": "003002016", "전남": "003002013", "충남": "003002011", "경기": "003002008", "경북": "003002014", "강원": "003002009", "대전": "003002006", "세종": "003002017", "부산": "003002002", "충북": "003002010"]
    
    @State private var selectedCount = 0
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    print("뒤로가기")
                    // 초기화
                    policyStore.selectedDetailLocation = [:]
                    policyStore.selectedLocation = [:]
                } label: {
                    Image(systemName: "chevron.left")
                        .bold()
                        .foregroundColor(.clear)
                }
                Spacer()
            }
            .padding()
            
            VStack {
                HStack {
                    Text("정책을 보고싶은")
                        .bold()
                        .font(.title)
                    Spacer()
                }
                
                HStack {
                    Text("지역을 선택해주세요")
                        .bold()
                        .font(.title)
                    Spacer()
                }
            }
            .padding()
            
            ScrollView {
                ForEach(locations.sorted(by: <), id: \.key) { location, code in
                    locationListItem(locationName: location, locationCode: code, selectedLocation: $policyStore.selectedLocation, selectedCount: $selectedCount)
                }
                Rectangle()
                    .frame(height: 40)
                    .foregroundColor(.clear)
            }
        }
    }
}

struct LocationSelectView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSelectView()
            .environmentObject(PolicyStore())
    }
}

struct locationListItem: View {
    
    @EnvironmentObject var policyStore: PolicyStore
    
    @State private var isSelected: Bool = false
    var locationName: String
    var locationCode: String
    @Binding var selectedLocation: [String: String]
    @Binding var selectedCount: Int
    
    var body: some View {
        HStack {
            Text("\(locationName)")
                .foregroundColor(isSelected ? .black : .black.opacity(0.6))
                .bold()
                .padding()
            Spacer()
            Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                .foregroundColor(isSelected ? .accentColor : .gray.opacity(0.4))
                .animation(.easeIn(duration: 0.2))
                .foregroundColor(.accentColor)
                .padding()
        }
        .contentShape(Rectangle())
        .onTapGesture {
            if selectedCount == 0 {
                selectedLocation = [locationName: locationCode]
                policyStore.detailLocation = policyStore.giveDetailLocation(locationName)
                selectedCount += 1
                isSelected = true
                policyStore.pageNumber = -1
            } else if selectedLocation == [locationName: locationCode] {
                selectedCount -= 1
                isSelected = false
                selectedLocation = [:]
            }
            print(selectedLocation)
        }
    }
}
