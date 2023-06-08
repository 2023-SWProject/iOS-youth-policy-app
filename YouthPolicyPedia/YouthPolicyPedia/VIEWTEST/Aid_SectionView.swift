//
//  Aid_SectionView.swift
//  YouthPolicyPedia
//
//  Created by 김태성 on 2023/06/08.
//

import SwiftUI

enum Flavor: String, CaseIterable, Identifiable {
    case 초콜릿
    case 바닐라
    case 딸기
    
    var id: String { self.rawValue }
}

struct Aid_SectionView: View {
    @State private var selectedFlavor = Flavor.초콜릿
    var body: some View {
        
        VStack {
            Picker("Flavor", selection: $selectedFlavor) {
                Text("초콜릿").tag(Flavor.초콜릿)
                Text("바닐라").tag(Flavor.바닐라)
                Text("딸기").tag(Flavor.딸기)
            }
            Text("선택한 시럽 : \(selectedFlavor.rawValue) 시럽")
        }
    }
}

struct Aid_SectionView_Previews: PreviewProvider {
    static var previews: some View {
        Aid_SectionView()
    }
}
