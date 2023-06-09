//
//  PolicyCellView.swift
//  YouthPolicyPedia
//
//  Created by 김태성 on 2023/06/09.
//

import SwiftUI

struct PolicyCellView: View {
    var policy: Policy
    var body: some View {
        VStack(spacing: 8) {
            Spacer()
            
            Text("\(policy.title)")
                .font(.headline)
                .foregroundColor(.black)
                .lineLimit(3)
                .padding(.horizontal, 10)
            
            Spacer()
            
            Text("\(policy.tags)")
                .font(.subheadline)
                .foregroundColor(.gray)
                .lineLimit(2)
                .padding(.bottom, 10)
        }
        .frame(width: 130, height: 150)
        .background(Color(red: 0.9, green: 0.95, blue: 1.0))
        .cornerRadius(8)
        .shadow(color: Color.gray.opacity(0.4), radius: 4, x: 0, y: 2)
    }
}

struct PolicyCellView_Previews: PreviewProvider {
    static var previews: some View {
        PolicyCellView(policy: Policy(detailType: "", bizid: "", title: "지역특화 청년무역전문가 양성", introduction: "청년의 내 집 마련 지원을 위해 청약 기능에 우대금리와 비과세 혜택을 제공", type: "", content: "", reqAge: "만 18세 ~ 50세", reqEmploymentStatus: "재직자 불가", reqEducation: "제한없음", reqMajor: "제한없음", reqSpecializedField: "미적 감각이 뛰어나신 분", period: "2022.1.1. ~2022.12.31.(연중 상시)", procedure: "문화재단 직접 모집", siteURL: "https://www.cacf.or.kr/", locationCode: "", 신혼부부: "1", tags: "정책 참여", 일인가구: "", 농업인: "", 소상공인: "", 차상위계층: "", 기초생활및생계급여: "", 무주택자: ""))
    }
}
