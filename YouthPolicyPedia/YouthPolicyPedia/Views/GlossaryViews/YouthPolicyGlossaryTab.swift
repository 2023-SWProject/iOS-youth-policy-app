//
//  YouthPolicyGlossaryTab.swift
//  YouthPolicyPedia
//
//  Created by 김태성 on 2023/04/01.
//

import SwiftUI
import AlertToast

struct YouthPolicyGlossaryTab: View {
    let tempUrl = "https://www.youthcenter.go.kr/jynEmpEasy/jynEmpEasyDetail.do?easyPolyId=201912120001"
    @State var searchText = ""

    @Binding var isShowingSelectView: Bool
    @Binding var isShowingOnboardingView: Bool
    @State private var isShowingAlert = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(1...10, id: \.self) {_ in
//                    NavigationLink {
//                        GlossaryDetailView()
                    Button {
//                        isShowingAlert.toggle()
//                        print("업데이트 예정입니다.")
                        buttonAction("\(tempUrl)", .link)
                    } label: {
                        Rectangle()
                            .foregroundColor(.yellow.opacity(0.2))
                            .frame(width: UIScreen.main.bounds.width - 40, height: 100)
                            .cornerRadius(10)
                            .padding(10)
                            .overlay {
                                
                                HStack {
                                    AsyncImage(
                                        url: URL(string: "https://www.youthcenter.go.kr/framework/filedownload/getImage.do?filePathName=z5VpaHt9JBV54fwiQTLnrsVtvJZNROufggzoVlU5%2BHUnQ8mDcSIwbS2N7VOLI2jbvNAWNd4HUIegRaPy%2F0S6aA%3D%3D"),
                                        content: { image in
                                            image.resizable()
//                                                .aspectRatio(contentMode: .fit)
                                                .cornerRadius(10)
                                                .padding(.leading, 10)
                                                .frame(width: 130, height: 100)
                                            //                                        .frame(maxWidth: 400, maxHeight: 110)
                                        },
                                        placeholder: {
                                            ProgressView()
                                        }
                                    )
                                    
                                    VStack {
                                        Text("무급가족종사자")
                                            .padding(.top, 50)
                                            .foregroundColor(.black)

                                        HStack {
                                            Spacer()
                                            
                                            Image(systemName: "chevron.right")
                                                .foregroundColor(.blue)
                                        }
                                        .padding(.bottom, 40)
                                        .padding()
                                        
                                    }
                                    Spacer()
                                }
                                
                            }
                    }

                }
                .padding(.bottom, 30)
            }
            .navigationTitle("정책 용어 모아 보기")
            .navigationBarTitleDisplayMode(.inline)
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
//        .searchable(
//            text: $searchText,
//            placement: SearchFieldPlacement.automatic,
//            prompt: "궁금한 용어를 찾아보세요"
//        )
        
        
        .toast(isPresenting: $isShowingAlert) {
            
            // `.alert` is the default displayMode
//            AlertToast(type: .regular, title: "Message Sent!")
            
            //Choose .hud to toast alert from the top of the screen
//            AlertToast(displayMode: .hud, type: .systemImage("hare", Color.red), title: "Message Sent!")
            AlertToast(type: .image("dd", Color.red), subTitle: "추후 업데이트 예정입니다!")
        }
    }
    
    // MARK: - URL 링크용
    private enum Coordinator {
        static func topViewController(
          _ viewController: UIViewController? = nil
        ) -> UIViewController? {
          let vc = viewController ?? UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController
          
          if let navigationController = vc as? UINavigationController {
            return topViewController(navigationController.topViewController)
          } else if let tabBarController = vc as? UITabBarController {
            return tabBarController.presentedViewController != nil ?
            topViewController(
              tabBarController.presentedViewController
            ) : topViewController(
              tabBarController.selectedViewController
            )
          } else if let presentedViewController = vc?.presentedViewController {
            return topViewController(presentedViewController)
          }
          return vc
        }
      }
      
      private enum Method: String {
        case share
        case link
      }
      
      private func buttonAction(_ stringToURL: String, _ method: Method) {
        let shareURL: URL = URL(string: stringToURL)!
        
        if method == .share {
          let activityViewController = UIActivityViewController(activityItems: [shareURL], applicationActivities: nil)
          let viewController = Coordinator.topViewController()
          activityViewController.popoverPresentationController?.sourceView = viewController?.view
          viewController?.present(activityViewController, animated: true, completion: nil)
        } else {
          UIApplication.shared.open(URL(string: stringToURL)!)
        }
      }
}

struct YouthPolicyGlossaryTab_Previews: PreviewProvider {
    static var previews: some View {
        YouthPolicyGlossaryTab(isShowingSelectView: .constant(false), isShowingOnboardingView: .constant(false))
    }
}
