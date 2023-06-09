//
//  YouthCenterTab.swift
//  YouthPolicyPedia
//
//  Created by 김태성 on 2023/04/01.
//

import SwiftUI
import AlertToast

struct YouthCenterTab: View {
    @EnvironmentObject var policyStore: PolicyStore
    @EnvironmentObject var centerStore: CenterStore
    @State private var isShowingAlert = false
    @Binding var isShowingSelectView: Bool
    @Binding var isShowingOnboardingView: Bool
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    HStack {
                        Text("**\(policyStore.selectedLocation.first?.key ?? "")** 지역")
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
                
                // YouthCenterCell -> 센터 웹
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(centerStore.centers, id: \.self) { center in
                        CenterCellView(center: center)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink {
                        SettingView(isShowingSelectView: $isShowingSelectView, isShowingOnboardingView: $isShowingOnboardingView)
                    } label: {
                        Image(systemName: "gearshape")
                            .foregroundColor(.black)
                    }
                }
            }
            .toolbar {
                NavigationLink {
                    SearchView()
                } label: {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.black)
                }
            }
        }
    }
}

struct YouthCenterTab_Previews: PreviewProvider {
    static var previews: some View {
        YouthCenterTab(isShowingSelectView: .constant(false), isShowingOnboardingView: .constant(false))
    }
}
