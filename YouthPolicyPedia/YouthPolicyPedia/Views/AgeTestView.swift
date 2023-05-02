//
//  AgeTestView.swift
//  YouthPolicyPedia
//
//  Created by 김태성 on 2023/05/02.
//

import SwiftUI

class MoneyStore: ObservableObject {
    let date: Date
    let dateFormatter: DateFormatter
    
    init() {
        date = Date()
        dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        dateFormatter.dateFormat = "yyyy"
    }
    lazy var 이달의마지막일 = dateFormatter.string(from: Date())
    lazy var 오늘연도 = dateFormatter.string(from: Date())
}



struct AgeTestView: View {
    @State private var myAgeYear = "1"
//    var myYear = 1998
    var body: some View {
        VStack {
            TextField("1", text: $myAgeYear)
            Text("\(Int(MoneyStore().오늘연도)! - (Int(myAgeYear) ?? 1000))")
        }
    }
}

struct AgeTestView_Previews: PreviewProvider {
    static var previews: some View {
        AgeTestView()
    }
}
