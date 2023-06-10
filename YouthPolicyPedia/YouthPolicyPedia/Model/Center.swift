//
//  Center.swift
//  YouthPolicyPedia
//
//  Created by 김태성 on 2023/06/09.
//

import Foundation

struct Center: Codable, Identifiable, Hashable {
    var id = UUID()
    var adress: String
    var spcid: Int
    var spcname: String
    var scrPolyBizSecd: String
    var url: String
    var imageUrl: String
}
