//
//  CenterSearchView.swift
//  YouthPolicyPedia
//
//  Created by 김태성 on 2023/06/10.
//

import SwiftUI

struct CenterSearchView: View {
    @EnvironmentObject var centerStore: CenterStore
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State private var searchText = ""
    
    var searchResults: [Center] {
        if searchText.isEmpty {
            return []
        } else {
            // 타이틀 검색
            let title = centerStore.centers.filter { p in
                p.spcname.lowercased().contains(searchText.lowercased())
            }
            .map { $0 }

            // all searches
            return title
        }
    }

    var body: some View {
        ScrollView {
            ForEach(searchResults) { result in
                    Button {
                        buttonAction("\(result.url)", .link)
                    } label: {
                        HStack{
                            Image(systemName: "magnifyingglass")
                            Text("\(result.spcname)")
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
        .navigationTitle("센터 검색")
        .navigationBarTitleDisplayMode(.inline)
        .searchable(
            text: $searchText,
            placement: SearchFieldPlacement.navigationBarDrawer(displayMode: .always),
            prompt: "청년 센터를 찾아보세요"
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

struct CenterSearchView_Previews: PreviewProvider {
    static var previews: some View {
        CenterSearchView()
    }
}
