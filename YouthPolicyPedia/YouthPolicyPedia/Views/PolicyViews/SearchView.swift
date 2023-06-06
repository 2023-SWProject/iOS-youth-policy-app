//
//  SearchView.swift
//  YouthPolicyPedia
//
//  Created by 김태성 on 2023/06/06.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var policyStore: PolicyStore
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State private var searchText = ""
    
    var searchResults: [Policy] {
        if searchText.isEmpty {
            return []
        } else {
            // 타이틀 검색
            let title = policyStore.policies.filter { p in
                p.title.lowercased().hasPrefix(searchText.lowercased())
            }
            .map { $0 }
            
            // 소개로 검색
            let introduction = policyStore.policies.filter { p in
                p.introduction.lowercased().hasPrefix(searchText.lowercased())
            }
            .map { $0 }
            
            // all searches
            return title + introduction
        }
    }

    var body: some View {
        ScrollView {
            ForEach(searchResults) { result in
                    NavigationLink {
                        PolicyDetailView(policy: result)
                    } label: {
                        HStack{
                            Image(systemName: "magnifyingglass")
                            Text("\(result.title)")
                                .font(.system(size: 16))
                                .lineLimit(1)
                            Spacer()
                            Image(systemName: "arrow.up.right")
                            
                        }
                        .foregroundColor(.black)
                        .padding()
                    }
                }
        }
        .navigationTitle("정책 검색")
        .navigationBarTitleDisplayMode(.inline)
        .searchable(
            text: $searchText,
            placement: SearchFieldPlacement.navigationBarDrawer(displayMode: .always),
            prompt: "정책을 찾아보세요"
        )
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    self.mode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                }
                .foregroundColor(.black)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
