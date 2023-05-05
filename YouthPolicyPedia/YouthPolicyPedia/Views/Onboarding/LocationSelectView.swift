//
//  LocationSelectView.swift
//  YouthPolicyPedia
//
//  Created by 김태성 on 2023/05/05.
//

import SwiftUI

struct LocationSelectView: View {
    
    @EnvironmentObject var policyStore: PolicyStore
    
    let locations = ["서울", "부산", "대구", "인천", "광주", "대전", "울산", "경기", "강원", "충북", "충남", "전북", "전남", "경북", "경남", "제주", "세종"]
    @State private var selectedCount = 0
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    print("뒤로가기")
                } label: {
                    Image(systemName: "chevron.left")
                        .bold()
                        .foregroundColor(.black)
                }
                Spacer()
            }
            .padding()
            // 임시 선택 갯수 표시
            //            Text("\(selectedCount) / 1")
            
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
                ForEach(locations, id: \.self) { location in
                    locationListItem(location: location, selectedLocation: $policyStore.selectedLocation, selectedCount: $selectedCount)
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
    }
}

struct locationListItem: View {
    
    @EnvironmentObject var policyStore: PolicyStore
    
    @State private var isSelected: Bool = false
    var location: String
    @Binding var selectedLocation: String
    @Binding var selectedCount: Int
    
    var body: some View {
        HStack {
            Text("\(location)")
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
                selectedCount += 1
                isSelected = true
                selectedLocation = location
                policyStore.pageNumber = -1
            } else if selectedLocation == location {
                selectedCount -= 1
                isSelected = false
                selectedLocation = ""
            }
            print(selectedLocation)
        }
    }
}
