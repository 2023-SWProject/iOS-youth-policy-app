//
//  PolicyDetailView.swift
//  YouthPolicyPedia
//
//  Created by 김태성 on 2023/04/29.
//

import SwiftUI

struct PolicyDetailView: View {
    var policy: Policy
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text("\(policy.title)")
                        .frame(alignment: .leading)
                        .bold()
                        .font(.system(.title))
                        .padding(.vertical, 20)
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                Rectangle()
                    .frame(width: UIScreen.main.bounds.width - 25, height: 1.5)
                    .foregroundColor(.yellow)
                    .offset(y: -20)
            }
            
            ZStack {
                HStack {
                    Spacer()
                    Text("\(policy.introduction)")
                        .font(.system(size: 13))
                    Spacer()
                }
                .padding()
                
                Rectangle()
                    .frame(width: UIScreen.main.bounds.width - 30)
                    .foregroundColor(.blue.opacity(0.1))
                    .cornerRadius(10)
            }
            
            Group {
                HStack {
                    Text("신청 기간")
                        .bold()
                    Spacer()
                }
                .padding()
                
                Text("\(policy.period)")
                    .padding()
            }
            
            Group {
                HStack {
                    Text("신청 자격")
                        .bold()
                    Spacer()
                }
                .padding()
                
                ZStack {
                    HStack {
                        VStack {
                            HStack {
                                
                                Text(" - 연령 : \(policy.reqAge)")
                                Spacer()
                            }
                            HStack {
                                Text(" - 학력 : \(policy.reqEducation)")
                                Spacer()
                            }
                            HStack {
                                Text(" - 전공 : \(policy.reqMajor)")
                                Spacer()
                            }
                            HStack {
                                Text(" - 취업 상태 : \(policy.reqEmploymentStatus)")
                                Spacer()
                            }
                            HStack {
                                Text(" - 특화 분야 : \(policy.reqSpecializedField)")
                                Spacer()
                            }
                        }
                        Spacer()
                    }
                    .padding()
                    
                    Rectangle()
                        .frame(width: UIScreen.main.bounds.width - 30)
                        .foregroundColor(.blue.opacity(0.1))
                        .cornerRadius(10)
                }
            }
            
            Group {
                HStack {
                    Text("신청 절차")
                        .bold()
                    Spacer()
                }
                .padding()
                
                HStack {
                    Image(systemName: "arrow.right")
                        .bold()
                    Text("\(policy.procedure)")
                    Spacer()
                }
                .padding()
            }
            
            Group {
                HStack {
                    Text("관련 사이트")
                        .bold()
                    Spacer()
                }
                .padding()
                
                HStack {
                    Image(systemName: "arrow.right")
                        .bold()
                    
                    if policy.siteURL.prefix(1) == "h" {
                        Button {
                            buttonAction("\(policy.siteURL)", .link)
                        } label: {
                            Text("\(policy.siteURL)")
                        }
                    } else {
                        Text("\(policy.siteURL)")
                    }
                    
                    Spacer()
                }
                .padding()
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

//struct PolicyDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        PolicyDetailView(policy: Policy(detailType: "", bizid: "", title: "지역특화 청년무역전문가 양성", introduction: "청년의 내 집 마련 지원을 위해 청약 기능에 우대금리와 비과세 혜택을 제공", type: "", content: "", reqAge: "만 18세 ~ 50세", reqEmploymentStatus: "재직자 불가", reqEducation: "제한없음", reqMajor: "제한없음", reqSpecializedField: "미적 감각이 뛰어나신 분", period: "2022.1.1. ~2022.12.31.(연중 상시)", procedure: "문화재단 직접 모집", siteURL: "https://www.cacf.or.kr/", locationCode: "", 신혼부부: "1", tags: "정책 참여"))
//    }
//}
