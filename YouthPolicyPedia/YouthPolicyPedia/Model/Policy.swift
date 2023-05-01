//
//  Policy.swift
//  YouthPolicyPedia
//
//  Created by 김태성 on 2023/04/16.
//

import Foundation

struct Policy: Codable, Identifiable {
    var id = UUID()
    var locationCode: String             // 지역일련번호         // locationCode
    var bizid: String                    // 정책 ID
//    var polybizty: String              // 기관 및 지자체 구분
    var title: String                    // 정책명              // title
//    var polyitcncn: String             // 정책소개            // introduction
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
    var siteURL: String                  //사이트 링크 주소      // url
}
