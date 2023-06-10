//
//  TermCellView.swift
//  YouthPolicyPedia
//
//  Created by 김태성 on 2023/06/10.
//

import SwiftUI

struct TermCellView: View {
    var term: [String]
    
    var body: some View {
        VStack {
            Text("\(term[0])")
        }
    }
}

struct TermCellView_Previews: PreviewProvider {
    static var previews: some View {
        TermCellView(term: ["name"])
    }
}
