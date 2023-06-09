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
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
//                HStack {
//                    Capsule()
//                        .frame(width: 90, height: 27)
//                        .foregroundColor(.orange).grayscale(1.0)
//                        .overlay {
//                            HStack {
//                                Image(systemName: "location.fill")
//                                    .foregroundColor(.purple.opacity(0.8))
//                                    .padding(-5)
//                                Text(policyStore.selectedLocation.first?.key ?? "")
//                                    .foregroundColor(.white)
//                                    .font(.headline)
//                            }
//                        }
//                    Spacer()
//                }
//                .padding()
                
                VStack {
                    HStack {
                        Text("**\(policyStore.selectedDetailLocation.first?.key ?? "")** 근처")
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
                ForEach(centerStore.centers, id: \.self) { center in
                    Button {
                        buttonAction("\(center.url)", .link)
//                        isShowingAlert.toggle()
                        print("센터 웹으로 넘어간다")
                    } label: {
                        Rectangle()
                            .foregroundColor(.yellow.opacity(0.2))
                            .frame(width: UIScreen.main.bounds.width - 40, height: 120)
                            .cornerRadius(10)
                            .overlay {
                                
                                HStack {
                                    AsyncImage(
                                        url: URL(string: "https://www.youthcenter.go.kr/framework/filedownload/getImage.do?filePathName=K43kYCzEpw54N3DsTLz6bPgd%2FOPUmucKCGZDlA2w%2BAJd3lxlxhKZVaY6cVGLvIKxIAbgyajbMvnaT5yo8VVeEg%3D%3D"),
                                        content: { image in
                                            image.resizable()
    //                                            .aspectRatio(contentMode: .fit)
                                                .cornerRadius(10)
                                                .padding(7)
                                                .frame(width: 150, height: 115)
                                            //                                        .frame(maxWidth: 400, maxHeight: 110)
                                        },
                                        placeholder: {
                                            ProgressView()
                                        }
                                    )
                                    
                                    VStack {
                                        Text("\(center.spcname)")
                                            .padding(.top, 50)
                                            .foregroundColor(.blue)
                                        
                                        HStack {
                                            Text("운영시간")
                                                .foregroundColor(.black)
                                            Text("08:00 - 18:00")
                                                .foregroundColor(.secondary)
                                                .padding(.top, 1)
                                        }
                                        
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
                .padding(.bottom, 10)
            }
//            .toast(isPresenting: $isShowingAlert) {
//                AlertToast(type: .image("dd", Color.red), subTitle: "추후 업데이트 예정입니다!")
//            }
//            .navigationTitle("청년 센터")
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

struct YouthCenterTab_Previews: PreviewProvider {
    static var previews: some View {
        YouthCenterTab(isShowingSelectView: .constant(false), isShowingOnboardingView: .constant(false))
    }
}
