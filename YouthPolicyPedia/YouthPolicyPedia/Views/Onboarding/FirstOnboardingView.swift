//
//  FirstOnboardingView.swift
//  YouthPolicyPedia
//
//  Created by 김태성 on 2023/04/29.
//

import SwiftUI

struct FirstOnboardingView: View {
    @Binding var isShowingOnboardingView: Bool
    let onboardingText = OnboardingText()
    
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    @State private var counter = 0
    
    var body: some View {
        VStack {
            Spacer()
            Text(onboardingText.header[counter])
                .bold()
                .font(.system(size: 27))
                .animation(.easeIn)
            
            Spacer()
            
            Text("\(onboardingText.bodyHeader[counter])")
                .foregroundColor(.gray)
                .font(.system(size: 15))
                .animation(.easeIn)
            
            Text("\(onboardingText.body[counter])")
                .font(.system(size: 20))
                .bold()
                .animation(.easeIn)
            
            Spacer()
            
            ForEach(1..<4) {_ in
                Rectangle()
                    .foregroundColor(.gray.opacity(0.2))
                    .frame(width: UIScreen.main.bounds.width - 100, height: 70)
                    .cornerRadius(15)
                    .overlay {
                        HStack {
                            Image(systemName: "hare")
                                .padding(.leading, 50)
                            Spacer()
                            VStack {
                                Text("청년희망키움통장")
                                    .foregroundColor(.gray)
                                    .font(.footnote)
                                Text("최대 538,000원")
                                    .bold()
                            }
                            Spacer()
                        }
                    }
            }
            
            Spacer()
            
            Button {
                UserDefaults.standard.set(false, forKey: "isShowingOnboardingView")
                isShowingOnboardingView.toggle()
            } label: {
                Text("지금 시작하기")
                    .bold()
                    .frame(width: UIScreen.main.bounds.width - 30, height: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(13)
            }
            .padding()
            
            .onReceive(timer) { time in
                if counter == 2 {
//                    timer.upstream.connect().cancel()]
                    print("The time is now \(time)")
                    counter = 0
                } else {
                    print("The time is now \(time)")
                    counter += 1
                }
            }
        }
    }
}

//struct FirstOnboardingView_Previews: PreviewProvider {
//    static var previews: some View {
//        FirstOnboardingView()
//    }
//}
