//
//  Policy.swift
//  YouthPolicyPedia
//
//  Created by 김태성 on 2023/04/16.
//

import Foundation

struct Policy: Codable, Identifiable {
    var id = UUID()
    var detailType: String               // 세부 정책 유형         // detailType
    var bizid: String                    // 정책 ID
//    var polybizty: String              // 기관 및 지자체 구분
    var title: String                    // 정책명              // polybizsjnm
    var introduction: String             // 정책소개            //  polyitcncn
    var type: String                     // 정책유형            // type
//    var sporscvl: String               // 지원규모            // scale
    var content: String                  // 지원내용            // content
    var reqAge: String                   // 참여요건 - 연령      // Requirements - Age
    var reqEmploymentStatus: String      // 참여요건 - 취업상태   // Requirements - employmentStatus
    var reqEducation: String             // 참여요건 - 학력      // Requirements - Education
    var reqMajor: String                 // 참여요건 - 전공      // Requirements - Major
    var reqSpecializedField: String      // 참여요건 - 특화분야   // Requirements - SpecializedField
//    var cnsgnmor: String               // 신청기관명          // organizationName
    var period: String                   // 신청기간           // Application period
    var procedure: String                // 신청절차           // procedure
//    var jdgnprescn: String             // 심사발표           // announcement
    var siteURL: String                  // 사이트 링크 주소      // url
    var locationCode: String             // 지역 코드
    
    
    var 신혼부부: String                   // 신혼부부 | "1" -> 맞음 | "-" -> 아님 |
    var tags: String               // [태그] plcytpnm
    var 일인가구: String
    var 농업인: String
    var 소상공인: String
    var 차상위계층: String
    var 기초생활및생계급여: String
    var 무주택자: String
}

// tags
//생활·복지
//정책참여
//주거·금융
//주거·금융,생활·복지
//창업지원
//창업지원,주거·금융
//취업지원
//코로나19
