//
//  CenterCellView.swift
//  YouthPolicyPedia
//
//  Created by 김태성 on 2023/06/09.
//

import SwiftUI

struct CenterCellView: View {
    var center: Center
    var body: some View {
        HStack {
            NavigationLink(destination: MyWebView(urlToLoad: "\(center.url)")) {
                VStack {
                    ZStack {
                        AsyncImage(
                            url: URL(string: center.imageUrl),
                            content: { image in
                                image.resizable()
                                    .cornerRadius(10)
                                    .frame(maxWidth: 400, maxHeight: 110)
                            },
                            placeholder: {
                                ProgressView()
                            }
                        )
                            .frame(width: 150, height: 110)
                            .cornerRadius(10)
                            .zIndex(1)
                            .background(
                                RoundedRectangle(cornerRadius: 10.0)
                                    .fill(Color.white)
                                    .shadow(radius: 3, x: 1, y: 1)
                            )
                        
                        Rectangle()
                            .foregroundColor(Color("jhColor").opacity(0.8))
                            .frame(width: 150, height: 110)
                            .cornerRadius(10)
                            .padding(.top, 100)

                        Text("\(center.spcname)") // name
                            .lineLimit(2)
                            .foregroundColor(.black)
                            .bold()
                            .font(.system(size: 16))
                            .zIndex(2)
                            .padding(.top, 150)
                            .frame(maxWidth: 150)
                    }
                }
                .overlay(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.clear, Color("jhColor").opacity(0.4), Color.clear]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .opacity(0.3)
                    .cornerRadius(8)
                )
            }
            
//            Button {
//                buttonAction("\(center.url)", .link)
//            } label: {
//                VStack {
//                    ZStack {
//                        AsyncImage(
//                            url: URL(string: center.imageUrl),
//                            content: { image in
//                                image.resizable()
//                                    .cornerRadius(10)
//                                    .frame(maxWidth: 400, maxHeight: 110)
//                            },
//                            placeholder: {
//                                ProgressView()
//                            }
//                        )
//                            .frame(width: 150, height: 110)
//                            .cornerRadius(10)
//                            .zIndex(1)
//                            .background(
//                                RoundedRectangle(cornerRadius: 10.0)
//                                    .fill(Color.white)
//                                    .shadow(radius: 3, x: 1, y: 1)
//                            )
//                        
//                        Rectangle()
//                            .foregroundColor(Color("jhColor").opacity(0.8))
//                            .frame(width: 150, height: 110)
//                            .cornerRadius(10)
//                            .padding(.top, 100)
//
//                        Text("\(center.spcname)") // name
//                            .lineLimit(2)
//                            .foregroundColor(.black)
//                            .bold()
//                            .font(.system(size: 16))
//                            .zIndex(2)
//                            .padding(.top, 150)
//                            .frame(maxWidth: 150)
//                    }
//                }
//                .overlay(
//                    LinearGradient(
//                        gradient: Gradient(colors: [Color.clear, Color("jhColor").opacity(0.4), Color.clear]),
//                        startPoint: .topLeading,
//                        endPoint: .bottomTrailing
//                    )
//                    .opacity(0.3)
//                    .cornerRadius(8)
//                )
//            }
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


//struct CenterCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        CenterCellView()
//    }
//}
