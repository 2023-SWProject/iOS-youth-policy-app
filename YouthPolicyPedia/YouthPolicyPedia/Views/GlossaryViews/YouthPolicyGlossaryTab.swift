//
//  YouthPolicyGlossaryTab.swift
//  YouthPolicyPedia
//
//  Created by 김태성 on 2023/04/01.
//

import SwiftUI
import AlertToast

struct YouthPolicyGlossaryTab: View {
//    let tempUrl = "https://www.youthcenter.go.kr/jynEmpEasy/jynEmpEasyDetail.do?easyPolyId=202010200003"
//    @State var searchText = ""

    @Binding var isShowingSelectView: Bool
    @Binding var isShowingOnboardingView: Bool
//    @State private var isShowingAlert = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(0..<termNames.count, id: \.self) { i in
                    NavigationLink(destination: MyWebView(urlToLoad: "\(termUrls[i])")) {
                        Rectangle()
                            .foregroundColor(.yellow.opacity(0.2))
                            .frame(width: UIScreen.main.bounds.width - 40, height: 50)
                            .cornerRadius(10)
                            .overlay {
                                HStack {
                                    HStack {
                                        Text("\(termNames[i])")
//                                            .padding(.top, 100)
                                            .foregroundColor(.black)
                                            .padding(.leading, 20)

                                        Spacer()
                                            
                                            Image(systemName: "chevron.right")
                                                .foregroundColor(.black)
                                        .padding()
                                    }
                                    Spacer()
                                }
                            }
                    }
                    
//                    NavigationLink {
//                        GlossaryDetailView()
//                    Button {
////                        isShowingAlert.toggle()
////                        print("업데이트 예정입니다.")
//                        buttonAction("\(termUrls[i])", .link)
//                    } label: {
//                        Rectangle()
//                            .foregroundColor(.yellow.opacity(0.2))
//                            .frame(width: UIScreen.main.bounds.width - 40, height: 50)
//                            .cornerRadius(10)
//                            .overlay {
//                                
//                                HStack {
//                                    HStack {
//                                        Text("\(termNames[i])")
////                                            .padding(.top, 100)
//                                            .foregroundColor(.black)
//                                            .padding(.leading, 20)
//
//                                        Spacer()
//                                            
//                                            Image(systemName: "chevron.right")
//                                                .foregroundColor(.black)
//                                        .padding()
//                                        
//                                    }
//                                    Spacer()
//                                }
//                                
//                            }
//                    }

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
                    TermSearchView()
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
        
        
//        .toast(isPresenting: $isShowingAlert) {
            
            // `.alert` is the default displayMode
//            AlertToast(type: .regular, title: "Message Sent!")
            
            //Choose .hud to toast alert from the top of the screen
//            AlertToast(displayMode: .hud, type: .systemImage("hare", Color.red), title: "Message Sent!")
//            AlertToast(type: .image("dd", Color.red), subTitle: "추후 업데이트 예정입니다!")
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

struct YouthPolicyGlossaryTab_Previews: PreviewProvider {
    static var previews: some View {
        YouthPolicyGlossaryTab(isShowingSelectView: .constant(false), isShowingOnboardingView: .constant(false))
    }
}
