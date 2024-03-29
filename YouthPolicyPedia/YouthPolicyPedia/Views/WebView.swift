//
//  WebView.swift
//  YouthPolicyPedia
//
//  Created by 김태성 on 2023/08/05.
//

import SwiftUI
import WebKit

struct MyWebView: UIViewRepresentable {
    var urlToLoad: String
    
    //ui view 만들기
    func makeUIView(context: Context) -> WKWebView {
        
        //unwrapping
        guard let url = URL(string: self.urlToLoad) else {
            return WKWebView()
        }
        //웹뷰 인스턴스 생성
        let webView = WKWebView()
        
        //웹뷰를 로드한다
        webView.load(URLRequest(url: url))
        return webView
    }
    
    //업데이트 ui view
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<MyWebView>) {
        
    }
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        MyWebView(urlToLoad: "https://www.naver.com")
    }
}
