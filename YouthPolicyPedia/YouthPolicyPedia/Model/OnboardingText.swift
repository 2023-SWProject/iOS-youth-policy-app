//
//  OnboardingText.swift
//  YouthPolicyPedia
//
//  Created by 김태성 on 2023/04/29.
//

import Foundation

struct OnboardingText {
    let header: [String] = [
        " 내가 받을 수 있는\n정부지원금은 얼마일까요?",
        " 내가 이용할 수 있는\n청년공간은 어디일까요?",
        " 내가 놓치고 있는\n청년정책은 몇개일까요?"
    ]
    
    let bodyHeader: [String] = [
        "내 예상 지원금",
        "예상 공간 개수",
        "내 맞춤 정책"
    ]
    
    let body: [String] = [
        "? 만원",
        "? 곳",
        "? 개"
    ]
    
    let exampleLottie: [String] = ["Lego", "Bus", "Pig"]
    let exampleTitle: [String] = ["청년키움통장", "버스비환급정책", "학자금지원"]
    let exampleMoney: [String] = ["최대 538,000원", "최대 300,000원", "최대 1,000,000원"]
}
