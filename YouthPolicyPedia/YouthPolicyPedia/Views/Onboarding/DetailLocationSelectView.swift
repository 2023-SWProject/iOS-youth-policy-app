//
//  DetailLocationSelectView.swift
//  YouthPolicyPedia
//
//  Created by 김태성 on 2023/05/05.
//

import SwiftUI

struct DetailLocationSelectView: View {
    
    @EnvironmentObject var policyStore: PolicyStore
    
    @Binding var isShowingSelectView: Bool
    
    var detailLocations: [String] = ["종로구", "중구용", "산구성", "동구광", "진구동", "대문구", "중랑구", "성북구", "강북구", "도봉구", "노원구", "은평구", "서대문구", "마포구", "양천구", "강서구", "구로구", "금천구", "영등포구", "동작구", "관악구", "서초구", "강남구", "송파구"].sorted()
    
    @State private var selectedCount = 0
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    print("뒤로가기")
                    policyStore.pageNumber = 0
                    policyStore.selectedDetailLocation = []
                } label: {
                    Image(systemName: "chevron.left")
                        .bold()
                        .foregroundColor(.black)
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
                    Text("세부 지역을 선택해주세요")
                        .bold()
                        .font(.title)
                    Spacer()
                }
            }
            .padding()
            
            ScrollView {
                ForEach(detailLocations, id: \.self) { location in
                    DetailLocationListItem(location: location, selectedLocation: $policyStore.selectedDetailLocation, selectedCount: $selectedCount)
                }
                Rectangle()
                    .frame(height: 40)
                    .foregroundColor(.clear)
            }
            
            // MARK: - 다음으로 넘어가는 버튼
            if selectedCount > 0 {
                Button {
                    UserDefaults.standard.set(false, forKey: "isShowingSelectView")
                    isShowingSelectView.toggle()
                } label: {
                    Text("지역 선택하기")
                        .bold()
                        .frame(width: UIScreen.main.bounds.width - 30, height: 52)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(13)
                }
            }
        }
    }
}

//struct DetailLocationSelectView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailLocationSelectView()
//    }
//}

struct DetailLocationListItem: View {
    
    @EnvironmentObject var policyStore: PolicyStore
    
    @State private var isSelected: Bool = false
    var location: String
    @Binding var selectedLocation: [String]
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
            if selectedLocation.contains(location) {
                selectedCount -= 1
                isSelected = false
                selectedLocation.remove(at: selectedLocation.firstIndex(of: location) ?? 0)
            } else if selectedCount >= 0 {
                selectedCount += 1
                isSelected = true
                selectedLocation.append(location)
            }
            print(selectedLocation)
        }
    }
}
